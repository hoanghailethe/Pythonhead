<!DOCTYPE HTML>
<html lang="en">
		<head>
		<meta charset="utf-8" />
		<meta name="description" content="Web development" />
		<meta name="keywords" content="Registration Form" />
		<meta name="author" content="put your name here" />
		<link href="../Desktop/important/tooltip.css" rel="stylesheet" type="text/css">
		<link href="../Desktop/important/regform_desktop" rel="stylesheet" type="text/css">
		<script src="../Desktop/important/tooltip.js"></script>
		<title>Web Development Registration Form</title>
		</head>
		<body>
		<form method="post" action=" http://mercury.swin.edu.au/it000000/cos10005/formtest.php">
		<p>Account Information</p>
		<p>
		<label for="sid" >User ID</label>
		<input type="text" name="sid" id="sid" />
		<span id="sidTip" class="tooltip">Student ID</span>
		</p>
		<p>
		<label for="pwd1">Password</label>
		<input type="password" name="pwd1" id="pwd1" />
		</p>
		<p>
		<label for="pwd2">Retype Password</label>
		<input type="password" name="pwd2" id="pwd2" />
		</p>
		<p>User Information</p>
		<p>
		<label for="username">Name</label>
		<input type="text" name="username" id="username" />
		</p>
		<fieldset>
		<legend>Gender</legend>
		<label for="genderM">Male</label>
		<input type="radio" name="gender" value="M" id="genderM" />
		<label for="genderF">Female</label>
		<input type="radio" name="gender" value="F" id="genderF"/>
		</fieldset>
		<p>
		<input type="submit" value="Test Register" />
		</p>
		</form>
		<?php
			echo "My first PHP script!"; 
        ?> 
		</body>
		</html>