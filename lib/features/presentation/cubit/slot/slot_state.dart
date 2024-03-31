part of 'slot_cubit.dart';

abstract class SlotState extends Equatable{
  const SlotState();
}

class SlotInitial extends SlotState{  
  @override
  List<Object?> get props => [];
}

class SlotLoaded extends SlotState{
  final List<SlotEntity> slots; 
  const SlotLoaded({required this.slots});
  
  @override
  List<Object?> get props => [];
}
class SlotLoading extends SlotState{  
  @override
  List<Object?> get props => [];
}

class SlotFailure extends SlotState{  
  @override
  List<Object?> get props => [];
}


