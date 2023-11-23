import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easybook/features/home/controller/homescreen_controller.dart';
import 'package:easybook/features/home/screens/searchscreen.dart';
import 'package:easybook/features/home/widgets/bottomsheet.dart';
import 'package:easybook/features/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  var homeController = Get.put(HomeScreenController());

  DateFormat formatter = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.searchListViewFlag.value = false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Easy",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(
                  "Book",
                  style: TextStyle(color: Colors.red, fontSize: 25),
                )
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 15),
            child: Column(
              children: [
                TextField(
                  controller: homeController.selectedTeam,
                  onTap: () {
                    homeController.searchListViewFlag.value = true;
                    Get.to(() => SearchScreen(
                          ishome: true,
                        ));
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_outlined),
                    fillColor: Color.fromARGB(255, 220, 246, 250),
                    filled: true,
                    hintText: 'Search Team',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide:
                          BorderSide(width: 0, color: Color(0xffCEDAD9)),
                    ),
                    contentPadding: EdgeInsets.only(left: 10),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide:
                          BorderSide(width: 0, color: Color(0xffCEDAD9)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide:
                          BorderSide(width: 0, color: Color(0xffCEDAD9)),
                    ),
                  ),
                  autofocus: false,
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 150,
                      child: TextFormField(
                        onTap: () async {
                          await homeController.selectDatePick(
                              context: context,
                              initialDate: homeController.dateController.text !=
                                      ""
                                  ? DateFormat("dd/MM/yyyy")
                                      .parse(homeController.dateController.text)
                                  : DateTime.now()
                              // .subtract(
                              //     const Duration(days: 1),
                              //   ),
                              );
                          // initialDate:
                          //     myOrdersController.dateController.text != ""
                          //         ? DateFormat("dd/MM/yyyy").parse(
                          //             myOrdersController.dateController.text)
                          //         : DateTime.now()
                          //             .subtract(const Duration(days: 1)));
                        },
                        readOnly: true,
                        controller: homeController.dateController,
                        style: GoogleFonts.openSans(
                          color: const Color.fromARGB(255, 41, 42, 41),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        keyboardType: TextInputType.datetime,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.singleLineFormatter,
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9/]'))
                        ],
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 12),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 220, 246, 250),
                            hintText: formatter.format(DateTime.parse(
                                DateTime.now().toString())), //  "DD/MM/YYYY",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintStyle: GoogleFonts.openSans(
                              color: const Color.fromARGB(255, 41, 42, 41),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffCEDAD9),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffCEDAD9),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffCEDAD9),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            suffixIcon: InkWell(
                              child: Icon(Icons.calendar_month_outlined,
                                  color: Colors.grey.shade500),
                              onTap: () async {
                                await homeController.selectDatePick(
                                    context: context,
                                    initialDate: homeController
                                                .dateController.text !=
                                            ""
                                        ? DateFormat("dd/MM/yyyy").parse(
                                            homeController.dateController.text)
                                        : DateTime.now());
                              },
                            )),
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.teal)),
                        onPressed: () {
                          popupSheet(context);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.add_box_outlined),
                            SizedBox(
                              width: 3,
                            ),
                            Text("Add Slot")
                          ],
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      decoration: const BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                "From",
                                style: TextStyle(color: Colors.white),
                              )),
                          Expanded(
                              flex: 3,
                              child: Text(
                                "To",
                                style: TextStyle(color: Colors.white),
                              )),
                          Expanded(
                              flex: 12,
                              child: Text(
                                "Team",
                                style: TextStyle(color: Colors.white),
                              )),
                          Expanded(
                              flex: 4,
                              child: Text(
                                "Game",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.end,
                              )),
                          // Expanded(
                          //     flex: 1,
                          //     child: Text(
                          //       "Hr",
                          //       style: TextStyle(color: Colors.white),
                          //     )),
                          // Expanded(
                          //     flex: 3,
                          //     child: Text(
                          //       "Status",
                          //       style: TextStyle(color: Colors.white),
                          //     )),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 10, right: 10),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Color.fromARGB(255, 220, 246, 250)),
                          height: MediaQuery.of(context).size.height * .65,
                          child: Obx(
                            () {
                              if (homeController.isloading.value) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return dayBookingDetails();
                              }
                            },
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget dayBookingDetails() {
  var homeController = Get.put(HomeScreenController());
  FirebaseFirestore db = FirebaseFirestore.instance;
  // getTeamList();
  final ref = db.collection("bookings").get().then((querySnapshot) {
    homeController.detailsData = querySnapshot.docs;
  });

  homeController.getIdData();

  Timestamp? fetchDate;

  if (homeController.dateController.text == "") {
    DateTime currentDate = DateTime.now();
    DateTime dateOnly =
        DateTime(currentDate.year, currentDate.month, currentDate.day);
    fetchDate = Timestamp.fromDate(dateOnly);
  } else {
    DateTime inputDate =
        DateFormat("dd/MM/yyyy").parse(homeController.dateController.text);
    fetchDate = Timestamp.fromDate(inputDate);
  }

  final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
      .collection('bookings')
      .where("date", isEqualTo: fetchDate)
      // .orderBy("date", descending: true)
      .snapshots();
  return StreamBuilder(
      stream: messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return showToast(
              msg: "Some thing is wrong to get data",
              backgroundColor: Colors.red,
              textColor: Colors.white);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // detailsData = snapshot.data!.docs;
        return
            // Row(
            //   children: const [
            //     Text("From"),
            //     Text("To"),
            //     Text("Team"),
            //     Text("Game"),
            //     Text("Status"),
            //   ],
            // ),
            ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot querySnapShot = snapshot.data!.docs[index];
            return SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  homeController.fetchTeamBookingDetails(
                      querySnapShot["teamId"], querySnapShot["teamName"]);
                },
                child: Slidable(
                  endActionPane: ActionPane(
                      extentRatio: 0.25,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: const EdgeInsets.all(15),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Column(children: [
                                            Icon(
                                              Icons.error_rounded,
                                              size: 30,
                                              color: Colors.red,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Are you sure?",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Do you want to delete?",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ]),
                                          const SizedBox(height: 10),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Color.fromARGB(
                                                                    255,
                                                                    241,
                                                                    104,
                                                                    94))),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text("Cancel")),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.teal)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'bookings')
                                                          .doc(snapshot.data!
                                                              .docs[index].id)
                                                          .delete()
                                                          .then((value) => log(
                                                              "row deleted "))
                                                          .catchError((error) =>
                                                              log("Failed to add user: $error"));
                                                    },
                                                    child: const Text("Yes")),
                                              ])
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          backgroundColor: const Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                        // SlidableAction(
                        //   onPressed: (context) {},
                        //   backgroundColor: const Color(0xFF21B7CA),
                        //   foregroundColor: Colors.white,
                        //   icon: Icons.edit,
                        //   label: 'Edit',
                        // ),
                      ]),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(querySnapShot["fromTime"] ?? ""),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            querySnapShot["toTime"] ?? "",
                          ),
                        ),
                        Expanded(
                          flex: 12,
                          child: Text(querySnapShot["teamName"] ?? ""),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            querySnapShot["game"] ?? "",
                            textAlign: TextAlign.end,
                          ),
                        ),
                        // Expanded(
                        //     flex: 1, child: Text(querySnapShot["hr"] ?? "")),
                        // Expanded(
                        //     flex: 3,
                        //     child: Text(querySnapShot["status"] ?? "")),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      });
}
