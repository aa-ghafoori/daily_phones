import 'package:equatable/equatable.dart';

class BookingFormData extends Equatable {
  const BookingFormData({
    this.name,
    this.email,
    this.phone,
  });

  final String? name;

  final String? email;

  final String? phone;

  BookingFormData copyWith({
    String? name,
    String? email,
    String? phone,
  }) {
    return BookingFormData(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [name, email, phone];
}
