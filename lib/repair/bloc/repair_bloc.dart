import 'package:daily_phones/repair/models/item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_devices_api/mobile_devices_api.dart';
import 'package:mobile_devices_repository/mobile_devices_repository.dart';

part 'repair_event.dart';
part 'repair_state.dart';

class RepairBloc extends Bloc<RepairEvent, RepairState> {
  final MobileDevicesRepository mobileDevicesRepository;

  RepairBloc({required this.mobileDevicesRepository})
      : super(const RepairState()) {
    on<RepairStarted>(_onRepairStarted);
    on<RepairProductSelected>(_onRepairProductSelected);
    on<RepairProductColorSelected>(_onRepairProductColorSelected);
    on<RepairItemAdded>(_onRepairItemAdded);
    on<RepairItemRemoved>(_onRepairItemRemoved);
  }

  Future<void> _onRepairStarted(
      RepairStarted event, Emitter<RepairState> emit) async {}

  Future<void> _onRepairProductSelected(
      RepairProductSelected event, Emitter<RepairState> emit) async {
    if (state.product != event.product) {
      emit(state.copyWith(status: RepairStatus.loading));
      await emit.forEach(
        mobileDevicesRepository.getProductColors(event.product),
        onData: (productColors) {
          return RepairState(
            productColors: productColors,
            product: event.product,
            status: RepairStatus.success,
          );
        },
        onError: (error, stackTrace) {
          return state.copyWith(status: RepairStatus.failure);
        },
      );

      try {
        final repairsStream = mobileDevicesRepository.getRepairs(event.product);
        await emit.forEach(
          repairsStream,
          onData: (repairs) {
            return state.copyWith(
                repairs: repairs, status: RepairStatus.success);
          },
          onError: (error, stackTrace) {
            return state.copyWith(status: RepairStatus.failure);
          },
        );

        final accessoriesStream =
            mobileDevicesRepository.getAccessories(event.product);
        await emit.forEach(
          accessoriesStream,
          onData: (accessories) {
            return state.copyWith(
                accessories: accessories, status: RepairStatus.success);
          },
          onError: (error, stackTrace) {
            return state.copyWith(status: RepairStatus.failure);
          },
        );
      } catch (e) {
        emit(state.copyWith(status: RepairStatus.failure));
      }
    } else {
      // await Future.delayed(const Duration(milliseconds: 200), () {
      //   state.status != RepairStatus.loading
      //       ? emit(state.copyWith(status: RepairStatus.loading))
      //       : emit(state.copyWith(status: RepairStatus.success));
      // });
    }
  }

  void _onRepairProductColorSelected(
      RepairProductColorSelected event, Emitter<RepairState> emit) {
    emit(state.copyWith(
        selectedColor: event.productColor, status: RepairStatus.success));
  }

  void _onRepairItemAdded(RepairItemAdded event, Emitter<RepairState> emit) {
    try {
      final updatedItems = List<Item>.from(state.selectedItems)
        ..add(event.item);
      emit(state.copyWith(
          selectedItems: updatedItems, status: RepairStatus.success));
    } catch (_) {
      emit(state.copyWith(status: RepairStatus.failure));
    }
  }

  void _onRepairItemRemoved(
      RepairItemRemoved event, Emitter<RepairState> emit) {
    try {
      final updatedItems = List<Item>.from(state.selectedItems)
        ..remove(event.item);
      emit(state.copyWith(selectedItems: updatedItems));
    } catch (_) {
      emit(state.copyWith(status: RepairStatus.failure));
    }
  }
}
