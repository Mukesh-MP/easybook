import 'dart:developer';

import 'package:easybook/features/home/model/bookingdetails_model.dart';

import 'package:easybook/features/splash/screen/splash_screen.dart';
import 'package:easybook/features/team/screens/team_screen.dart';
import 'package:easybook/global/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

// List<BookingDetails> bookingDetails = [];

class HomeScreenController extends GetxController {
  // Firebase

  RxBool isloading = false.obs;

  FirebaseDatabase database = FirebaseDatabase.instance;

  DatabaseReference ref = FirebaseDatabase.instance.ref("booking/1");

// for to take maximum of id's
  int currentGameId = 0;
  int currentTeamId = 0;

  RxBool searchListViewFlag = false.obs;
  TextEditingController dateController = TextEditingController();
  TextEditingController dateControllerEntry = TextEditingController();
  RxInt selectedHour = 1.obs;

  TextEditingController selectedTeam = TextEditingController();

  TextEditingController mobileNumber = TextEditingController(text: "");

  RxString? selectedGame = "Football".obs;

  RxString? selectedPay = "Paid".obs;
  int? selectedTeamID;

  String fromTime = '';
  String toTime = '';

  int playedhrs = 1;

  List<QueryDocumentSnapshot<Object?>>? detailsData;

  // List<BookingDetails> bookingDetails = [];
  List<BookingDetails> uniqueTeamList = [];

  RxList filteredSearchList = [].obs;
  String? clientId = "0";

  @override
  void onInit() async {
    super.onInit();

    clientId = Shared().getClientId();
    // clientId = await CommonStorage().clientId;
  }

  filterSearchResultData({String? searchValue}) async {
    log(ref.toString());

    filteredSearchList.value = [];

    detailsData!.where((element) {
      if (uniqueTeamList.any((e) => element["teamId"] == e.teamId)) {
        return false;
      } else {
        uniqueTeamList.add(BookingDetails(
            teamId: element["teamId"], teamName: element["teamName"]));
        return true;
      }
    }).toList();

    // uniqueTeamList = bookingDetails.toSet().toList();

    filteredSearchList.value = uniqueTeamList
        .where((map) =>
            map.teamName!.toLowerCase().startsWith(searchValue!.toLowerCase()))
        .toList();
    log(filteredSearchList.length.toString());
    log(filteredSearchList.toString());
  }

