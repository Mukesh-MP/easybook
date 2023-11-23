import 'package:easybook/features/home/controller/homescreen_controller.dart';
import 'package:easybook/features/home/screens/searchscreen.dart';
import 'package:easybook/features/splash/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

DateFormat formatter = DateFormat("dd/MM/yyyy");
// List<String> hours = List.generate(12, (index) => (index + 1).toString());

RxList<String> gameItems = ["Football", "Cricket"].obs;
RxList<String> payItems = ["Paid", "Free"].obs;

popupSheet(context) {
  var controller = Get.put(HomeScreenController());

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          actionsPadding: const EdgeInsets.all(0),
          insetPadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(15),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.teal,
                        size: 22,
                      ),
                    )
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add Slot",
                      style: TextStyle(fontSize: 26, color: Colors.teal),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .36,
                      child: TextFormField(
                        onTap: () async {
                          await controller.selectDatePickEntry(
                              context: context,
                              initialDate:
                                  controller.dateControllerEntry.text != ""
                                      ? DateFormat("dd/MM/yyyy").parse(
                                          controller.dateControllerEntry.text)
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
                        controller: controller.dateControllerEntry,
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
                                await controller.selectDatePickEntry(
                                    context: context,
                                    initialDate: controller
                                                .dateControllerEntry.text !=
                                            ""
                                        ? DateFormat("dd/MM/yyyy").parse(
                                            controller.dateControllerEntry.text)
                                        : DateTime.now());
                              },
                            )),
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("From :"),
                  SizedBox(
                      height: 60,
                      width: 60,
                      child: CupertinoPicker(
                        itemExtent: 30,
                        onSelectedItemChanged: (value) {
                          controller.fromTime = value < 12
                              ? value == 11
                                  ? "${value + 1} PM"
                                  : "${value + 1} AM".toString()
                              : value == 23
                                  ? "${value - 11} AM"
                                  : "${value - 11} PM";
                        },
                        children: List.generate(24, (index) {
                          return Center(
                            child: Text(
                              index < 12
                                  ? index == 11
                                      ? "${index + 1} PM"
                                      : "${index + 1} AM".toString()
                                  : index == 23
                                      ? "${index - 11} AM"
                                      : "${index - 11} PM",
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        }),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text("To :"),
                  SizedBox(
                      height: 60,
                      width: 60,
                      child: CupertinoPicker(
                        itemExtent: 30,
                        onSelectedItemChanged: (value) {
                          controller.toTime = value < 12
                              ? value == 11
                                  ? "${value + 1} PM"
                                  : "${value + 1} AM".toString()
                              : value == 23
                                  ? "${value - 11} AM"
                                  : "${value - 11} PM";
                        },
                        children: List.generate(24, (index) {
                          return Center(
                            child: Text(
                              index < 12
                                  ? index == 11
                                      ? "${index + 1} PM"
                                      : "${index + 1} AM".toString()
                                  : index == 23
                                      ? "${index - 11} AM"
                                      : "${index - 11} PM",
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        }),
                      )),
                ]),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.selectedTeam,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.searchListViewFlag.value = true;
                          Get.to(() => SearchScreen());
                        },
                        icon: const Icon(
                          Icons.search_outlined,
                          size: 30,
                          color: Colors.teal,
                        )),
                    hintText: 'Search Team',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffCEDAD9)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffCEDAD9)),
                    ),
                    contentPadding: const EdgeInsets.only(left: 10),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide:
                          BorderSide(width: 1, color: Color(0xffCEDAD9)),
                    ),
                  ),
                  onChanged: (value) {
                    controller.selectedTeamID = null;
                  },
                  onEditingComplete: () {
                    controller.selectedTeamID = null;
                  },
                  onSubmitted: (value) {
                    controller.selectedTeamID = null;
                  },
                  autofocus: false,
                  style: const TextStyle(
                      color: Colors.blueGrey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .35,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              width: 1, color: const Color(0xffCEDAD9))),
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: controller.selectedGame?.value.toString(),
                            hint: const Text("Game"),
                            items: gameItems
                                .map<DropdownMenuItem<String>>((String? value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value ?? "Football",
                                  style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.selectedGame?.value =
                                  value ?? "Football";
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .35,
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              width: 1, color: const Color(0xffCEDAD9))),
                      child: Obx(
                        () => DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: controller.selectedPay?.value.toString(),
                            hint: const Text("Payment"),
                            items: payItems
                                .map<DropdownMenuItem<String>>((String? value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value ?? "Paid",
                                  style: const TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.selectedPay?.value = value ?? "Paid";
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.bottom,
                          validator: (value) {
                            if (controller.fromTime == "") {
                              return 'Please select from time';
                            }
                            if (controller.toTime == "") {
                              return 'Please select to time';
                            }
                            if (value!.isEmpty) {
                              return 'Please enter mobile number';
                            } else if (value.length > 10 || value.length < 10) {
                              return 'Please enter 10 digit mobile number';
                            }
                            return null;
                          },
                          controller: controller.mobileNumber,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500),
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xffCEDAD9)),
                            ),
                            hintText: "Enter Mobile Number",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                    onPressed: () async {
                      if (controller.fromTime == "") {
                        showToast(
                            msg: "Please select from time",
                            backgroundColor: Colors.red,
                            textColor: Colors.white);
                      } else if (controller.toTime == "") {
                        showToast(
                            msg: "Please select to time",
                            backgroundColor: Colors.red,
                            textColor: Colors.white);
                      } else if (controller.fromTime.toString().toUpperCase() ==
                          controller.toTime.toString().toUpperCase()) {
                        showToast(
                            msg: "From time and to time must be different",
                            backgroundColor: Colors.red,
                            textColor: Colors.white);
                      } else if (controller.selectedTeam.text == "") {
                        showToast(
                            msg: "Please select or enter a team name",
                            backgroundColor: Colors.red,
                            textColor: Colors.white);
                      } else if (controller.mobileNumber.text
                              .toString()
                              .length ==
                          10) {
                        await controller.newBooking();

                        Navigator.pop(context);
                      } else {
                        showToast(
                            msg: "Please enter 10 digit number",
                            backgroundColor: Colors.grey,
                            textColor: Colors.white);
                      }
                      // to do
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, right: 8, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Save",
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ));
    },
  );
}
