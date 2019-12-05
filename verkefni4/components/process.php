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
  $stmt = $conn->prepare("call NewStudent(?, ?, STR_TO_DATE(?, '%Y-%m-%d'), ?)");
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
exit;
?>