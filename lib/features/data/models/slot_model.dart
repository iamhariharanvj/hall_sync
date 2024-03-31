import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SlotModel extends SlotEntity{
  final String ? id;
  final String ? name;
  final DateTime ? startTime;
  final DateTime ? endTime;
  final String ? description;
  final String ? inchargeId;
  final bool ? isApproved;
  
  const SlotModel({this.id, this.name, this.startTime, this.endTime, this.description, this.inchargeId, this.isApproved});

  factory SlotModel.fromSnapshot(DocumentSnapshot documentSnapshot){
    return SlotModel(
      id: documentSnapshot.get('id'),
      name: documentSnapshot.get('name'),
      startTime: DateTime.parse(documentSnapshot.get('startTime')),
      endTime: DateTime.parse(documentSnapshot.get('endTime')),
      description: documentSnapshot.get('description'),
      inchargeId: documentSnapshot.get('inchargeId'),
      isApproved: documentSnapshot.get('isApproved')
    );
  }

   Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'startTime': startTime!.toIso8601String(),
      'endTime': endTime!.toIso8601String(),
      'isApproved': isApproved, 
      'description': description,
      'inchargeId': inchargeId,
    };
  }
}

