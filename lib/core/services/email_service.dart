import 'dart:convert';
import 'dart:typed_data';

import 'package:daily_phones/core/res/helper_functions.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';

class EmailService {
  String generateStyledAppointmentEmail({
    required String name,
    required String email,
    required String phone,
    required DateTime appointmentDate,
    required List<CheckoutItem> repairItems,
  }) {
    final appointmentDay = formatDay(appointmentDate);
    final formattedDate = formatDate(appointmentDate);
    final formattedTime = formatTime(appointmentDate);

    name = name.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    final totalCost = getTotal(repairItems);

    final itemRows = repairItems.map((item) {
      return '''
      <tr>
        <td>${item.name}</td>
        <td>€ ${item.price.toStringAsFixed(2)}</td>
      </tr>
    ''';
    }).join();

    return '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
      body {
          font-family: Arial, sans-serif;
          line-height: 1.6;
          color: #333;
          margin: 0;
          padding: 0;
          background-color: #f8f8f8;
          -webkit-text-size-adjust: 100%;
          -ms-text-size-adjust: 100%;
          font-size: 16px;
      }
      .container {
          margin: 20px auto;
          padding: 20px;
          max-width: 800px;
          width: 90%;
          border: 1px solid #ddd;
          border-radius: 8px;
          background-color: #fff;
          box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
          box-sizing: border-box;
      }
      .header {
          text-align: center;
          font-size: 24px;
          color: #333;
          margin-bottom: 20px;
          padding: 10px 0;
          font-weight: 700;
      }
      .appointment-details {
          color: #555;
          margin-bottom: 30px;
      }
      .appointment-details p {
          margin: 0;
          margin-top: 10px;
      }
      .appointment-details strong {
          color: #444;
      }
      .appointment-time {
          margin-top: 15px;
      }
      .section-title {
          font-size: 18px;
          font-weight: 600;
          margin: 35px 0 15px;
          color: #333;
          border-bottom: 2px solid #ddd;
          padding-bottom: 8px;
      }
      .order-summary {
          width: 100%;
          border-collapse: collapse;
          margin-top: 10px;
          text-align: left;
      }
      .order-summary th, .order-summary td {
          border: 1px solid #ddd;
          padding: 12px;
          font-size: 16px;
          color: #555;
      }
      .order-summary th {
          background-color: #f4f4f4;
          font-weight: 600;
      }
      .order-summary tr:last-child th {
          font-size: 16px;
          color: #333;
          background-color: #f4f4f4;
          border-top: 2px solid #ddd;
      }
      .footer {
          font-size: 14px;
          color: #777;
          text-align: center;
          margin-top: 40px;
          border-top: 1px solid #ddd;
          padding-top: 20px;
          line-height: 1.6;
      }
      .spaced-paragraph {
          margin-top: 20px;
      }
      @media (max-width: 600px) {
          .container {
              padding: 15px;
              margin: 10px;
              width: 95%;
          }
          .header {
              font-size: 22px;
          }
          .section-title {
              font-size: 18px;
          }
          .order-summary th, .order-summary td {
              padding: 10px;
              font-size: 14px;
          }
      }
  </style>
</head>
<body>
  <div class="container">
      <div class="header">
          Appointment Confirmation
      </div>
      <div class="appointment-details">
          <p>Dear $name,</p>
          <p class="spaced-paragraph">Thank you for making an appointment at Daily Phones | Dokkum to have your items repaired.</p>
          <p class="appointment-time">The appointment is on <strong>$appointmentDay, $formattedDate</strong>, at <strong>$formattedTime</strong>.</p>
      </div>
      <div class="section-title">Order Summary</div>
      <table class="order-summary">
          <tr>
              <th>Item</th>
              <th>Cost</th>
          </tr>
          $itemRows
          <tr>
              <th>Total</th>
              <th>€ $totalCost</th>
          </tr>
      </table>
      <div class="section-title">Customer Details</div>
      <p><strong>Name:</strong> $name</p>
      <p><strong>Email:</strong> $email</p>
      <p><strong>Phone:</strong> $phone</p>
      <p class="spaced-paragraph">Would you like to reschedule or cancel the appointment? You can do so by calling <strong>0519 347 503</strong>. You can cancel or reschedule the appointment up to 24 hours in advance at no cost. If you do not show up without canceling, a fee of 30 euros will be charged for reserving the time slot.</p>
      <div class="footer">
          <p class="spaced-paragraph">Kind regards,</p>
          <p>Daily Phones | Dokkum</p>
          <p>Waagstraat 14A, 9101 LC Dokkum</p>
          <p class="spaced-paragraph">You are receiving this email because an appointment was made with this email address on the Daily Phones | Dokkum website. This email is a confirmation of the appointment made. If you did not make this appointment yourself, please get in touch with us.</p>
      </div>
  </div>
</body>
</html>
  ''';
  }

  String formatDay(DateTime date) {
    final weekdays = <String>[
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ];
    return weekdays[date.weekday - 1];
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  String formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  static DataMap generateOfferEmailData({
    required Uint8List pdfData,
    required String name,
    required String email,
    required String senderEmail,
    required String senderName,
  }) {
    name = capitalizeName(name);

    return {
      'Messages': [
        {
          'From': {
            'Email': senderEmail,
            'Name': senderName,
          },
          'To': [
            {
              'Email': email,
              'Name': name,
            }
          ],
          'Subject': 'Your Repair Invoice from Daily Phones',
          'TextPart': 'Dear $name,\n\nThank you for choosing Daily Phones. '
              'Attached is your repair invoice. We appreciate your business'
              ' and look forward to serving you again.',
          'HTMLPart': '''
          <div style="font-family: 'Helvetica Neue', Arial, sans-serif; color: #4a4a4a; padding: 20px; background-color: #f7f7f7;">
  <div style="max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
    
    <h2 style="color: #2c3e50; font-weight: 600; margin-bottom: 20px;">Hello $name,</h2>
    
    <p style="font-size: 16px; line-height: 1.6;">
      We are delighted to have you as a valued customer at <strong style="color: #2980b9;">Daily Phones</strong>.
    </p>
    
    <p style="font-size: 16px; line-height: 1.6;">
      Attached to this email, you will find your detailed repair invoice. It outlines the selected repair services along with the associated costs.
    </p>
    
    <p style="font-size: 16px; line-height: 1.6;">
      We take pride in providing quality service, and we hope to exceed your expectations. If you have any questions or need further assistance, feel free to reach out.
    </p>
    
    <p style="font-size: 16px; line-height: 1.6; margin-top: 30px;">
      Best regards,
    </p>
    
    <p style="font-size: 16px; font-weight: bold; color: #2980b9; margin: 0;">
      The Daily Phones Team
    </p>
    
  </div>
  
  <div style="max-width: 600px; margin: 20px auto 0; text-align: center; font-size: 12px; color: #999;">
    <p>&copy; 2024 Daily Phones. All rights reserved.</p>
  </div>
</div>
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
  }

  DataMap generateAppointmentEmailData({
    required String name,
    required String email,
    required String phone,
    required DateTime appointmentDate,
    required List<CheckoutItemModel> repairItems,
    required String senderEmail,
    required String senderName,
  }) {
    final emailHtmlContent = generateStyledAppointmentEmail(
      name: name,
      email: email,
      phone: phone,
      appointmentDate: appointmentDate,
      repairItems: repairItems,
    );

    return {
      'Messages': [
        {
          'From': {
            'Email': senderEmail,
            'Name': senderName,
          },
          'To': [
            {
              'Email': email,
              'Name': name,
            }
          ],
          'Subject': 'Appointment Confirmation from Daily Phones',
          'TextPart': 'Dear $name, your appointment is confirmed.',
          'HTMLPart': emailHtmlContent,
        }
      ],
    };
  }
}
