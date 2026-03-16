<?php
header('Content-Type: application/json');

// Configuration
$to = 'hosek.aerospace@gmail.com';
$subject_prefix = 'New Inquiry from Website';

// Get JSON input
$input = json_decode(file_get_contents('php://input'), true);

// If no JSON, try form data
if (!$input) {
    $input = $_POST;
}

// Validate required fields
$name = isset($input['name']) ? trim($input['name']) : '';
$email = isset($input['email']) ? trim($input['email']) : '';
$company = isset($input['company']) ? trim($input['company']) : '';
$message = isset($input['message']) ? trim($input['message']) : '';

if (!$name || !$email || !$message) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Missing required fields']);
    exit;
}

// Validate email
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Invalid email address']);
    exit;
}

// Build email
$subject = $subject_prefix . ' - ' . $name;
$body = "Name: $name\n";
$body .= "Email: $email\n";
$body .= "Company: $company\n\n";
$body .= "Message:\n$message\n";

$headers = "From: noreply@hosek-aerospace.com\r\n";
$headers .= "Reply-To: $email\r\n";
$headers .= "Content-Type: text/plain; charset=UTF-8\r\n";

// Send email
$sent = mail($to, $subject, $body, $headers);

if ($sent) {
    echo json_encode(['success' => true, 'message' => 'Thank you! Your message has been sent.']);
} else {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Failed to send email']);
}
?>