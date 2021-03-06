import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracker/constants/constants.dart';
import 'package:time_tracker/screens/weeklylog_screen.dart';
import 'package:uuid/uuid.dart';

class AddTimeSheetScreen extends StatefulWidget {
  final String weekid;
  const AddTimeSheetScreen({Key? key, required this.weekid}) : super(key: key);

  @override
  _AddTimeSheetScreenState createState() => _AddTimeSheetScreenState();
}

class _AddTimeSheetScreenState extends State<AddTimeSheetScreen> {
  final dateController = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController timeinput2 = TextEditingController();
  TextEditingController description = TextEditingController();
  String contract = "contract 1";
  String activity = "activity 1";
  String task = "task 1";
  var v4 = Uuid().v4();
  String userid = "";

  @override
  void initState() {
    getuser();
    getcontracts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: _mediaQuery.height,
            color: applightColor,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: appdarkColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          size: 40,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        "Timesheet Items",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.weekid),
                      TextField(
                        readOnly: true,
                        controller: dateController,
                        decoration: InputDecoration(
                          hintText: 'Pick your Date',
                          icon: Icon(Icons.calendar_today_outlined),
                        ),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          dateController.text =
                              date.toString().substring(0, 10);
                        },
                      ),
                      TextField(
                        controller:
                            timeinput, //editing controller of this TextField
                        decoration: InputDecoration(
                            icon: Icon(Icons.timer), //icon of text field
                            labelText: "From" //label text of field
                            ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              timeinput.text =
                                  formattedTime; //set the value of text field.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                      TextField(
                        controller:
                            timeinput2, //editing controller of this TextField
                        decoration: InputDecoration(
                            icon: Icon(Icons.timer), //icon of text field
                            labelText: "To" //label text of field
                            ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              timeinput2.text =
                                  formattedTime; //set the value of text field.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                      Container(
                        width: _mediaQuery.width * 0.7,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        child: DropdownButton<String>(
                          dropdownColor: appdarkColor,
                          value: contract,
                          items: <String>[
                            'contract 1',
                            'contract 2',
                            'contract 3'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newval) {
                            contract = newval!;
                            setState(() {});
                          },
                          isExpanded: true,
                          hint: Text(" Select the contract"),
                        ),
                      ),
                      Container(
                        width: _mediaQuery.width * 0.7,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        child: DropdownButton<String>(
                          dropdownColor: appdarkColor,
                          items: <String>[
                            'activity 1',
                            'activity 2',
                            'activity 3'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newval) {
                            activity = newval!;
                            setState(() {});
                          },
                          isExpanded: true,
                          hint: Text(" Activity"),
                        ),
                      ),
                      Container(
                        width: _mediaQuery.width * 0.7,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.0, style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        child: DropdownButton<String>(
                          dropdownColor: appdarkColor,
                          items: <String>['task 1', 'task 2', 'task 3']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newval) {
                            task = newval!;
                            setState(() {});
                          },
                          isExpanded: true,
                          hint: Text(" Task"),
                        ),
                      ),
                      Center(
                        child: TextField(
                          controller: description,
                          keyboardType: TextInputType.multiline,
                          maxLength: null,
                          maxLines: 2,
                          decoration: InputDecoration(
                              icon: Icon(Icons.timer), //icon of text field
                              labelText:
                                  "Write Desciption here" //label text of field
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: TextButton(
                          child: Text("Add",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  appdarkColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: appdarkColor),
                              ))),
                          onPressed: () => {
                            FirebaseFirestore.instance
                                .collection('timesheet')
                                .doc(v4.toString())
                                .set({
                              'id': v4.toString(),
                              'weekid': widget.weekid, // John Doe
                              'date': dateController.text, // Stokes and Sons
                              'from': timeinput.text,
                              'to': timeinput2.text,
                              'contract': contract,
                              'activity': activity,
                              'task': task,
                              'description': description.text,
                              'approved': 0,
                              'userid': userid,
                            }).then((value) {
                              Fluttertoast.showToast(msg: "timesheet created");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => WeeklyLogScreen()));
                            }).catchError((error) =>
                                    print("Failed to add user: $error"))
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2021));
  }

  void getcontracts() {
    FirebaseFirestore.instance
        .collection('contracts')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        print(doc.data());
      });
    });
  }

  Future<void> getuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getString('user')!;
  }
}
