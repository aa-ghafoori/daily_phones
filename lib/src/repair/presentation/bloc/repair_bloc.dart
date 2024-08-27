import 'dart:async';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:daily_phones/app/app_bloc_observer.dart';

import 'package:daily_phones/core/common/widgets/custom_snackbar.dart';
import 'package:daily_phones/core/res/helper_functions.dart';
import 'package:daily_phones/core/res/predefined_data.dart';
import 'package:daily_phones/core/services/pdf_creator.dart';

import 'package:daily_phones/src/repair/domain/entities/entities.dart';
import 'package:daily_phones/src/repair/domain/usecases/usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'repair_event.dart';

part 'repair_state.dart';

class RepairBloc extends Bloc<RepairEvent, RepairState> {
  RepairBloc({
    required GetAccessories getAccessories,
    required GetBrands getBrands,
    required GetProductTypes getProductTypes,
    required GetProducts getProducts,
    required GetRepairs getRepairs,
    required SendOfferEmail sendOfferEmail,
    required SendAppointmentEmail sendAppointmentEmail,
  })  : _getAccessories = getAccessories,
        _getBrands = getBrands,
        _getProductTypes = getProductTypes,
        _getProducts = getProducts,
        _getRepairs = getRepairs,
        _sendOfferEmail = sendOfferEmail,
        _sendAppointmentEmail = sendAppointmentEmail,
        super(const RepairState()) {
    on<RepairStarted>(_onRepairStarted);
    on<RepairProductTypeSelected>(_onRepairProductTypeSelected);
    on<RepairBrandSelected>(_onRepairBrandSelected);
    on<RepairNavigateBackToBrandsPressed>(_onRepairNavigateBackToBrandsPressed);
    on<RepairNavigateBackToTypesPressed>(_onRepairNavigateBackToTypesPressed);
    on<RepairProductsFiltered>(_onRepairProductsFiltered);
    on<RepairProductSelected>(_onRepairProductSelected);
    on<RepairProductColorSelected>(_onRepairProductColorSelected);
    on<RepairItemAdded>(_onRepairItemAdded);
    on<RepairItemRemoved>(_onRepairItemRemoved);
    on<RepairBookingScreenStarted>(_onRepairBookingScreenStarted);
    on<RepairOfferFormSubmitted>(_onRepairOfferFormSubmitted);
    on<RepairDeliveryMethodSelected>(_onRepairDeliveryMethodSelected);
    on<RepairPaymentMethodSelected>(_onRepairPaymentMethodSelected);
    on<RepairValidationStarted>(_onRepairValidationStarted);
    on<RepairCustomerNameUpdated>(_onRepairCustomerNameUpdated);
    on<RepairCustomerEmailUpdated>(_onRepairCustomerEmailUpdated);
    on<RepairCustomerPhoneUpdated>(_onRepairCustomerPhoneUpdated);
    on<RepairBookingStarted>(_onRepairBookingStarted);
  }

  final GetAccessories _getAccessories;

  final GetBrands _getBrands;

  final GetProductTypes _getProductTypes;

  final GetProducts _getProducts;

  final GetRepairs _getRepairs;

  final SendOfferEmail _sendOfferEmail;

  final SendAppointmentEmail _sendAppointmentEmail;

  List<Product> _products = [];

  DeliveryMethod? deliveryMethod;

  String? paymentMethod;

  bool isValidated = false;

  Future<void> _onRepairStarted(
    RepairStarted event,
    Emitter<RepairState> emit,
  ) async {
    emit(const RepairLoadInProgress());

    final productTypes = await _getProductTypes();

    productTypes.fold(
      (failure) => emit(
        RepairLoadFailure(
          message: failure.message,
          statusCode: failure.statusCode,
        ),
      ),
      (productTypes) => emit(RepairLoadSuccess(productTypes: productTypes)),
    );

    final products = await _getProducts(const GetProductsParams());

    products.fold(
        (failure) => emit(
              RepairLoadFailure(
                message: failure.message,
                statusCode: failure.statusCode,
                productTypes: state.productTypes,
              ),
            ), (products) {
      _products = products;

      emit(
        RepairLoadSuccess(
          productTypes: state.productTypes,
          products: products,
        ),
      );
    });
  }

  Future<void> _onRepairProductTypeSelected(
    RepairProductTypeSelected event,
    Emitter<RepairState> emit,
  ) async {
    emit(
      RepairLoadInProgress(
        productTypes: state.productTypes,
        products: state.products,
      ),
    );

    final brands = await _getBrands(
      GetBrandsParams(type: event.type),
    );

    brands.fold(
      (failure) => emit(
        RepairLoadFailure(
          message: failure.message,
          statusCode: failure.statusCode,
          productTypes: state.productTypes,
          products: state.products,
        ),
      ),
      (brands) {
        emit(
          RepairLoadSuccess(
            productTypes: state.productTypes,
            products: state.products,
            brands: brands,
          ),
        );
      },
    );
  }

