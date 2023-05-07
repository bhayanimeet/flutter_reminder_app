import 'package:flutter/material.dart';
import 'package:flutter_reminder_app/views/screens/insertdata.dart';
import 'package:flutter_reminder_app/views/screens/updatedata.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../controllers/google_ads_controller.dart';
import '../../controllers/sqlite_db_controller.dart';
import '../../models/sqlite_db_model.dart';
import '../../res/global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int num = 0;

  @override
  void initState() {
    super.initState();
    Global.allTask = DBHelper.dbHelper.selectData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Global.allTask,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Data not found...."),
            );
          }
          else if (snapshot.hasData) {
            Global.data = snapshot.data;
            return (Global.data != null)
                ? CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 160,
                        toolbarHeight: 80,
                        pinned: true,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(25)),
                            color: (Global.isDark == false)
                                ? const Color(0xff35313f)
                                : const Color(0xffe9e2f1),
                          ),
                          child: FlexibleSpaceBar(
                            expandedTitleScale: 1,
                            background: Align(
                              alignment: const Alignment(-0.89, -0.4),
                              child: Text(
                                "Todo",
                                style: GoogleFonts.arya(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Global.isDark == false
                                      ? Colors.white
                                      : Colors.black,
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
                                      "Task list",
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
                                    child:
                                        const Icon(Icons.light_mode_outlined),
                                  ),
                                ),
                              ],
                            ),
                            titlePadding:
                                const EdgeInsets.only(left: 20, bottom: 20),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: ListView.builder(
                          itemCount: Global.data!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding:
                              const EdgeInsets.only(left: 5, right: 5, top: 8),
                          itemBuilder: (context, i) => Card(
                            elevation: 3,
                            child: Slidable(
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.31,
                                children: [
                                  const SizedBox(width: 3),
                                  Text(
                                    Global.data![i].date,
                                    style: GoogleFonts.arya(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                extentRatio: 0.32,
                                children: [
                                  const SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () {
                                      Get.off(
                                        () => const UpdateData(),
                                        duration: const Duration(seconds: 2),
                                        transition: Transition.fadeIn,
                                        curve: Curves.easeInOut,
                                        arguments: Global.data![i],
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () async {
                                      int res = await DBHelper.dbHelper
                                          .deleteData(index: Global.data![i].id!);

                                      if (res == 1) {
                                        setState(() {
                                          Global.allTask = DBHelper.dbHelper.selectData();
                                        });
                                      }
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (Global.data![i].isSelected == 0) {
                                              setState(() {
                                                Global.isCompleted = 1;
                                              });

                                              Task s1 = Task(
                                                title: Global.title!,
                                                task: Global.task!,
                                                startTime: Global.startTime!,
                                                endTime: Global.endTime!,
                                                date: Global.myDate!,
                                                reminder: Global.reminder!,
                                                isSelected: Global.isCompleted,
                                              );

                                              int res = await DBHelper.dbHelper
                                                  .update(
                                                      data: s1,
                                                      index: Global.data![i].id!);
                                              if (res == 1) {
                                                setState(() {
                                                  Global.allTask = DBHelper
                                                      .dbHelper
                                                      .selectData();
                                                });
                                              }
                                            } else if (Global.data![i].isSelected ==
                                                1) {
                                              setState(() {
                                                Global.isCompleted = 0;
                                              });
                                              Task s1 = Task(
                                                title: Global.title!,
                                                task: Global.task!,
                                                startTime: Global.startTime!,
                                                endTime: Global.endTime!,
                                                date: Global.myDate!,
                                                reminder: Global.reminder!,
                                                isSelected: Global.isCompleted,
                                              );

                                              int res = await DBHelper.dbHelper
                                                  .update(
                                                      data: s1,
                                                      index: Global.data![i].id!);

                                              if (res == 1) {
                                                setState(() {
                                                  Global.allTask = DBHelper
                                                      .dbHelper
                                                      .selectData();
                                                });
                                              }
                                            }
                                          },
                                          child: (Global.data![i].isSelected == 0)
                                              ? Container(
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                    ),
                                                    shape: BoxShape.circle,
                                                    color: Colors.transparent,
                                                  ),
                                                  child: const Icon(
                                                    Icons.done,
                                                    color: Colors.transparent,
                                                    size: 25,
                                                  ),
                                                )
                                              : Container(
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Colors.transparent,
                                                    ),
                                                    shape: BoxShape.circle,
                                                    color: Colors.green,
                                                  ),
                                                  child: const Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              (Global.data![i].isSelected == 0)
                                                  ? Text(
                                                Global.data![i].title,
                                                      style: GoogleFonts.lato(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    )
                                                  : Text(
                                                Global.data![i].title,
                                                      style: GoogleFonts.lato(
                                                        fontSize: 30,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                              SizedBox(
                                                height: 85,
                                                width: 240,
                                                child: (Global.data![i].isSelected == 0)
                                                    ? Text(
                                                  Global.data![i].task,
                                                        style: GoogleFonts.lato(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      )
                                                    : Text(
                                                  Global.data![i].task,
                                                        style: GoogleFonts.lato(
                                                          fontSize: 25,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Center(
                                        child: Text(
                                          "${Global.data![i].startTime}\nto\n${Global.data![i].endTime}",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.arya(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 19,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child: Text(
                      "Data not found...",
                    ),
                  );
          }
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
                color: Colors.indigo, size: 30),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            num++;
          });
          if (num % 3 == 0) {
            if (AdHelper.adHelper.interstitialAd != null) {
              AdHelper.adHelper.interstitialAd!.show();
              AdHelper.adHelper.loadInterstitialAd();
            }
            Get.to(
              () => const InsertData(),
              duration: const Duration(seconds: 2),
              transition: Transition.fadeIn,
              curve: Curves.easeInOut,
            );
          } else {
            Get.off(
              () => const InsertData(),
              duration: const Duration(seconds: 2),
              transition: Transition.fadeIn,
              curve: Curves.easeInOut,
            );
          }
        },
        elevation: 5,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
