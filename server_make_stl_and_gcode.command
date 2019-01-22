#sudo chmod +x *.command 
#starten: in terminal naar juiste map: ./server_stl_and_gcode.command
#needed a fix for meshlab 2016
#https://github.com/cnr-isti-vclab/meshlab/issues/64
#also had to change the mlx file to the new meshalb standards


BASE="/werk/_mamp/cups/temp"

cd "${BASE}"/


for FILE in $(find *.png)

do


	FILE=${FILE}
	#FILE="temp.png"


	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "${FILE}"
	echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"


	cp "${FILE}" temp.png

	echo "++++BLENDER+++++"
	#/Applications/blender-2/Blender.app/Contents/MacOS/blender ../cups.blend --background --python ../convert_blend_to_fbx.py -- temp.obj

	/Applications/blender-2.76b-OSX_10.6-x86_64/blender2.76.app/Contents/MacOS/blender ../cups.blend --background --python ../convert_blend_to_fbx.py -- temp.obj

	echo "++++MESHLAB+++++"
	#/Applications/meshlab.app/Contents/MacOS/meshlabserver -i temp.obj -o temp_small.stl #-s ../meshlab_test.mlx

	#without script
	#/Applications/meshlab.app/Contents/MacOS/meshlabserver -i temp.obj -o temp_small.stl

	#with script
	/Applications/meshlab.app/Contents/MacOS/meshlabserver -i temp.obj -o temp_small.stl -s ../meshlab.mlx

	echo "+++++CURA++++++"
	#/Applications/Cura/Cura.app/Contents/MacOS/Cura -i "${BASE}"/cups.ini -s "${BASE}"/temp_small.stl
	#/Applications/Cura/Cura.app/Contents/MacOS/Cura -i /werk/_mamp/cups/temp/cups.ini  -s /werk/_mamp/cups/temp/temp_small.stl

	/Applications/Cura/Cura.app/Contents/MacOS/Cura -i "${BASE}"/../cups.ini -s "${BASE}"/temp_small.stl
	
	
	echo "+++++MOVING FILES++++++"
	mv temp_small.stl ../stl/"${FILE%%.*}".stl
	mv temp_small.stl.gcode ../gcode/"${FILE%%.*}".gcode
	mv "${FILE}" ../png/"${FILE}"

	echo "+++++REMOVE FILES++++++"

	#rm ../stl/"${FILE%%.*}".stl
	
	rm temp.obj
	rm temp.mtl
	rm "${FILE%%.*}".png
	rm temp.png

	echo "+++++DONE++++++"


done


