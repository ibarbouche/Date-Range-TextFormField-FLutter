import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BaseInputDateRangeFieldWidget(label: 'Date Range TextFormField Flutter'),
    );
  }
}
class BaseInputDateRangeFieldWidget extends StatefulWidget {
  final String label;


  const BaseInputDateRangeFieldWidget({
    Key key,
    @required this.label,

  }) : super(key: key);

  @override
  _BaseInputDateRangeFieldWidgetState createState() => _BaseInputDateRangeFieldWidgetState(label);
}

class _BaseInputDateRangeFieldWidgetState extends State<BaseInputDateRangeFieldWidget> {
  final TextEditingController _controller = TextEditingController();
  final String label;
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime(DateTime.now().year + 1);

  _BaseInputDateRangeFieldWidgetState(this.label);


  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: firstDate,
        initialLastDate: lastDate,
        firstDate: new DateTime(DateTime.now().year - 50),
        lastDate: new DateTime(DateTime.now().year + 50));
    if (picked != null && picked.length == 2) {
      setState(() {
        firstDate = picked[0];
        lastDate = picked[1];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text('Date Range TextFormField Picker'),
        ),
        body : Center(
          child: Container(
              padding: EdgeInsets.all(10), height: 80,
              child: TextFormField(
                controller: _controller,
                readOnly: true,
                enabled: true,
                onFieldSubmitted: (String dateStr) {
                  final _selectedDate =  "${DateFormat('dd/MM/yyyy').format(firstDate).toString()} - ${DateFormat('dd/MM/yyyy').format(lastDate).toString()}";
                  _controller.value = TextEditingValue(
                    text: _selectedDate,
                    selection: TextSelection.fromPosition(
                      TextPosition(offset: _selectedDate.length),
                    ),
                  );
                },
                onSaved: (String dateStr) {},
                onTap: () async {
                  displayDateRangePicker(context);
                },
                decoration: InputDecoration(
                  hintText: "${DateFormat('dd/MM/yyyy').format(firstDate).toString()} - ${DateFormat('dd/MM/yyyy').format(lastDate).toString()}",
                  hintStyle: TextStyle(
                      color: Colors.black
                  ),
                  hoverColor: Colors.blue,
                  labelText:label,
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.red),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today_outlined,
                  ),
                ),
              )
          ),
        ),
      );
  }
}
