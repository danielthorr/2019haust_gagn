<?php 

  $courses = fetchAll("GetAllCourses", $conn);

?>

<div class="sub" style="display:flex;">
  <?php
    $stCourses = getRowByStId("GetStudentCourses", $stID, $conn);
    ?>

    <?php
      if (isset($_GET["type"]) && $_GET["type"] == "info") {
        echo ("<table>
            <tr>
              <th>Current Courses</th>
              <th>Previous Courses</th>
            </tr>");
        foreach ($stCourses as $course) {
          echo "<tr>";
          if ($course[1] == 0) {
            echo "<td>$course[0]</td><td></td>";
          }
          else {
            echo "<td></td><td>$course[0]</td>";
          }
          echo "</tr>";
        }
        echo "</table>";
      }
    ?>
</div>

<div class="sub">
  <table style="overflow-y: scroll;">
    <tr>
      <th>Course number</th>
      <th>Course name</th>
      <th>Course credits</th>
    </tr>
    <?php
      foreach($courses as $course) {
        echo ("
        <tr>
          <td>$course[0]</td>
          <td>$course[1]</td>
          <td>$course[2]</td>
        </tr>
        ");
      }
    ?>
</div>