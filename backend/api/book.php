<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../config.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['hotel_id']) || !isset($data['checkin']) || !isset($data['checkout'])) {
    echo json_encode(['success' => false, 'message' => 'Missing required fields']);
    exit;
}

$hotel_id = (int)$data['hotel_id'];
$checkin = $conn->real_escape_string($data['checkin']);
$checkout = $conn->real_escape_string($data['checkout']);
$guests = isset($data['guests']) ? (int)$data['guests'] : 1;
$room_type = isset($data['room_type']) ? $conn->real_escape_string($data['room_type']) : 'standard';
$requests = isset($data['requests']) ? $conn->real_escape_string($data['requests']) : '';
$user_id = 1; // For demo - get from session in real app

$sql = "INSERT INTO bookings (user_id, hotel_id, checkin, checkout, guests, room_type, requests, status, created_at) 
        VALUES ($user_id, $hotel_id, '$checkin', '$checkout', $guests, '$room_type', '$requests', 'pending', NOW())";

if ($conn->query($sql)) {
    echo json_encode([
        'success' => true,
        'message' => 'Booking confirmed!',
        'booking_id' => $conn->insert_id
    ]);
} else {
    echo json_encode(['success' => false, 'message' => 'Booking failed: ' . $conn->error]);
}

$conn->close();
?>