import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easybook/features/home/controller/homescreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SearchFundList extends StatelessWidget {
  SearchFundList({super.key, this.isHome = false});

  bool isHome;
  var homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .8,
      child: Obx(
        () => ListView.builder(
          itemCount: homeController.filteredSearchList != null
              ? homeController.filteredSearchList.length
              : 0,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  if (isHome) {
                    homeController.fetchTeamBookingDetails(
                        homeController.filteredSearchList[index].teamId,
                        homeController.filteredSearchList[index].teamName);
                  } else {
                    Navigator.pop(context);
                    homeController.selectedTeam.text =
                        homeController.filteredSearchList[index].teamName;
                    homeController.setMobileNumber(
                        homeController.filteredSearchList[index].teamId);
                  }
                },
                child: Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        homeController.filteredSearchList[index].teamName,
                        style: GoogleFonts.openSans(
                          color: const Color.fromARGB(255, 247, 5, 82),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                ));
          },
        ),
      ),
    );
  }
}