  Future<void> _onRepairBrandSelected(
    RepairBrandSelected event,
    Emitter<RepairState> emit,
  ) async {
    emit(
      RepairLoadInProgress(
        productTypes: state.productTypes,
        products: state.products,
        brands: state.brands,
      ),
    );
    final products = await _getProducts(
      GetProductsParams(brand: event.brand, type: event.type),
    );

    products.fold(
        (failure) => emit(
              RepairLoadFailure(
                message: failure.message,
                statusCode: failure.statusCode,
                productTypes: state.productTypes,
                products: state.products,
                brands: state.brands,
              ),
            ), (products) {
      emit(
        RepairLoadSuccess(
          productTypes: state.productTypes,
          products: state.products,
          brands: state.brands,
          filteredProducts: products,
        ),
      );
    });
  }

  void _onRepairNavigateBackToBrandsPressed(
    RepairNavigateBackToBrandsPressed event,
    Emitter<RepairState> emit,
  ) {
    logger.f(state.productTypes);

    emit(
      RepairLoadSuccess(
        products: state.products,
        productTypes: state.productTypes,
        brands: state.brands,
      ),
    );

    logger.f(state.productTypes);
  }

  void _onRepairNavigateBackToTypesPressed(
    RepairNavigateBackToTypesPressed event,
    Emitter<RepairState> emit,
  ) {
    emit(
      RepairLoadSuccess(
        products: state.products,
        productTypes: state.productTypes,
      ),
    );

    logger.f(state.productTypes);
  }

  void _onRepairProductsFiltered(
    RepairProductsFiltered event,
    Emitter<RepairState> emit,
  ) {
    final filteredProducts = _products
        .where(
          (product) =>
              product.brand.name
                  .toLowerCase()
                  .contains(event.text.toLowerCase()) ||
              product.name.toLowerCase().contains(event.text.toLowerCase()),
        )
        .toList();
    emit(RepairProductsFilterSuccess(products: filteredProducts));
  }

  Future<void> _onRepairProductSelected(
    RepairProductSelected event,
    Emitter<RepairState> emit,
  ) async {
    final repairs = await _getRepairs(
      GetRepairsParams(product: event.product),
    );

    repairs.fold(
      (failure) => emit(
        state.copyWith(status: RepairStatus.failure),
      ),
      (repairs) => emit(
        state.copyWith(repairs: repairs, status: RepairStatus.success),
      ),
    );
    logger.f('repairs loaded..');

    final accessories = await _getAccessories(
      GetAccessoriesParams(product: event.product),
    );

    accessories.fold(
      (failure) => emit(state.copyWith(status: RepairStatus.failure)),
      (accessories) => emit(
        state.copyWith(
          accessories: accessories,
          status: RepairStatus.success,
        ),
      ),
    );

    logger.f('accessories loaded..');

    emit(state.copyWith(product: event.product));
  }

  void _onRepairProductColorSelected(
    RepairProductColorSelected event,
    Emitter<RepairState> emit,
  ) {
    emit(
      state.copyWith(
        selectedColor: event.productColor,
        status: RepairStatus.success,
      ),
    );
  }

  void _onRepairItemAdded(RepairItemAdded event, Emitter<RepairState> emit) {
    final updatedItems = List<CheckoutItem>.from(state.selectedItems)
      ..add(event.item);
    emit(
      state.copyWith(selectedItems: updatedItems, status: RepairStatus.success),
    );
  }

  void _onRepairItemRemoved(
    RepairItemRemoved event,
    Emitter<RepairState> emit,
  ) {
    final updatedItems = List<CheckoutItem>.from(state.selectedItems)
      ..remove(event.item);
    emit(
      state.copyWith(selectedItems: updatedItems),
    );
  }

  void _onRepairBookingScreenStarted(
    RepairBookingScreenStarted event,
    Emitter<RepairState> emit,
  ) {
    emit(event.state);
    logger.d(state);
  }

  void _onRepairDeliveryMethodSelected(
    RepairDeliveryMethodSelected event,
    Emitter<RepairState> emit,
  ) {
    if (!event.reset) {
      deliveryMethod = event.data;
    } else {
      final method = deliveryMethod! as StorePickup;

      deliveryMethod = StorePickup(address: method.address);
    }

    emit(RepairDeliverMethodSelectSuccess(selectedItems: state.selectedItems));
  }

  void _onRepairPaymentMethodSelected(
    RepairPaymentMethodSelected event,
    Emitter<RepairState> emit,
  ) {
    paymentMethod = event.paymentMethod;
  }

