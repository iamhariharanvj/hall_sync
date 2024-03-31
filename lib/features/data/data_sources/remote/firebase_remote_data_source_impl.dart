import 'package:hall_sync/features/data/data_sources/remote/firebase_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hall_sync/features/data/models/slot_model.dart';
import 'package:hall_sync/features/data/models/user_model.dart';
import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/domain/entities/user_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataStore{
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  
  const FirebaseRemoteDataSourceImpl({required this.auth,required this.firestore});

  static String slotCollectionPath = 'slots';
  static String userCollectionPath = 'users';

  @override
  Future<void> toggleSlotApproval(SlotEntity slot) async {
    Map<String, dynamic> slotMap = {};
    final slotCollectionRef = firestore.collection(slotCollectionPath);
    if(slot.isApproved!=null) slotMap['isApproved'] = !(slot.isApproved?? false) ;
    slotCollectionRef.doc(slot.id!).update(slotMap);
  }


  @override
  Future<void> bookSlot(SlotEntity slot) async {
    final slotCollectionRef = firestore.collection(slotCollectionPath);
    final querySnapshot = await slotCollectionRef
    .where('startTime', isGreaterThanOrEqualTo: slot.startTime)
    .get();

    final filteredSnapshots = querySnapshot.docs.where((doc) {
      final endTime = doc.data()['endTime'];
      final isApproved = doc.data()['isApproved'];
      return endTime <= slot.endTime && isApproved;
    }).toList();

    if (filteredSnapshots.isNotEmpty) {
      throw Exception('Overlapping slot found. Booking failed.');
    }

    final slotId = slotCollectionRef.doc().id;

    slotCollectionRef.doc(slotId).get().then((_slot){
      final newSlot = SlotModel(
        id: slotId,
        name: slot.name,
        startTime: slot.startTime,
        endTime: slot.endTime,
        description: slot.description,
        isApproved: false,
        inchargeId: slot.inchargeId
      ).toDocument();

      if(!_slot.exists) slotCollectionRef.doc(slotId).set(newSlot);
    });

  }


  @override
  Future<void> deleteSlot(SlotEntity slot) async {
    final slotCollectionRef = firestore.collection(slotCollectionPath);
    slotCollectionRef.doc(slot.id).get().then((slot) => {
      if(slot.exists)
        slotCollectionRef.doc(slot.id).delete()  
    });
    return;
  }

  @override
  Stream<List<SlotEntity>> getAllSlots() {
    final slotCollectionRef = firestore.collection(slotCollectionPath);
    return slotCollectionRef.snapshots().map((querySnaps) {
      return querySnaps.docs.map((docSnap) => SlotModel.fromSnapshot(docSnap)).toList();
    });
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firestore.collection(userCollectionPath);
    final uid = await getCurrentUId();

    userCollectionRef.doc(uid).get().then((_user){
      final newUser = UserModel(uid:uid, name: user.name, type:"member").toDocument();

      if(_user.exists){
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });  
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Stream<List<SlotEntity>> getUserSlots(String uid) {
    final slotCollectionRef = firestore.collection(slotCollectionPath);
    return slotCollectionRef.where('inchargeId',isEqualTo: uid).snapshots().map((querySnapshot){
      return querySnapshot.docs.map((docSnap) => SlotModel.fromSnapshot(docSnap)).toList();
    });
  }

  @override
  Future<String> getRole(String uid) async{
    final userCollectionRef = firestore.collection(userCollectionPath);
    String type="viewer";
    userCollectionRef.doc(uid).get().then((user) => {
      if(user.exists){
        type = UserModel.fromDocument(user).type!
      }
    });
    return type;
  }

  @override
  Stream<List<SlotEntity>> getApprovedSlots() {
    final slotCollectionRef = firestore.collection(slotCollectionPath);
    return slotCollectionRef.where('isApproved',isEqualTo: true).snapshots().map((querySnapshot){
      return querySnapshot.docs.map((docSnap) => SlotModel.fromSnapshot(docSnap)).toList();
    });
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid!=null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(email:user.email!, password:user.password!);
  

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async => auth.createUserWithEmailAndPassword(email: user.email!, password: user.password!);

  @override
  Future<void> updateSlot(SlotEntity slot) async {
    final slotCollectionRef = firestore.collection(slotCollectionPath);

    slotCollectionRef.doc(slot.id).get().then((oldSlot){
      if(oldSlot.exists) {
        slotCollectionRef.doc(slot.id).update(
        {
          "name": slot.name,
          "description": slot.description,
        });
      }
      return;
    });
  
  }

}