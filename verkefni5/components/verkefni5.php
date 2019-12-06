<?php 

  // Ég ákvað að setja skipunina hér í staðinn fyrir í sér php skjal
  // vegna þess að þetta verkefni er bætt við ofan á hitt og ég vildi aðskilja það betur
  if (isset($_GET["type"]) && $_GET["type"] == "info") {
    $stmt = $conn->prepare("call ElectedCourses(?);");
    $stmt->bind_param("i", $stID);
    if (!$stmt->execute()) {
      echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
    }
    $res = $stmt->get_result();
    $elCourses = $res->fetch_all();
    $res->close();
    unset($stmt);
    $elCourses = explode("::", $elCourses[0][0]);
  }

?>


<div class="sub">
  <p>Elected courses demo.</p> 
  <p>Veljið nemanda og smellið á "Fetch" takkann hér að ofan.</>
  
  <form action="components/process.php?type=edit" method="post" >
    <?php 
      if (isset($elCourses)) {
        $counter = 1;
        foreach($elCourses as $crs) {
          echo "<input type='text' name='elCourse$counter' value='$crs' />";
          $counter++;
        }
        $counter--;
        echo "<input style='display:none;' type='number' name='count' value='$counter' />"; 
      }
      else {
        $counter = 1;
        while ($counter < 6) {
          echo "<input type='text' name='elCourse$counter' value='' />";
          $counter++;
        }
        $counter--;
        echo "<input style='display:none;' type='number' name='count' value='$counter' />"; 
      }
    ?>
    <input style="display:none" type="text" name="stID" value=<?php echo "$stID"; ?> /> 
    <input type="submit" name="submit" value="assign" />
  </form>

</div>
