import 'package:checkbox_list/checkbox_list.dart';
import 'package:event_mvp_app/Utils/components.dart';
import 'package:event_mvp_app/Utils/const.dart';
import 'package:flutter/material.dart';

class SelectSkills extends StatefulWidget {
  final List? defaultSkills;

  const SelectSkills({super.key, this.defaultSkills});
  @override
  State<SelectSkills> createState() => _SelectSkillsState();
}

class _SelectSkillsState extends State<SelectSkills> {
  List selectedItem = [];

  @override
  Widget build(BuildContext context) {
    List? defaultSkillsa = widget.defaultSkills;
    return WillPopScope(
        onWillPop: () async {
          _showExitDialog(context);
          // _showExitDialog(context);
          return false; // Prevents the default back button behavior
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Select Skills'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.defaultSkills == null) {
                        Navigator.pop(context, selectedItem);
                      } else {
                        selectedItem.addAll(widget.defaultSkills!);
                        Navigator.pop(context, selectedItem);
                      }
                    },
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
            body: Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      defaultSkillsa != null
                          ? Column(
                              children: [
                                boldHeading(
                                    "We Have Selected These For You", 20),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Wrap(
                                    alignment: WrapAlignment.start,
                                    runAlignment: WrapAlignment.start,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    spacing: 1.0,
                                    runSpacing: 4.0,
                                    children: List.generate(
                                      defaultSkillsa.length,
                                      (index) =>
                                          skillTag(defaultSkillsa![index]),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: CustomCheckBox(
                          checkBoxWidth: 25,
                          checkBoxHeight: 25,
                          onChanged: (value) {
                            // selectedItem.add()
                            // extractorNew();
                            // setState(() {
                            // if (defaultSkillsa == null) {
                            selectedItem = value;
                            // } else {
                            //   defaultSkillsa = value;
                            // }
                            // });
                            print(defaultSkillsa);
                          },
                          shape: BoxShape.circle,
                          checkBoxSplashRadius: 15,
                          multipleChoice: true,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          checkboxList: defaultSkillsa != null
                              ? SkillsConst.allItems
                                  .where((element) =>
                                      !defaultSkillsa!.contains(element))
                                  .toList()
                              : SkillsConst.allItems,
                          labelTextStyle: const TextStyle(),
                          paddingBetweenTitleAndCheckBox: 15,
                          checkBoxIcon: const Icon(Icons.check),
                          iconSize: 0.8,
                          clickableLabel: true,
                          borderColor:
                              Theme.of(context).textTheme.bodyLarge!.color!,
                          borderRadius: BorderRadius.circular(4),
                          selectedBoxColor: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .inversePrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}

Future<void> _showExitDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Exit'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Do you want to exit without selecting any skill?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Navigate back to Screen 1
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
