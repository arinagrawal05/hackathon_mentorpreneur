// ignore_for_file: must_be_immutable

import 'package:event_mvp_app/Boarding/controller/auth_controller.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Utils/components.dart';
import 'package:event_mvp_app/homepage.dart';
import 'package:event_mvp_app/skill_choosing.dart';
import 'package:event_mvp_app/theme_change_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterDetailspage extends StatefulWidget {
  String phone;
  EnterDetailspage({required this.phone});

  @override
  _EnterDetailspageState createState() => _EnterDetailspageState();
}

class _EnterDetailspageState extends State<EnterDetailspage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _ideaController = TextEditingController();
  List skill = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // randomOtp();
  }

  String? _selectedOption = "I am Mentor";
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    bool isMentorSelected = _selectedOption == "I am Mentor" ? true : false;

    // AuthController controller = Get.put<AuthController>(AuthController());
    return SafeArea(
      child: GetBuilder<AuthController>(builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boldHeading("Let's Get Started!", 28),
                          productTileText("Fill the Form to Continue", 12),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      // height: 100,
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: Text('I am Mentor'),
                            value: 'I am Mentor',
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: Text('I am Entrepreneur'),
                            value: 'I am Entrepreneur',
                            groupValue: _selectedOption,
                            onChanged: (value) {
                              setState(() {
                                _selectedOption = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    customTextfield("Enter Name", _nameController),
                    customTextfield("Enter Age", _ageController,
                        // prefixIcon: const Icon(Icons.person_2_rounded),
                        keyboardType: TextInputType.phone),
                    isMentorSelected
                        ? Column(
                            children: [
                              customTextfield(
                                  "Occupation", _occupationController),
                              skillBox(context, isMentorSelected, []),
                            ],
                          )
                        : Column(
                            children: [
                              customTextfield("Describe Your Bussiness Idea...",
                                  _ideaController,
                                  minLine: 5),
                              skillBox(
                                  context,
                                  isMentorSelected,
                                  FundamentalFunctions.extractKeySkills(
                                      _ideaController.text)),
                            ],
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        spacing: 1.0,
                        runSpacing: 4.0,
                        children: List.generate(
                          skill.length,
                          (index) => skillTag(skill[index]),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          // activeColor: Colors.white,
                          // checkColor: Theme.of(context)
                          //     .buttonTheme
                          //     .colorScheme!
                          //     .inversePrimary,
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        productTileText(
                            "By Signing up, you agree to the Terms of Service\nand Privacy Policy",
                            12),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                controller.isLoading == true
                    ? customCircularLoader("Registering")
                    : boardingButton("Get Started", () {
                        if (isChecked) {
                          controller.addUser(
                              _nameController.text,
                              int.parse(_ageController.text),
                              widget.phone,
                              _selectedOption!.split(" ").toList()[2],
                              skill,
                              _occupationController.text,
                              _ideaController.text,
                              true,
                              true);
                          controller.getUserModel(widget.phone).then((model) {
                            controller.feedUserModel(model);
                            AppUtils.setUserdata(model.toJson());
                          });
                          AppUtils.setpref(true);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          AppUtils.navigatedirect(HomePage(), Get.context!);
                          // BottomNav(index: 0), Get.context!);
                        } else {
                          AppUtils.showSnackMessage(
                              "Please agree to terms & Services");
                        }
                      }, context),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Padding skillBox(
      BuildContext context, bool isMentorSelected, List defaultList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () async {
            if (!isMentorSelected && _ideaController.text.isEmpty) {
              AppUtils.showSnackMessage("Please Describe Your Business Idea");
            } else {
              FundamentalFunctions.extractKeySkills(_ideaController.text);

              List? value = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelectSkills(
                          defaultSkills: isMentorSelected ? null : defaultList,
                        )),
              );
              setState(() {
                skill = value ?? [];
              });
              print(value ?? ["hello"]);
            }
          },
          // icon: Icon(Icons.abc),
          child: Row(
            children: [
              Text(isMentorSelected
                  ? skill.isEmpty
                      ? "Select Skills"
                      : "Re-select Skills"
                  : "Analize Skills"),
              Spacer(),
              Icon(Icons.chevron_right_rounded)
            ],
          )),
    );
  }
}
