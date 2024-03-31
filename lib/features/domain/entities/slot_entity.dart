import 'package:equatable/equatable.dart';

class SlotEntity extends Equatable {
  final String? id;
  final String? name;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? description;
  final String? inchargeId;
  final bool? isApproved;

  const SlotEntity({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.description,
    this.inchargeId,
    this.isApproved
  });
  
  @override
  List<Object?> get props {
    return [id, name, startTime, endTime, description, inchargeId, isApproved];
  }
}
