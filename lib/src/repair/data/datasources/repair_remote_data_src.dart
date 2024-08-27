import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:daily_phones/core/errors/exceptions.dart';
import 'package:daily_phones/core/services/email_service.dart';
import 'package:daily_phones/core/utils/typedef.dart';
import 'package:daily_phones/src/repair/data/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class RepairRemoteDataSrc {
  const RepairRemoteDataSrc();

  Future<List<AccessoryModel>> getAccessories(ProductModel product);

  Future<List<BrandModel>> getBrands(ProductTypeModel type);

  Future<List<ProductTypeModel>> getProductTypes();

  Future<List<ProductModel>> getProducts({
    ProductTypeModel? type,
    BrandModel? brand,
  });

  Future<List<RepairModel>> getRepairs(ProductModel product);

  Future<void> sendOfferEmail({
    required Uint8List pdfData,
    required String name,
    required String email,
  });

  Future<void> sendAppointmentEmail({
    required String name,
    required String email,
    required String phone,
    required DateTime appointmentDate,
    required List<CheckoutItemModel> repairItems,
  });
}

class RepairRemoteDataSrcImpl implements RepairRemoteDataSrc {
  RepairRemoteDataSrcImpl(this.supabase);

  final SupabaseClient supabase;

  Future<List<T>> _getData<T>(
    Future<List<DataMap>> Function() query,
    T Function(DataMap) fromMap,
  ) async {
    try {
      final response = await query();
      return response.map(fromMap).toList();
    } on PostgrestException catch (e) {
      throw ServerException(message: e.toString(), statusCode: e.code);
    } catch (e, stackTrace) {
      log('Error in _getData: $e', stackTrace: stackTrace);
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<AccessoryModel>> getAccessories(ProductModel product) async {
    return _getData(
      () => supabase.rpc(
        'get_accessories_by_product',
        params: {'p_product_id': product.id},
      ),
      AccessoryModel.fromMap,
    );
  }

  @override
  Future<List<BrandModel>> getBrands(ProductTypeModel type) async {
    return _getData(
      () => supabase.rpc(
        'get_brands_by_type',
        params: {'b_type_id': type.id},
      ),
      (map) => BrandModel.fromMap(map['brand'] as DataMap),
    );
  }

  @override
  Future<List<ProductTypeModel>> getProductTypes() async {
    return _getData(
      () => supabase.from('type').select(),
      ProductTypeModel.fromMap,
    );
  }

  @override
  Future<List<ProductModel>> getProducts({
    ProductTypeModel? type,
    BrandModel? brand,
  }) async {
    return _getData(
      () => supabase.rpc(
        'get_products',
        params: {'p_brand_id': brand?.id, 'p_type_id': type?.id},
      ),
      ProductModel.fromMap,
    );
  }

  @override
  Future<List<RepairModel>> getRepairs(ProductModel product) async {
    return _getData(
      () => supabase
          .rpc('get_repairs_by_product', params: {'p_product_id': product.id}),
      RepairModel.fromMap,
    );
  }

  Future<void> _sendEmail(DataMap emailData) async {
    final apiKey = dotenv.env['MAILJET_API_KEY']!;
    final apiSecret = dotenv.env['MAILJET_API_SECRET']!;
    final mailjetUrl = dotenv.env['MAILJET_URL']!;

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

      if (response.statusCode != 200) {
        throw ServerException(
          message: response.body,
          statusCode: response.statusCode.toString(),
        );
      }
    } catch (e, stackTrace) {
      log('Error in _sendEmail: $e', stackTrace: stackTrace);
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> sendAppointmentEmail({
    required String name,
    required String email,
    required String phone,
    required DateTime appointmentDate,
    required List<CheckoutItemModel> repairItems,
  }) async {
    final emailData = EmailService().generateAppointmentEmailData(
      name: name,
      email: email,
      phone: phone,
      appointmentDate: appointmentDate,
      repairItems: repairItems,
      senderEmail: dotenv.env['SENDER_EMAIL']!,
      senderName: 'Daily Phones',
    );

    await _sendEmail(emailData);
  }

  @override
  Future<void> sendOfferEmail({
    required Uint8List pdfData,
    required String name,
    required String email,
  }) async {
    final emailData = EmailService.generateOfferEmailData(
      pdfData: pdfData,
      name: name,
      email: email,
      senderEmail: dotenv.env['SENDER_EMAIL']!,
      senderName: 'Daily Phones',
    );

    await _sendEmail(emailData);
  }
}
