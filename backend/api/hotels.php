<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

require_once '../config.php';

$sql = "SELECT id, name, location, price, image, rating FROM hotels ORDER BY id DESC";
$result = $conn->query($sql);

$hotels = [];
while ($row = $result->fetch_assoc()) {
    $hotels[] = $row;
}

echo json_encode($hotels);

$conn->close();
?>