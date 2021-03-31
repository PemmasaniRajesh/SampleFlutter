import 'package:flutter/material.dart';
import 'package:flutter_application/models/contact_models.dart';
import 'package:intl/intl.dart';

class ContactForm extends StatefulWidget {
  @override
  ContactFormState createState() => ContactFormState();
}

class ContactFormState extends State {
  final _contact = Contact();

  DateTime _initialDate = DateTime.now();
  String selDate = "";
  TextEditingController _textEditingController = TextEditingController();

  _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _initialDate,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        selDate = DateFormat('yyyy/MM/dd').format(_initialDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Contact"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Builder(
            builder: (context) => Form(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 1,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Name is required";
                          } else {
                            return "";
                          }
                        },
                        onSaved: (val) => setState(() => {_contact.nm = val}),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Mobile",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Mob is required";
                          } else {
                            return "";
                          }
                        },
                        onSaved: (val) => setState(() => {_contact.mob = val}),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: CheckboxListTile(
                                title: const Text("Male"),
                                value: false,
                                onChanged: (val) {
                                  setState(() {});
                                }),
                          ),
                          Expanded(
                              child: CheckboxListTile(
                                  title: const Text("Female"),
                                  value: false,
                                  onChanged: (val) {
                                    setState(() {});
                                  })),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          labelText: "Date",
                          border: OutlineInputBorder(),
                        ),
                        autofocus: false,
                        readOnly: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Date is required";
                          } else {
                            return "";
                          }
                        },
                        onSaved: (val) =>
                            setState(() => {_contact.dob = selDate}),
                        onTap: () async {
                          // Below line stops keyboard from appearing
                          FocusScope.of(context).requestFocus(new FocusNode());
                          await _selectDate();
                          _textEditingController.text = selDate;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextButton(
                        onPressed: () {
                          final snackBar = SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text("Sample SnackBar"));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Text("Save"),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.blue,
                            textStyle: TextStyle(
                                fontSize: 24, fontStyle: FontStyle.normal)),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                )),
      ),
    );
  }
}
