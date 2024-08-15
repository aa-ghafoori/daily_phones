// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:daily_phones/src/repair/domain/entities/entities.dart';
// import 'package:daily_phones/src/repair/presentation/widgets/action_buttons.dart';
// import 'package:http/http.dart' as http;

// import 'package:daily_phones/core/common/widgets/widgets.dart';
// import 'package:daily_phones/core/res/extensions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

// class OfferForm extends StatefulWidget {
//   const OfferForm({super.key, required this.selectedItems});

//   final List<CheckoutItem> selectedItems;

//   @override
//   State<OfferForm> createState() => _OfferFormState();
// }

// class _OfferFormState extends State<OfferForm> {
//   final _formKey = GlobalKey<FormState>();

//   String name = '';
//   String email = '';

//   // Function to show an error snackbar
//   void showSnackbar(BuildContext context, String errorMessage, bool isError) {
//     final snackBar = SnackBar(
//       content: Row(
//         children: [
//           Icon(Icons.error, color: Colors.white),
//           SizedBox(width: 10),
//           Expanded(
//             child: Text(
//               errorMessage,
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: isError ? Colors.redAccent : Colors.green,
//       behavior: SnackBarBehavior.floating,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       margin:
//           EdgeInsets.symmetric(horizontal: 20, vertical: 10).copyWith(top: 20),
//       duration: Duration(seconds: 4),
//     );

//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   Future<Uint8List> generateRepairPdf({
//     required String customerName,
//     required List<CheckoutItem> selectedOptions,
//   }) async {
//     final pdf = pw.Document();
//     final String currentDate = DateFormat.yMMMMd().format(DateTime.now());

//     double totalPrice =
//         selectedOptions.fold(0.0, (sum, item) => sum + item.price);

//     pdf.addPage(
//       pw.Page(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return pw.Padding(
//             padding: const pw.EdgeInsets.all(32),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Row(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Text(
//                       'Daily Phones',
//                       style: pw.TextStyle(
//                         fontSize: 24,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                     pw.Text(
//                       currentDate,
//                       style: pw.TextStyle(fontSize: 12),
//                     ),
//                   ],
//                 ),
//                 pw.SizedBox(height: 16),
//                 pw.Text(
//                   'Dear $customerName,',
//                   style: pw.TextStyle(fontSize: 18),
//                 ),
//                 pw.SizedBox(height: 8),
//                 pw.Text(
//                   'Thank you for choosing Daily Phones. Below is the detailed repair invoice for your selected options.',
//                   style: pw.TextStyle(fontSize: 14),
//                 ),
//                 pw.SizedBox(height: 24),
//                 pw.Text(
//                   'Selected Repair Options:',
//                   style: pw.TextStyle(
//                     fontSize: 18,
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                 ),
//                 pw.SizedBox(height: 12),
//                 pw.Table(
//                   border: pw.TableBorder.all(),
//                   children: [
//                     pw.TableRow(
//                       children: [
//                         pw.Padding(
//                           padding: const pw.EdgeInsets.all(8),
//                           child: pw.Text(
//                             'Option',
//                             style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                           ),
//                         ),
//                         pw.Padding(
//                           padding: const pw.EdgeInsets.all(8),
//                           child: pw.Text(
//                             'Price',
//                             style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                     ...selectedOptions.map(
//                       (option) => pw.TableRow(
//                         children: [
//                           pw.Padding(
//                             padding: const pw.EdgeInsets.all(8),
//                             child: pw.Text(option.name),
//                           ),
//                           pw.Padding(
//                             padding: const pw.EdgeInsets.all(8),
//                             child: pw.Text(
//                               '\$${option.price.toStringAsFixed(2)}',
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 pw.SizedBox(height: 24),
//                 pw.Align(
//                   alignment: pw.Alignment.centerRight,
//                   child: pw.Text(
//                     'Total Price: \$${totalPrice.toStringAsFixed(2)}',
//                     style: pw.TextStyle(
//                       fontSize: 18,
//                       fontWeight: pw.FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 pw.SizedBox(height: 24),
//                 pw.Text(
//                   'We appreciate your trust in our services. If you have any questions or require further assistance, please do not hesitate to contact us.',
//                   style: pw.TextStyle(fontSize: 14),
//                 ),
//                 pw.SizedBox(height: 16),
//                 pw.Text(
//                   'Sincerely,',
//                   style: pw.TextStyle(fontSize: 14),
//                 ),
//                 pw.Text(
//                   'Daily Phones',
//                   style: pw.TextStyle(fontSize: 14),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );

