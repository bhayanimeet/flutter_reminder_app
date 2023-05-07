import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_reminder_app/views/screens/homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/local_notification_controller.dart';
import '../../controllers/sqlite_db_controller.dart';
import '../../models/sqlite_db_model.dart';
import '../../res/global.dart';

class InsertData extends StatefulWidget {
  const InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  GlobalKey<FormState> insertKey = GlobalKey<FormState>();
  int initialStep = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 160,
              toolbarHeight: 80,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(25)),
                  color: (Global.isDark == false)
                      ? const Color(0xff35313f)
                      : const Color(0xffe9e2f1),
                ),
                child: FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  background: Align(
                    alignment: const Alignment(-0.88, -0.4),
                    child: Text(
                      "Todo",
                      style: GoogleFonts.arya(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color:
                            Global.isDark == false ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        flex: 11,
                        child: SizedBox(
                          height: 50,
                          width: 200,
                          child: Text(
                            "Insert data",
                            style: GoogleFonts.arya(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Global.isDark == false
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            Get.changeThemeMode(
                              (Get.isDarkMode == true)
                                  ? ThemeMode.light
                                  : ThemeMode.dark,
                            );
                            setState(() {
                              Global.isDark = !Global.isDark;
                            });
                          },
                          child: const Icon(Icons.light_mode_outlined),
                        ),
                      ),
                    ],
                  ),
                  titlePadding: const EdgeInsets.only(left: 20, bottom: 20),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Form(
                key: insertKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "Enter your task title",
                          style: GoogleFonts.arya(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: Global.titleController,
                          style: GoogleFonts.play(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          enableSuggestions: true,
                          textInputAction: TextInputAction.next,
                          onSaved: (val) {
                            setState(() {
                              Global.title = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter your task title first...";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            hintText: "Enter your task title",
                            hintStyle: GoogleFonts.play(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: "Title",
                            labelStyle: GoogleFonts.arya(
                                fontSize: 25, fontWeight: FontWeight.w500),
                            errorStyle: GoogleFonts.play(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Enter your task",
                          style: GoogleFonts.arya(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: Global.taskController,
                          style: GoogleFonts.play(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          enableSuggestions: true,
                          textInputAction: TextInputAction.next,
                          onSaved: (val) {
                            setState(() {
                              Global.task = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Enter your task first...";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            hintText: "Enter your task",
                            hintStyle: GoogleFonts.play(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: "Task",
                            labelStyle: GoogleFonts.arya(
                                fontSize: 25, fontWeight: FontWeight.w500),
                            errorStyle: GoogleFonts.play(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Select Date",
                          style: GoogleFonts.arya(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: Global.dateController,
                          style: GoogleFonts.play(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(3000),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                Global.dateController.text =
                                    DateFormat('dd/MM/yyyy').format(pickedDate);
                              });
                            }
                          },
                          readOnly: true,
                          enableSuggestions: true,
                          textInputAction: TextInputAction.next,
                          onSaved: (val) {
                            setState(() {
                              Global.myDate = Global.dateController.text;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please select date...";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            hintText: "Select date",
                            hintStyle: GoogleFonts.play(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: "Date",
                            labelStyle: GoogleFonts.arya(
                                fontSize: 25, fontWeight: FontWeight.w500),
                            errorStyle: GoogleFonts.play(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Select start Time",
                          style: GoogleFonts.arya(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: Global.startTimeController,
                          style: GoogleFonts.play(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (time != null) {
                              setState(() {
                                Global.startTimeController.text =
                                    time.format(context);
                              });
                            }
                          },
                          readOnly: true,
                          enableSuggestions: true,
                          textInputAction: TextInputAction.next,
                          onSaved: (val) {
                            setState(() {
                              Global.startTime = Global.startTimeController.text;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please select start time...";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            hintText: "Select time",
                            hintStyle: GoogleFonts.play(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: "Time",
                            labelStyle: GoogleFonts.arya(
                                fontSize: 25, fontWeight: FontWeight.w500),
                            errorStyle: GoogleFonts.play(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Select end Time",
                          style: GoogleFonts.arya(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: Global.endTimeController,
                          style: GoogleFonts.play(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (time != null) {
                              setState(() {
                                Global.endTimeController.text =
                                    time.format(context);
                              });
                            }
                          },
                          readOnly: true,
                          enableSuggestions: true,
                          textInputAction: TextInputAction.next,
                          onSaved: (val) {
                            setState(() {
                              Global.endTime = Global.endTimeController.text;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please select end time...";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            hintText: "Select time",
                            hintStyle: GoogleFonts.play(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: "Time",
                            labelStyle: GoogleFonts.arya(
                                fontSize: 25, fontWeight: FontWeight.w500),
                            errorStyle: GoogleFonts.play(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Set reminder",
                          style: GoogleFonts.arya(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: Global.reminderController,
                          style: GoogleFonts.play(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder:(context) => SizedBox(
                                height: 250,
                                child: CupertinoDatePicker(
                                  backgroundColor: Colors.black,
                                  initialDateTime: Global.picker,
                                  onDateTimeChanged: (DateTime newTime){
                                    setState(() {
                                      Global.picker = newTime;

                                      Global.hour = Global.picker.hour;
                                      Global.minute = Global.picker.minute;
                                      Global.year = Global.picker.year;
                                      Global.month = Global.picker.month;
                                      Global.day = Global.picker.day;

                                      Global.reminderController.text = '${Global.day}/${Global.month}/${Global.year} ${Global.hour}:${Global.minute}';
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                          readOnly: true,
                          enableSuggestions: true,
                          textInputAction: TextInputAction.next,
                          onSaved: (val) {
                            setState(() {
                              Global.reminder = Global.reminderController.text;
                            });
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please set reminder...";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: (Get.isDarkMode == true)
                                        ? Colors.white
                                        : Colors.black,
                                    width: 1)),
                            hintText: "Set reminder",
                            hintStyle: GoogleFonts.play(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                            labelText: "Reminder",
                            labelStyle: GoogleFonts.arya(
                                fontSize: 25, fontWeight: FontWeight.w500),
                            errorStyle: GoogleFonts.play(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (insertKey.currentState!.validate()) {
              insertKey.currentState!.save();
              Task s1 = Task(
                title: Global.title!,
                task: Global.task!,
                startTime: Global.startTime!,
                endTime: Global.endTime!,
                date: Global.myDate!,
                reminder: Global.reminder!,
                isSelected: Global.isCompleted,
              );

              int res = await DBHelper.dbHelper.insertData(data: s1);

              if (res > 0) {
                setState(() {
                  Global.allTask = DBHelper.dbHelper.selectData();
                });
              }

              Get.off(
                () => const HomePage(),
                curve: Curves.easeInOut,
                transition: Transition.fadeIn,
                duration: const Duration(seconds: 1),
              );

              Get.showSnackbar(
                GetSnackBar(
                  title: 'Task',
                  backgroundColor: Colors.indigo.shade300,
                  snackPosition: SnackPosition.BOTTOM,
                  borderRadius: 20,
                  duration: const Duration(seconds: 2),
                  margin: const EdgeInsets.all(15),
                  message: 'Your added in list...',
                  snackStyle: SnackStyle.FLOATING,
                ),
              );

              await LocalPushNotificationHelper.localPushNotificationHelper.showSimpleNotification();
              await LocalPushNotificationHelper.localPushNotificationHelper.showScheduledNotification();

              setState(() {
                Global.titleController.clear();
                Global.taskController.clear();
                Global.dateController.clear();
                Global.startTimeController.clear();
                Global.endTimeController.clear();
                Global.reminderController.clear();
                Global.title = null;
                Global.task = null;
                Global.myDate = null;
                Global.startTime = null;
                Global.endTime = null;
                Global.reminder = null;
              });
            }
          },
          label: const Text('Add'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
