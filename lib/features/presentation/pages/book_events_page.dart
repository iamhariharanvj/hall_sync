import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hall_sync/config/utils/constants.dart';
import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:hall_sync/features/presentation/cubit/slot/slot_cubit.dart';
import 'package:hall_sync/features/presentation/widgets/common.dart';
import 'package:intl/intl.dart';

class BookEventsPage extends StatefulWidget {
  final String uid;
  const BookEventsPage({Key? key, required this.uid}) :   super(key: key);

  @override
  _BookEventsPageState createState() => _BookEventsPageState();
}

class _BookEventsPageState extends State<BookEventsPage> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  DateTime? _startTime;
  DateTime? _endTime;

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
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
        title: const Text('Book Slot'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).loggedOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  setState(() {
                    _startTime = selectedTime;
                  });
                },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Start Time',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                controller: TextEditingController(
                  text: _startTime != null
                      ? DateFormat.yMd().add_jm().format(_startTime!)
                      : '',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                onTap: () async {
                  DateTime? selectedTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  setState(() {
                    _endTime = selectedTime;
                  });
                },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'End Time',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                controller: TextEditingController(
                  text: _endTime != null
                      ? DateFormat.yMd().add_jm().format(_endTime!)
                      : '',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _saveSlot(context),
                child: const Text('Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveSlot(BuildContext context) {
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

    final newSlot = SlotEntity(
      id: UniqueKey().toString(),
      name: name,
      startTime: _startTime!,
      endTime: _endTime!,
      description: description,
      inchargeId: widget.uid,
      isApproved: false,
    );

    BlocProvider.of<SlotCubit>(context).bookSlotUsecase(newSlot);
    Future.delayed(
      Duration(seconds: 1),
      () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Slot booked successfully.'),
          ),
        );
      },
    );
  }
}
