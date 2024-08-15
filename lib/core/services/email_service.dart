import 'dart:convert';
import 'dart:typed_data';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EmailService {
  static Future<void> sendRepairInvoiceEmail({
    required Uint8List pdfData,
    required String name,
    required String email,
    required BuildContext context,
  }) async {
    const apiKey = '86a6c6fd07fbe092cb1fddaf4ab7f17e';
    const apiSecret = 'd28280d868a2d71e1cafb52e66490991';
    const mailjetUrl = 'https://api.mailjet.com/v3.1/send';

    final customerName =
        name[0].toUpperCase() + name.substring(1).toLowerCase();

    final emailData = {
      'Messages': [
        {
          'From': {'Email': 'hilob87225@segichen.com', 'Name': 'Daily Phones'},
          'To': [
            {
              'Email': email,
              'Name': customerName,
            }
          ],
          'Subject': 'Your Repair Invoice from Daily Phones',
          'TextPart':
              'Dear $customerName,\n\nThank you for choosing Daily Phones. Attached is your repair invoice. We appreciate your business and look forward to serving you again.',
          'HTMLPart': '''
          <h3>Dear $customerName,</h3>
          <p>Thank you for choosing <strong>Daily Phones</strong>.</p>
          <p>Attached is your repair invoice detailing the selected repair options and associated costs.</p>
          <p>We appreciate your business and look forward to serving you again.</p>
          <p>Sincerely,</p>
          <p><strong>Daily Phones</strong></p>
        ''',
          'Attachments': [
            {
              'ContentType': 'application/pdf',
              'Filename': 'repair_invoice.pdf',
              'Base64Content': base64Encode(pdfData),
            },
          ],
        }
      ],
    };

    try {
      final response = await http.post(
        Uri.parse(mailjetUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Basic ${base64Encode(utf8.encode('$apiKey:$apiSecret'))}',
        },
        body: json.encode(emailData),
      );

      if (response.statusCode == 200) {
        context.navigator.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email sent successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        context.navigator.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to send email. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