  void _onRepairValidationStarted(
    RepairValidationStarted event,
    Emitter<RepairState> emit,
  ) {
    isValidated = false;

    if (deliveryMethod is ShipDevice) {
      final data = deliveryMethod! as ShipDevice;
      if (data.isValid()) {
        data.saveForm();
        if (paymentMethod != null) {
          isValidated = true;
          // Signal completion
        } else {
          _showWarningSnackbar(event.context, 'Please select a payment method');
          // Signal completion even on failure
        }
      } else {
        _showWarningSnackbar(
          event.context,
          'Please fill in all the fields in the shipping address form',
        );
      }
    } else if (deliveryMethod is StorePickup) {
      final data = deliveryMethod! as StorePickup;
      if (data.address != null) {
        logger.i(data);
        if (data.appointmentDate != null) {
          if (paymentMethod != null) {
            isValidated = true;
          } else {
            _showWarningSnackbar(
              event.context,
              'Please select a payment method',
            );
          }
        } else {
          _showWarningSnackbar(
            event.context,
            'Please select a date and time for appointment',
          );
        }
      } else {
        _showWarningSnackbar(
          event.context,
          'Please select an appointment location',
        );
      }
    } else {
      _showWarningSnackbar(event.context, 'Please select a delivery method');
    }

    emit(
      RepairValidationCheckSuccess(
        customerName: state.customerName,
        customerEmail: state.customerEmail,
        customerPhone: state.customerPhone,
        selectedItems: state.selectedItems,
      ),
    );
  }

  void _showWarningSnackbar(BuildContext context, String message) {
    CustomSnackbar(
      context: context,
      message: message,
      contentType: ContentType.warning,
      title: 'Warning!',
    ).show();
  }

  void _onRepairCustomerNameUpdated(
    RepairCustomerNameUpdated event,
    Emitter<RepairState> emit,
  ) {
    emit(state.copyWith(customerName: event.name));
  }

  void _onRepairCustomerEmailUpdated(
    RepairCustomerEmailUpdated event,
    Emitter<RepairState> emit,
  ) {
    emit(state.copyWith(customerEmail: event.email));
  }

  void _onRepairCustomerPhoneUpdated(
    RepairCustomerPhoneUpdated event,
    Emitter<RepairState> emit,
  ) {
    emit(state.copyWith(customerPhone: event.phone));
  }

  Future<void> _onRepairBookingStarted(
    RepairBookingStarted event,
    Emitter<RepairState> emit,
  ) async {
    emit(
      RepairBookingInProgress(
        selectedItems: state.selectedItems,
        customerName: state.customerName,
        customerEmail: state.customerEmail,
        customerPhone: state.customerPhone,
      ),
    );

    DateTime appointmentDate;

    if (deliveryMethod is StorePickup) {
      final storePickUp = deliveryMethod! as StorePickup;
      appointmentDate = storePickUp.appointmentDate!;
    } else {
      appointmentDate = generateAppointmentDate();
    }

    final sendMail = await _sendAppointmentEmail(
      SendAppointmentEmailParams(
        name: event.name,
        email: event.email,
        phone: event.phone,
        appointmentDate: appointmentDate,
        repairItems: state.selectedItems,
      ),
    );

    sendMail.fold(
      (failure) => emit(
        RepairBookingFailure(
          message: failure.message,
          statusCode: failure.statusCode,
          customerName: state.customerName,
          customerEmail: state.customerEmail,
          customerPhone: state.customerPhone,
          selectedItems: state.selectedItems,
        ),
      ),
      (_) => emit(
        RepairBookingSuccess(
          customerName: state.customerName,
          customerEmail: state.customerEmail,
          customerPhone: state.customerPhone,
          selectedItems: state.selectedItems,
          deliveryMethod: deliveryMethod!,
          paymentMethod: paymentMethod!,
        ),
      ),
    );
  }

  Future<void> _onRepairOfferFormSubmitted(
    RepairOfferFormSubmitted event,
    Emitter<RepairState> emit,
  ) async {
    emit(
      RepairOfferEmailSendInProgress(
        selectedItems: state.selectedItems,
        product: state.product,
        selectedColor: state.selectedColor,
        accessories: state.accessories,
        repairs: state.repairs,
      ),
    );

    final pdfData = await PdfGenerator.generateOfferPdf(
      customerName: capitalizeName(event.name),
      selectedOptions: state.selectedItems,
    );

    final sendMail = await _sendOfferEmail(
      SendOfferEmailParams(
        pdfData: pdfData,
        name: event.name,
        email: event.email,
      ),
    );

    sendMail.fold(
      (_) => emit(
        RepairOfferEmailSendFailure(
          selectedItems: state.selectedItems,
          product: state.product,
          selectedColor: state.selectedColor,
          accessories: state.accessories,
          repairs: state.repairs,
        ),
      ),
      (_) => emit(
        RepairOfferEmailSendSuccess(
          selectedItems: state.selectedItems,
          product: state.product,
          selectedColor: state.selectedColor,
          accessories: state.accessories,
          repairs: state.repairs,
        ),
      ),
    );
  }
}
