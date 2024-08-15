import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';

class PdfGenerator {
  static Future<Uint8List> generateRepairPdf({
    required String customerName,
    required List<CheckoutItem> selectedOptions,
  }) async {
    final pdf = pw.Document();
    final currentDate = DateFormat.yMMMMd().format(DateTime.now());

    final totalPrice =
        selectedOptions.fold<double>(0, (sum, item) => sum + item.price);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(32),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Daily Phones',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      currentDate,
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Dear $customerName,',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  'Thank you for choosing Daily Phones. Below is the detailed repair invoice for your selected options.',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 24),
                pw.Text(
                  'Selected Repair Options:',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Option',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(
                            'Price',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    ...selectedOptions.map(
                      (option) => pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(option.name),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8),
                            child: pw.Text(
                              '\$${option.price.toStringAsFixed(2)}',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 24),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 24),
                pw.Text(
                  'We appreciate your trust in our services. If you have any questions or require further assistance, please do not hesitate to contact us.',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 16),
                pw.Text(
                  'Sincerely,',
                  style: const pw.TextStyle(fontSize: 14),
                ),
                pw.Text(
                  'Daily Phones',
                  style: const pw.TextStyle(fontSize: 14),
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
