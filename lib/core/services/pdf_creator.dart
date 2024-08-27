import 'package:daily_phones/core/res/helper_functions.dart';
import 'package:daily_phones/src/repair/domain/entities/checkout_item.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerator {
  const PdfGenerator._();

  static Future<Uint8List> generateOfferPdf({
    required String customerName,
    required List<CheckoutItem> selectedOptions,
  }) async {
    final pdf = pw.Document();
    final currentDate = DateFormat.yMMMMd().format(DateTime.now());
    final totalPrice = getTotal(selectedOptions);

    // Load the custom font
    final fontData = await rootBundle.load('assets/fonts/Poppins-Medium.ttf');
    final ttf = pw.Font.ttf(fontData);

    // Define a clean and professional color palette
    const primaryColor = PdfColors.black;
    const secondaryColor = PdfColors.grey900;
    const tableHeaderColor = PdfColors.grey300;
    const tableRowColor = PdfColors.grey100;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Daily Phones',
                      style: pw.TextStyle(
                        fontSize: 28,
                        fontWeight: pw.FontWeight.bold,
                        font: ttf,
                        color: primaryColor,
                      ),
                    ),
                    pw.Text(
                      currentDate,
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                        font: ttf,
                      ),
                    ),
                  ],
                ),
                pw.Divider(color: secondaryColor, thickness: 1),
                pw.SizedBox(height: 16),

                // Greeting
                pw.Text(
                  'Dear $customerName,',
                  style: pw.TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                    font: ttf,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Thank you for choosing Daily Phones. Below is the detailed repair invoice for your selected options.',
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: secondaryColor,
                    font: ttf,
                  ),
                ),
                pw.SizedBox(height: 24),

                // Table Header
                pw.Text(
                  'Selected Repair Options:',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    font: ttf,
                    color: primaryColor,
                  ),
                ),
                pw.SizedBox(height: 12),

                // Options Table
                pw.Table(
                  border: const pw.TableBorder(
                    horizontalInside: pw.BorderSide(color: tableHeaderColor),
                  ),
                  children: [
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(color: tableHeaderColor),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Option',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Price',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...selectedOptions.map(
                      (option) => pw.TableRow(
                        decoration: pw.BoxDecoration(
                          color: selectedOptions.indexOf(option) % 2 == 0
                              ? PdfColors.white
                              : tableRowColor,
                        ),
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              option.name,
                              style: const pw.TextStyle(fontSize: 12),
                            ),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              '€ ${option.price.toStringAsFixed(2)}',
                              style: pw.TextStyle(font: ttf, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 15),

                // Total Price
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'Total Price:  € $totalPrice',
                    style: pw.TextStyle(
                      fontSize: 16, // Smaller size
                      fontWeight: pw.FontWeight.bold, // Still bold
                      font: ttf,
                      color: primaryColor,
                    ),
                  ),
                ),
                pw.SizedBox(height: 24),

                // Closing Remarks
                pw.Text(
                  'We appreciate your trust in our services. If you have any questions or require further assistance, please do not hesitate to contact us.',
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: secondaryColor,
                    font: ttf,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Sincerely,',
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: secondaryColor,
                    font: ttf,
                  ),
                ),
                pw.Text(
                  'Daily Phones',
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: secondaryColor,
                    font: ttf,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
