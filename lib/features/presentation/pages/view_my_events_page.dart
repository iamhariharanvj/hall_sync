

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hall_sync/config/utils/constants.dart';
import 'package:hall_sync/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:hall_sync/features/presentation/cubit/slot/slot_cubit.dart';
import 'package:intl/intl.dart';


class ViewMyEventsPage extends StatefulWidget {
  final String uid;
  const ViewMyEventsPage({Key? key,required this.uid}) : super(key: key);

  @override
  _ViewMyEventsPageState createState() => _ViewMyEventsPageState();
}

class _ViewMyEventsPageState extends State<ViewMyEventsPage> {


  @override
  void initState() {
    BlocProvider.of<SlotCubit>(context).getUserSlots(uid: widget.uid);
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
    return Column(
      children: [
        Expanded(
          child: slotLoadedState.slots.isEmpty?_noSlotsWidget():GridView.builder(
            itemCount: slotLoadedState.slots.length,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.2),
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, PageConstants.updateSlotPage,
                      arguments: slotLoadedState.slots[index]);
                },
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Delete Note"),
                        content: Text("are you sure you want to delete this note."),
                        actions: [
                          TextButton(
                            child: Text("Delete"),
                            onPressed: () {
                              BlocProvider.of<SlotCubit>(context).deleteSlot(slot: slotLoadedState.slots[index]);
                              Navigator.pop(context);
            
                              Future.delayed(Duration(seconds: 2), (){
                                BlocProvider.of<SlotCubit>(ctx).getAllSlots();
                              });                            
                            },
                          ),
                          TextButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.2),
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(0, 1.5))
                      ]),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${slotLoadedState.slots[index].description}",
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                          "${DateFormat("dd MMM yyy hh:mm a").format(slotLoadedState.slots[index].startTime!)}")
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}