import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TeamController extends GetxController {
  TextEditingController smsController = TextEditingController();

  int getTotalTeamHrs(teamData) {
    int totalTeamHrs = 0;
    for (var i = 0; i < teamData.length; i++) {
      if (teamData[i]["paid"].toString().toUpperCase() == "PAID") {
        totalTeamHrs = totalTeamHrs + (int.parse(teamData[i]["hr"].toString()));
      }
    }

    return totalTeamHrs;
  }

  int getTotalTeamHrsFree(teamData) {
    int totalTeamHrsFree = 0;
    for (var i = 0; i < teamData.length; i++) {
      if (teamData[i]["paid"].toString().toUpperCase() == "FREE") {
        totalTeamHrsFree =
            totalTeamHrsFree + (int.parse(teamData[i]["hr"].toString()));
      }
    }

    return totalTeamHrsFree;
  }

  String getTime(var time) {
    final DateFormat formatter =
        DateFormat('dd/MM/yyyy'); //your date format here
    var date = time.toDate();
    return formatter.format(date);
  }
}
