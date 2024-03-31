

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hall_sync/config/utils/constants.dart';
import 'package:hall_sync/features/domain/entities/slot_entity.dart';
import 'package:hall_sync/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:hall_sync/features/presentation/cubit/slot/slot_cubit.dart';
import 'package:intl/intl.dart';


class ViewEventsPage extends StatefulWidget {
  final String uid;
  const ViewEventsPage({Key? key,required this.uid}) : super(key: key);

  @override
  _ViewEventsPageState createState() => _ViewEventsPageState();
}

class _ViewEventsPageState extends State<ViewEventsPage> {

  @override
  void initState() {
    BlocProvider.of<SlotCubit>(context).getAllSlots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).loggedOut();
              },
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: BlocBuilder<SlotCubit,SlotState>(
        builder: (context,slotState){

          if (slotState is SlotLoaded){
            return _bodyWidget(slotState,context);
          }


          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _noSlotsWidget(){
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text("No events yet"),
        ],
      ),
    );
  }


  Widget _bodyWidget(SlotLoaded slotLoadedState, BuildContext ctx) {
  List<SlotEntity> filteredSlots = slotLoadedState.slots;

  List<SlotEntity> _filterEventsByDate(List<SlotEntity> slots, DateTime startDate, DateTime endDate) {
    return slots.where((slot) => slot.startTime!.isAfter(startDate) && slot.startTime!.isBefore(endDate)).toList();
  }
  Widget _filterButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _filterButton("Today", () {
              DateTime now = DateTime.now();
              DateTime startOfToday = DateTime(now.year, now.month, now.day); 
              DateTime startOfTomorrow = startOfToday.add(Duration(days: 1)); 

              setState(() {
                filteredSlots = _filterEventsByDate(slotLoadedState.slots, startOfToday, startOfTomorrow);
              });
            }),
            _filterButton("Tomorrow", () {
              DateTime now = DateTime.now();
              DateTime startOfTomorrow = DateTime(now.year, now.month, now.day + 1);
              DateTime startOfNextDay = startOfTomorrow.add(const Duration(days: 1)); 

              setState(() {
                filteredSlots = _filterEventsByDate(slotLoadedState.slots, startOfTomorrow, startOfNextDay);
              });
            }),

            _filterButton("This Week", () {
              DateTime startOfWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
              DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));
              setState(() {
                filteredSlots = _filterEventsByDate(slotLoadedState.slots, startOfWeek, endOfWeek);
              });
            }),
            _filterButton("This Month", () {
              DateTime startOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
              DateTime endOfMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
              setState(() {
              filteredSlots = _filterEventsByDate(slotLoadedState.slots, startOfMonth, endOfMonth);
              });
            }),
            _filterButton("All", () {
              setState(() {
              filteredSlots = slotLoadedState.slots;
              });
            }),
          ],
        ),
        Expanded(
          child: filteredSlots.isEmpty
              ? _noSlotsWidget()
              : SingleChildScrollView(
                child: GridView.builder(
                    itemCount: filteredSlots.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.2,
                    ),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.2),
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: Offset(0, 1.5),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${filteredSlots[index].description}",
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${DateFormat("dd MMM yyy hh:mm a").format(filteredSlots[index].startTime!)}",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ),
        ),
      ],
    );
  }
}