//     return pdf.save();
//   }

//   Future<void> sendRepairInvoiceEmail({
//     required Uint8List pdfData,
//   }) async {
//     // Mailjet API credentials
//     final String apiKey = '86a6c6fd07fbe092cb1fddaf4ab7f17e';
//     final String apiSecret = 'd28280d868a2d71e1cafb52e66490991';

//     final String mailjetUrl = 'https://api.mailjet.com/v3.1/send';

//     // Constructing the email with PDF attachment

//     final customerName =
//         name[0].toUpperCase() + name.substring(1).toLowerCase();
//     final emailData = {
//       'Messages': [
//         {
//           'From': {'Email': 'hilob87225@segichen.com', 'Name': 'Daily Phones'},
//           'To': [
//             {
//               'Email': email,
//               'Name': customerName
//             } // Replace with customer's email
//           ],
//           'Subject': 'Your Repair Invoice from Daily Phones',
//           'TextPart':
//               'Dear $customerName,\n\nThank you for choosing Daily Phones. Attached is your repair invoice. We appreciate your business and look forward to serving you again.',
//           'HTMLPart': '''
//           <h3>Dear $customerName,</h3>
//           <p>Thank you for choosing <strong>Daily Phones</strong>.</p>
//           <p>Attached is your repair invoice detailing the selected repair options and associated costs.</p>
//           <p>We appreciate your business and look forward to serving you again.</p>
//           <p>Sincerely,</p>
//           <p><strong>Daily Phones</strong></p>
//         ''',
//           'Attachments': [
//             {
//               'ContentType': 'application/pdf',
//               'Filename': 'repair_invoice.pdf',
//               'Base64Content': base64Encode(pdfData),
//             },
//           ],
//         }
//       ]
//     };

//     // Sending the email via Mailjet API
//     try {
//       final response = await http.post(
//         Uri.parse(mailjetUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization':
//               'Basic ' + base64Encode(utf8.encode('$apiKey:$apiSecret')),
//         },
//         body: jsonEncode(emailData),
//       );

//       if (response.statusCode == 200) {
//         print('Email sent successfully!');
//         context.navigator.pop();
//         showSnackbar(context, 'Email Sent Successfully!', false);
//       } else {
//         print('Failed to send email: ${response.body}');
//         context.navigator.pop();
//         showSnackbar(
//             context, 'Failed to send email: Please try again later', true);
//       }
//     } catch (e) {
//       context.navigator.pop();
//       showSnackbar(context, e.toString(), true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       actions: <Widget>[
//         CustomActionButton(
//           onPressed: () async {
//             if (_formKey.currentState?.validate() ?? false) {
//               _formKey.currentState!.save();
//               final pdfData = await generateRepairPdf(
//                   customerName:
//                       name[0].toUpperCase() + name.substring(1).toLowerCase(),
//                   selectedOptions: widget.selectedItems);

