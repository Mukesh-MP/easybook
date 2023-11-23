import 'package:easybook/features/home/controller/homescreen_controller.dart';
import 'package:easybook/features/home/screens/searchlistview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key, this.ishome = false});

  bool ishome;
  var homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        homeController.searchListViewFlag.value = false;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                TextField(
                  controller: homeController.selectedTeam,
                  onTap: () {
                    homeController.searchListViewFlag.value = true;
                  },
                  onChanged: (String value) {
                    homeController.filterSearchResultData(searchValue: value);
                    // switchFundController.getSearchSwitchFundList(value,
                    //     fundId: widget.fundID);
                  },
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 220, 246, 250),
                    filled: true,
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.teal,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          homeController.selectedTeam.text = "";
                        },
                        icon: const Icon(
                          Icons.clear_rounded,
                          color: Colors.teal,
                          size: 30,
                        )),
                    hintText: 'Search Team',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide:
                          BorderSide(width: 0, color: Color(0xffCEDAD9)),
                    ),
                    contentPadding: const EdgeInsets.only(left: 10),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide:
                          BorderSide(width: 0, color: Color(0xffCEDAD9)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                      borderSide:
                          BorderSide(width: 0, color: Color(0xffCEDAD9)),
                    ),
                  ),
                  autofocus: true,
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Visibility(
                      visible: homeController.searchListViewFlag.value,
                      child: SearchFundList(isHome: ishome)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
