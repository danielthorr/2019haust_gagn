<?php

header("Location: ../students.php");

// If the $_GET is not correct, we exit early
if (!(isset($_GET["type"])) && !($_GET["type"] == "edit")) {
  exit;
}

require_once "./connection.php";

if (isset($_POST["submit"]) && $_POST["submit"] == "update") {
  $stmt = $conn->prepare("call UpdateStudent(?, ?, ?)");
  $stmt->bind_param("iss", $_POST["stID"], $_POST["fName"], $_POST["lName"]);
  if (!$stmt->execute()) {
    echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
  }
}
else if (isset($_POST["submit"]) && $_POST["submit"] == "create") {
  $stmt = $conn->prepare("call NewStudent(?, ?, ?, ?)");
  $date = date("Y-m-d", strtotime($_POST["dOfBirth"]));
  $stmt->bind_param("ssdi", $_POST["fName"], $_POST["lName"], $date, $_POST["semName"]);
  if (!$stmt->execute()) {
    echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
  }
}
else if (isset($_POST["submit"]) && $_POST["submit"] == "delete") {
  $stmt = $conn->prepare("call DeleteStudent(?)");
  $stmt->bind_param("i", $_POST["stID"]);
  if (!$stmt->execute()) {
    echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
  }
}
else if (isset($_POST["submit"]) && $_POST["submit"] == "assign") {
  echo "1 ";
  $stmt = $conn->prepare("call AssignCourse(?, ?)");
  echo "2 ";
  $counter = $_POST["count"] * 1;
  echo "3 ";
  while ($counter > 0) {
    echo "4 ";
    $stmt->bind_param("is", $_POST["stID"], $_POST["elCourse" . $counter]);
    echo "5 ";
    if (!$stmt->execute()) {
      echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
    }
    echo "6 ";
    $counter--;
    echo "7 ";
  }
  echo "8 ";
  unset($stmt);
}
exit;
?>