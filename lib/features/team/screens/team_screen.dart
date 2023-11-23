import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:easybook/features/home/screens/homescreen.dart';
import 'package:easybook/features/splash/screen/splash_screen.dart';
import 'package:easybook/features/team/controller/team_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';

// ignore: must_be_immutable
class TeamScreen extends StatelessWidget {
  TeamScreen({super.key, @required this.teamName, @required this.teamId});

  String? teamName = "";
  int? teamId;
  // List<QueryDocumentSnapshot<Object?>>? teamData = [];

  var teamController = Get.put(TeamController());

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> messageStream = FirebaseFirestore.instance
        .collection('bookings')
        .where("teamId", isEqualTo: teamId)
        .orderBy("date", descending: true)
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
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: InkWell(
                  onTap: () {
                    Get.offAll(() => HomeScreen());
                  },
                  child: const Icon(Icons.arrow_back)),
              iconTheme: const IconThemeData(color: Colors.teal),
              elevation: 0,
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    teamName.toString(),
                    style: const TextStyle(color: Colors.teal),
                  ),
                  const SizedBox(
                    width: 40,
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Total Played Hrs: ",
                                    style: GoogleFonts.openSans(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    )),
                                Text(
                                    teamController
                                        .getTotalTeamHrs(snapshot.data!.docs)
                                        .toString(),
                                    style: GoogleFonts.openSans(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Free Played Hrs: ",
                                    style: GoogleFonts.openSans(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    )),
                                Text(
                                    teamController
                                        .getTotalTeamHrsFree(
                                            snapshot.data!.docs)
                                        .toString(),
                                    style: GoogleFonts.openSans(
                                      color: const Color.fromARGB(
                                          255, 247, 244, 246),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("PhoneNumber : ",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(snapshot.data!.docs[0]["mobileNumber"] ?? "",
                                style: GoogleFonts.openSans(
                                  color:
                                      const Color.fromARGB(255, 153, 190, 93),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                _callNumber(snapshot.data!.docs[0]
                                        ["mobileNumber"] ??
                                    "");
                              },
                              child: const Icon(
                                Icons.call_rounded,
                                color: Color.fromARGB(255, 9, 248, 37),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextField(
                                            controller:
                                                teamController.smsController,
                                            decoration: const InputDecoration(
                                                hintText:
                                                    "Type your msg here...",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)))),
                                            maxLines: 5,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
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
                                                    child: const Text("Close")),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                ElevatedButton(
                                                    style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Colors.teal)),
                                                    onPressed: () {
                                                      if (teamController
                                                              .smsController
                                                              .text !=
                                                          "") {
                                                        sendSMSText(
                                                            teamController
                                                                .smsController
                                                                .text
                                                                .toString(),
                                                            [
                                                              snapshot.data!
                                                                          .docs[0]
                                                                      [
                                                                      "mobileNumber"] ??
                                                                  ""
                                                            ]);
                                                        Navigator.pop(context);
                                                      } else {
                                                        showToast(
                                                            msg:
                                                                "Please enter message",
                                                            backgroundColor:
                                                                Colors.grey,
                                                            textColor:
                                                                Colors.white);
                                                      }
                                                    },
                                                    child: const Text("Send")),
                                              ])
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.message,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                                flex: 4,
                                child: Text(
                                  "Date",
                                  style: TextStyle(color: Colors.white),
                                )),
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
                                flex: 4,
                                child: Text(
                                  "Game",
                                  style: TextStyle(color: Colors.white),
                                )),
                            // Expanded(
                            //     flex: 1,
                            //     child: Text(
                            //       "Hr",
                            //       style: TextStyle(color: Colors.white),
                            //     )),
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Paid",
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.end,
                                )),
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
                                top: 10, bottom: 10, left: 10, right: 10),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: Color.fromARGB(255, 175, 214, 247)),
                            height: MediaQuery.of(context).size.height * .70,
                            child: dayBookingDetailsTeam(snapshot.data!.docs)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

Widget dayBookingDetailsTeam(List<QueryDocumentSnapshot<Object?>>? teamData) {
  var teamController = Get.put(TeamController());

  // Row(
  //   children: const [
  //     Text("From"),
  //     Text("To"),
  //     Text("Team"),
  //     Text("Game"),
  //     Text("Status"),
  //   ],
  // ),

  return ListView.builder(
    itemCount: teamData?.length ?? 0,
    itemBuilder: (context, index) {
      return SingleChildScrollView(
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                      teamController.getTime(teamData?[index]["date"] ?? ""))),
              Expanded(
                  flex: 3, child: Text(teamData?[index]["fromTime"] ?? "")),
              Expanded(flex: 3, child: Text(teamData?[index]["toTime"] ?? "")),
              Expanded(flex: 4, child: Text(teamData?[index]["game"] ?? "")),
              // Expanded(flex: 1, child: Text(teamData?[index]["hr"] ?? "")),
              Expanded(
                  flex: 2,
                  child: Text(
                    teamData?[index]["paid"] ?? "",
                    textAlign: TextAlign.end,
                  )),
              // Expanded(flex: 3, child: Text(teamData?[index]["status"] ?? "")),
            ],
          ),
        ),
      );
    },
  );
}

_callNumber(number) async {
  // const number = '08592119XXXX'; //set the number here
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}

void sendSMSText(String message, List<String> recipents) async {
  String result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    // ignore: invalid_return_type_for_catch_error
    return showToast(
        msg: "SMS not sent",
        backgroundColor: Colors.grey,
        textColor: Colors.white);
  });

  // showToast(
  //     msg: "SMS send successfully",
  //     backgroundColor: Colors.grey,
  //     textColor: Colors.white);
}