//               await sendRepairInvoiceEmail(pdfData: pdfData);
//             }
//           },
//           backgroundColor: context.colorScheme.secondary,
//           title: 'Send Offer',
//           subtitle: 'Directly in your mailbox',
//           titleColor: context.colorScheme.surface,
//           subtitleColor: context.colorScheme.surface,
//         ),
//       ],
//       content: Padding(
//         padding: EdgeInsets.only(top: 10.h),
//         child: SizedBox(
//           width: 1.sw,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               RichText(
//                 text: TextSpan(
//                   text: 'Receive your offer ',
//                   style: context.textTheme.bodyLarge
//                       ?.copyWith(fontWeight: FontWeight.w300),
//                   children: [
//                     TextSpan(
//                       text: 'by email',
//                       style: context.textTheme.bodyLarge
//                           ?.copyWith(fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//               ),
//               Text(
//                 'Please fill in all necessary information',
//                 style: context.textTheme.labelMedium?.copyWith(
//                   color: context.colorScheme.secondary,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.only(top: 30.h),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         CustomTextFormField(
//                           fieldName: 'NAME',
//                           keyboardType: TextInputType.name,
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required(),
//                             FormBuilderValidators.alphabetical(),
//                           ]),
//                           onSaved: (value) => name = value!,
//                         ),
//                         WhiteSpace(height: 30),
//                         CustomTextFormField(
//                           fieldName: 'STREET NAME',
//                           keyboardType: TextInputType.streetAddress,
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required(),
//                           ]),
//                         ),
//                         WhiteSpace(height: 30),
//                         CustomTextFormField(
//                           fieldName: 'NUMBER',
//                           keyboardType: TextInputType.number,
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required(),
//                             FormBuilderValidators.numeric(),
//                           ]),
//                         ),
//                         WhiteSpace(height: 30),
//                         CustomTextFormField(
//                           fieldName: 'ZIP CODE',
//                           keyboardType: TextInputType.number,
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required(),
//                             FormBuilderValidators.numeric(),
//                           ]),
//                         ),
//                         WhiteSpace(height: 30),
//                         CustomTextFormField(
//                           fieldName: 'CITY',
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required(),
//                             FormBuilderValidators.alphabetical(),
//                           ]),
//                         ),
//                         WhiteSpace(height: 30),
//                         CustomTextFormField(
//                           fieldName: 'EMAIL',
//                           keyboardType: TextInputType.emailAddress,
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required(),
//                             FormBuilderValidators.email(),
//                           ]),
//                           onSaved: (value) => email = value!,
//                         ),
//                         WhiteSpace(height: 30),
//                         CustomTextFormField(
//                           fieldName: 'PHONE',
//                           keyboardType: TextInputType.phone,
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required(),
//                             FormBuilderValidators.numeric(),
//                           ]),
//                         ),
//                         WhiteSpace(height: 30),
//                         CustomTextFormField(
//                           fieldName: 'IMEI NUMBER',
//                           keyboardType: TextInputType.number,
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.numeric(),
//                           ]),
//                           isRequired: false,
//                         ),
//                         WhiteSpace(height: 30),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PdfPreviewScreen extends StatelessWidget {
//   final Uint8List pdfData;

//   PdfPreviewScreen({required this.pdfData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Preview'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: PdfPreview(
//         build: (format) => pdfData,
//       ),
//     );
//   }
// }

import 'package:daily_phones/core/common/widgets/widgets.dart';
import 'package:daily_phones/core/services/email_service.dart';
import 'package:daily_phones/core/res/extensions.dart';
import 'package:daily_phones/core/services/pdf_creator.dart';
import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class OfferForm extends StatefulWidget {
  const OfferForm({required this.selectedItems, super.key});

  final List<CheckoutItem> selectedItems;

  @override
  State<OfferForm> createState() => _OfferFormState();
}

class _OfferFormState extends State<OfferForm> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        CustomActionButton(
          onPressed: () async {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState!.save();
              final pdfData = await PdfGenerator.generateRepairPdf(
                customerName:
                    name[0].toUpperCase() + name.substring(1).toLowerCase(),
                selectedOptions: widget.selectedItems,
              );

              await EmailService.sendRepairInvoiceEmail(
                pdfData: pdfData,
                name: name,
                email: email,
                context: context,
              );
            }
          },
          backgroundColor: context.colorScheme.secondary,
          title: 'Send Offer',
          subtitle: 'Directly in your mailbox',
          titleColor: context.colorScheme.surface,
          subtitleColor: context.colorScheme.surface,
        ),
      ],
      content: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: SizedBox(
          width: 1.sw,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    fieldName: 'NAME',
                    keyboardType: TextInputType.name,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.alphabetical(),
                    ]),
                    onSaved: (value) => name = value!,
                  ),
                  const WhiteSpace(height: 30),
                  CustomTextFormField(
                    fieldName: 'STREET NAME',
                    keyboardType: TextInputType.streetAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                  ),
                  const WhiteSpace(height: 30),
                  CustomTextFormField(
                    fieldName: 'NUMBER',
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ]),
                  ),
                  const WhiteSpace(height: 30),
                  CustomTextFormField(
                    fieldName: 'ZIP CODE',
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ]),
                  ),
                  const WhiteSpace(height: 30),
                  CustomTextFormField(
                    fieldName: 'CITY',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.alphabetical(),
                    ]),
                  ),
                  const WhiteSpace(height: 30),
                  CustomTextFormField(
                    fieldName: 'EMAIL',
                    keyboardType: TextInputType.emailAddress,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ]),
                    onSaved: (value) => email = value!,
                  ),
                  const WhiteSpace(height: 30),
                  CustomTextFormField(
                    fieldName: 'PHONE',
                    keyboardType: TextInputType.phone,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ]),
                  ),
                  const WhiteSpace(height: 30),
                  CustomTextFormField(
                    fieldName: 'IMEI NUMBER',
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(),
                    ]),
                    isRequired: false,
                  ),
                  const WhiteSpace(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
