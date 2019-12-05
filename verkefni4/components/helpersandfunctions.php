<?php

$errors = [];

function dbug($variable) {
  echo "<p>var_dump:</p>";
  var_dump($variable);
  echo "<p>print_r:</p>";
  print_r($variable);
}

function dbugConsole($data) {
  $output = $data;
  if (is_array($output))
      $output = implode(',', $output);

  echo "<script>console.log('Debug Objects: " . $output . "' );</script>";
}

function fetchAll($procName, $mysqli) {
  $stmt = $mysqli->prepare("call $procName");
  if (!$stmt->execute()) {
    echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
  }
  $res = $stmt->get_result();
  $returnArr = $res->fetch_all();
  $res->close();
  unset($stmt);
  return $returnArr;
}

// Get a single row by student ID
function getRowByStID($procName, $stID, $mysqli) {
  $stmt = $mysqli->prepare("call $procName(?)");
  $stmt->bind_param("i", $stID);
  if (!$stmt->execute()) {
    echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
  }
  $res = $stmt->get_result();
  $row = $res->fetch_all();
  $res->close();
  unset($stmt);
  return $row;
}
?>