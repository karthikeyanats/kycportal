<!DOCTYPE html>
<html lang="en">
<head>
<title>keyCode example</title>

<script type="text/javascript">

function showKeyCode(e) {
	alert( "keyCode for the key pressed: " + e.keyCode + "\n" );
}

</script>
</head>

<body onkeydown="showKeyCode(event);">
<p>Press any key.</p>
</body>
</html>
