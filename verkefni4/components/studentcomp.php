<?php 

  $stID = "";
  $fName = "";
  $lName = "";
  $DOB = "";
  $semName = "";

  $students = fetchAll("GetAllStudents", $conn);
?>

<div class="sub">
  <form action="students.php?type=info" method="post">
    <label for="studentInfo">Nánari upplýsingar</label>
    <select name="studentInfo">
      <?php
        foreach ($students as $student) {
          echo("<option value='$student[0]'>$student[1]</option>");
        }
      ?>
    </select>
    <input type="submit" value="Fetch"/>
  </form>
  <?php
    if (isset($_GET["type"]) && $_GET["type"] == "info") {
      echo("
        <table>
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Date of birth</th>
            <th>Semester</th>
          </tr>
      ");
      $stInfo = getRowByStID("GetStudent", $_POST["studentInfo"], $conn);
      $stID = $stInfo[0][0];
      $fName = $stInfo[0][1];
      $lName = $stInfo[0][2];
      $DOB = $stInfo[0][3];
      $semName = $stInfo[0][4];
      echo ("
        <tr>
          <td>$fName</td>
          <td>$lName</td>
          <td>$DOB</td>
          <td>$semName</td>
        </tr>
      ");
      echo "</table>";
    }
  ?>
  <div>
    <form action="components/process.php?type=edit" method="post">
      <label>ID</label>
      <input type="text" name="stID" value="<?php echo $stID ?>" /><br/>
      <label>First name</label>
      <input type="text" name="fName" value="<?php echo $fName ?>" /><br/>
      <label>Last name</label>
      <input type="text" name="lName" value="<?php echo $lName ?>" /><br />
      <label>Date of birth</label>
      <input type="text" name="dOfBirth" value="<?php echo $DOB ?>" /><br />
      <label>Semester</label>
      <input type="text" name="semName" value="<?php echo $semName ?>" /><br />
      <input type="submit" name="submit" value="create"/>
      <input type="submit" name="submit" value="update"/>
      <input type="submit" name="submit" value="delete"/>
    </form> 
  </div>
</div>
<div class="sub">
  <table style="overflow-y: scroll;">
    <tr>
      <th>ID</th>
      <th>First name</th>
      <th>Last name</th>
      <th>DOB</th>
      <th>Semester</th>
    </tr>
    <?php
      foreach($students as $student) {
        echo ("
        <tr>
          <td>$student[0]</td>
          <td>$student[1]</td>
          <td>$student[2]</td>
          <td>$student[3]</td>
          <td>$student[4]</td>
        </tr>
        ");
      }
    ?>
  </table>
</div>