<?php 

  //$_SESSION["type"]

  require_once "./components/connection.php";

  require_once "./components/helpersandfunctions.php";

?>
<!DOCTYPE HTML>
<html lang="en">
<head>
  <title>2019Haust_Gagn</title>
  <link rel="stylesheet" type="text/css" href="style.css" />
</head>
<body>
  <h2><a href="index.php">back</a></h2>
  <h4><a href="students.php">reset</a></h4>
  <div class="row">
    <?php include "components/studentcomp.php"; ?>
  </div>
  <div class="row">
    <?php include "components/coursecomp.php"; ?>
  </div>
</body>
</html>