  selectDatePick({
    @required BuildContext? context,
    @required DateTime? initialDate,
  }) async {
    DateTime? dateOfOrder;
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    dateOfOrder = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.teal,
              colorScheme: const ColorScheme.light(primary: Colors.teal),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
        context: context!,
        initialDate: initialDate!,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 365))
        // .subtract(
        //   const Duration(days: 1),
        // ),
        );
    if (dateOfOrder != null) {
      dateController.text =
          formatter.format(DateTime.parse(dateOfOrder.toString()));
      isloading.value = true;
      Future.delayed(const Duration(seconds: 1), () {
        isloading.value = false;
      });
      // do
    } else {
      dateController.text;
    }
  }

  selectDatePickEntry({
    @required BuildContext? context,
    @required DateTime? initialDate,
  }) async {
    DateTime? dateOfOrderEntry;
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    dateOfOrderEntry = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.teal,
              colorScheme: const ColorScheme.light(primary: Colors.teal),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
        context: context!,
        initialDate: initialDate!,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 365))
        // .subtract(
        //   const Duration(days: 1),
        // ),
        );
    if (dateOfOrderEntry != null) {
      dateControllerEntry.text =
          formatter.format(DateTime.parse(dateOfOrderEntry.toString()));
      // do
    } else {
      dateControllerEntry.text;
    }
  }

  fetchTeamBookingDetails(int id, String teamName) {
    // List<QueryDocumentSnapshot<Object?>>? teamBookingDetails = [];

    // teamBookingDetails =
    //     detailsData!.where((element) => element["teamId"] == id).toList();

    Get.to(() => TeamScreen(teamName: teamName, teamId: id));
  }

  setMobileNumber(teamID) {
    List<QueryDocumentSnapshot<Object?>>? teamBookingDetails = [];
    selectedTeamID = teamID;
    teamBookingDetails =
        detailsData!.where((element) => element["teamId"] == teamID).toList();
    mobileNumber.text =
        teamBookingDetails[teamBookingDetails.length - 1]["mobileNumber"] ?? "";
  }

  newBooking() async {
    isloading.value = true;
    await getHrs(from: fromTime, to: toTime);
    getTeamList();
    Timestamp date;
    if (dateControllerEntry.text == "") {
      DateTime currentDate = DateTime.now();
      DateTime dateOnly =
          DateTime(currentDate.year, currentDate.month, currentDate.day);
      date = Timestamp.fromDate(dateOnly);
    } else {
      DateTime inputDate =
          DateFormat("dd/MM/yyyy").parse(dateControllerEntry.text);
      date = Timestamp.fromDate(inputDate);
    }

    log("date :  $date");

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference bookings = firestore.collection('bookings$clientId');

    bookings.add({
      "gameId": currentGameId + 1, // detailsData!.length + 1,
      "teamId": selectedTeamID == null || selectedTeamID == ""
          ? currentTeamId + 1
          : selectedTeamID,
      "teamName": selectedTeam.text,
      "date": date,
      "fromTime": fromTime,
      "toTime": toTime,
      "status": "Pending",
      "hr": playedhrs,
      "game": selectedGame?.value,
      "paid": selectedPay?.value,
      "mobileNumber": mobileNumber.text
    }).then((value) {
      sendSMSText(
          "Your Booking for slot from $fromTime to $toTime ${dateControllerEntry.text == "" ? "for today" : "for the date ${dateControllerEntry.text.toString()}"}  is confirmed ",
          [mobileNumber.text.toString()]);
      showToast(
          msg:
              "${selectedTeam.text} booking for slot from $fromTime to $toTime  for the date ${dateControllerEntry.text.toString()} is confirmed",
          backgroundColor: Colors.grey,
          textColor: Colors.white);
      log("User Added $value");
    }).catchError((error) {
      log("Failed to add user: $error");
    });

    isloading.value = false;
  }

  getTeamList() {
    uniqueTeamList.clear();
    detailsData!.where((element) {
      if (uniqueTeamList.any((e) => element["teamId"] == e.teamId)) {
        return false;
      } else {
        uniqueTeamList.add(BookingDetails(
            teamId: element["teamId"], teamName: element["teamName"]));
        return true;
      }
    }).toList();
  }

  getHrs({String? from, String? to}) {
    try {
      int fromHrs = int.parse(from!.substring(0, from.length - 3));
      String fromStr = from.substring(from.length - 2);

      int toHrs = int.parse(to!.substring(0, to.length - 3));
      String toStr = to.substring(to.length - 2);

      if (fromStr == "AM" && toStr == "AM") {
        if (fromHrs == 12) {
          playedhrs = toHrs;
        } else {
          if (toHrs < fromHrs) {
            playedhrs = (toHrs + 24) - fromHrs;
          } else {
            playedhrs = toHrs - fromHrs;
          }
        }
      } else if (fromStr == "AM" && toStr == "PM") {
        if (fromHrs == 12 && toHrs == 12) {
          playedhrs = 12;
        } else if (fromHrs == 12) {
          playedhrs = 12 + toHrs;
        } else if (toHrs == 12) {
          playedhrs = toHrs - fromHrs;
        } else {
          playedhrs = (toHrs + 12) - fromHrs;
        }
      } else if (fromStr == "PM" && toStr == "AM") {
        if (fromHrs == 12 && toHrs == 12) {
          playedhrs = 12;
        } else if (fromHrs == 12) {
          playedhrs = toHrs + 12;
        } else if (toHrs == 12) {
          playedhrs = toHrs - fromHrs;
        } else {
          playedhrs = (toHrs + 12) - fromHrs;
        }
      } else if (fromStr == "PM" && toStr == "PM") {
        if (fromHrs == 12) {
          playedhrs = toHrs;
        } else {
          if (toHrs < fromHrs) {
            playedhrs = (toHrs + 24) - fromHrs;
          } else {
            playedhrs = toHrs - fromHrs;
          }
        }
      }
      log("played hrs : $playedhrs");
    } catch (e) {
      log(e.toString());
      playedhrs = 1;
    }
  }

  getIdData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshotGameId = await db
        .collection("bookings$clientId")
        .orderBy('gameId', descending: true)
        .limit(1)
        .get();

    // Check if there is any document
    if (querySnapshotGameId.docs.isNotEmpty) {
      currentGameId = querySnapshotGameId.docs.first.get('gameId') ?? 0;
    }

    QuerySnapshot querySnapshotTeamId = await db
        .collection("bookings$clientId")
        .orderBy('teamId', descending: true)
        .limit(1)
        .get();

    // Check if there is any document
    if (querySnapshotTeamId.docs.isNotEmpty) {
      currentTeamId = querySnapshotTeamId.docs.first.get('teamId') ?? 0;
    }
  }
}
