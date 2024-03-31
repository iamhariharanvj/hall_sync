import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hall_sync/config/utils/constants.dart';
import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:hall_sync/features/presentation/cubit/slot/slot_cubit.dart';
import 'package:hall_sync/features/presentation/widgets/common.dart';
import 'package:intl/intl.dart';

class UpdateSlotPage extends StatefulWidget {
  final SlotEntity slot;
  const UpdateSlotPage({Key? key, required this.slot}) : super(key: key);

  @override
  _UpdateSlotPageState createState() => _UpdateSlotPageState();
}

class _UpdateSlotPageState extends State<UpdateSlotPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late DateTime _startTime;
  late DateTime _endTime;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.slot.name);
    _descriptionController = TextEditingController(text: widget.slot.description);
    _startTime = widget.slot.startTime!;
    _endTime = widget.slot.endTime!;

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Slot'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).loggedOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              onTap: () async {
                DateTime? selectedTime = await showDatePicker(
                  context: context,
                  initialDate: _startTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (selectedTime != null) {
                  setState(() {
                    _startTime = selectedTime;
                  });
                }
              },
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Start Time',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: TextEditingController(
                text: _startTime != null
                    ? DateFormat.yMd().add_jm().format(_startTime)
                    : '',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              onTap: () async {
                DateTime? selectedTime = await showDatePicker(
                  context: context,
                  initialDate: _endTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                );
                if (selectedTime != null) {
                  setState(() {
                    _endTime = selectedTime;
                  });
                }
              },
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'End Time',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              controller: TextEditingController(
                text: _endTime != null
                    ? DateFormat.yMd().add_jm().format(_endTime)
                    : '',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _updateSlot(context),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSlot(BuildContext context) {
    final String name = _nameController.text.trim();
    final String description = _descriptionController.text.trim();

    if (name.isEmpty || description.isEmpty || _startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields.'),
        ),
      );
      return;
    }

    final updatedSlot = SlotEntity(
      id: widget.slot.id,
      name: name,
      startTime: _startTime,
      endTime: _endTime,
      description: description,
      inchargeId: widget.slot.inchargeId,
      isApproved: widget.slot.isApproved,
    );

    BlocProvider.of<SlotCubit>(context).updateSlotUsecase(updatedSlot);
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pop(context);
    });
  }
}
  