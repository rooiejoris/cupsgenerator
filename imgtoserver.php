<?php
	define('UPLOAD_DIR', 'temp/');
	if (isset($_POST['imgBase64']) && !empty($_POST['imgBase64']) ){
		$img = $_POST['imgBase64'];
		$img = str_replace('data:image/png;base64,', '', $img);
		$img = str_replace('', '+', $img);
		$data = base64_decode($img);
	}
	// $inp = file_get_contents('php://input');
	if (isset($_POST['user']) && !empty($_POST['user'])){
		$user = $_POST['user'];
	}

//spatie vervangen door _
	$user = str_replace(' ', '_', $user);
	$file = UPLOAD_DIR . $user . "_" . date('Ymd_Gis', time()) . '.png'; 
	$save = file_put_contents($file, $data); 
//	$savetemp = file_put_contents(UPLOAD_DIR . "temp.png", $data); 
	print $save ? $file : 'Unable to save the file.';

// temp uitezet voor testen
//	shell_exec('./server_make_stl_and_gcode.command');

?>
