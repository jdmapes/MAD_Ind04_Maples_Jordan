<?php
$servername = "cs.okstate.edu";
$username = "mjordan";
$password = "th!nGorilla99";
$dbname = "mjordan";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error());
}

$sql = "SELECT * FROM states";
$query = mysqli_query($conn, $sql);

$results = ['states' => $query->fetch_all(MYSQLI_ASSOC)];

echo json_encode($results);

$conn->close();

?>

