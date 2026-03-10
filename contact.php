<?php
// Contact form handler for Hošek Aerospace Consulting
// Sends form submissions to info@hosek-aerospace.com

header('Content-Type: application/json');

// Configuration
$to = 'info@hosek-aerospace.com';
$subject_prefix = 'Consultation Request - ';

// Get POST data
$name = isset($_POST['name']) ? trim($_POST['name']) : '';
$email = isset($_POST['email']) ? trim($_POST['email']) : '';
$company = isset($_POST['company']) ? trim($_POST['company']) : '';
$subject = isset($_POST['subject']) ? trim($_POST['subject']) : 'Consultation Request';
$message = isset($_POST['message']) ? trim($_POST['message']) : '';

// Validate required fields
if (empty($name) || empty($email) || empty($message)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Please fill in all required fields.']);
    exit;
}

// Validate email
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Please enter a valid email address.']);
    exit;
}

// Build email content
$email_subject = $subject_prefix . $subject;
$email_body = "New consultation request from website\n";
$email_body .= "=====================================\n\n";
$email_body .= "Name: " . $name . "\n";
$email_body .= "Email: " . $email . "\n";
$email_body .= "Company: " . (empty($company) ? 'Not provided' : $company) . "\n";
$email_body .= "Subject: " . $subject . "\n\n";
$email_body .= "Message:\n" . $message . "\n";

// Email headers
$headers = [];
$headers[] = 'From: noreply@hosek-aerospace.com';
$headers[] = 'Reply-To: ' . $email;
$headers[] = 'X-Mailer: PHP/' . phpversion();
$headers[] = 'MIME-Version: 1.0';
$headers[] = 'Content-Type: text/plain; charset=UTF-8';

// Send email
$mail_sent = mail($to, $email_subject, $email_body, implode("\r\n", $headers));

if ($mail_sent) {
    echo json_encode(['success' => true, 'message' => 'Thank you for your message! We will get back to you soon.']);
} else {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Failed to send message. Please try again or contact us directly.']);
}
?>