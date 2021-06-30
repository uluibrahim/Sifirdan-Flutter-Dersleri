import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class DateTimePickerKullanimi extends StatefulWidget {
  @override
  _DateTimePickerKullanimiState createState() =>
      _DateTimePickerKullanimiState();
}

class _DateTimePickerKullanimiState extends State<DateTimePickerKullanimi> {
  @override
  Widget build(BuildContext context) {
    DateTime suan = DateTime.now();
    DateTime firstDate = DateTime(2021, suan.month - 3);
    DateTime lastDate = DateTime(2021, suan.month, suan.day + 20);

    TimeOfDay timeNow = TimeOfDay.now();
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: tarihSec(context, suan, firstDate, lastDate),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: saatSec(timeNow),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton saatSec(TimeOfDay timeNow) {
    return ElevatedButton(
      onPressed: () {
        showTimePicker(
          context: context,
          initialTime: timeNow,
          initialEntryMode: TimePickerEntryMode.input,
          cancelText: "Vazgeç",
          helpText: "Saat Seçiniz",
          confirmText: "OK",
        ).then(
          (value) => {
            print(value.format(context)),
            print("${value.hour} ${value.minute}"),
            print(
                "${value.hour.toString().padLeft(2, '0') + ':' + value.minute.toString().padLeft(2, '0')}"),
          },
        );
      },
      child: Text(
        "Saat Seç",
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  ElevatedButton tarihSec(BuildContext context, DateTime suan,
      DateTime firstDate, DateTime lastDate) {
    return ElevatedButton(
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: suan,
          firstDate: firstDate,
          lastDate: lastDate,
          //initialDatePickerMode: DatePickerMode.year,
          errorFormatText: "Hata",
        ).then((value) {
          if (value != null) {
            print(value);
            print(value.toIso8601String());
            print(value.add(Duration(days: 20)));
            //print(formatDate(value, [yyyy, '-', mm, '-', dd]));
            var newFormat = formatDate(value, [yyyy, '-', mm, '-', dd]);
            print(newFormat);
          }
        });
      },
      child: Text(
        "Tarih Seç",
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  AppBar appBar() => AppBar(title: Text("Date  Time Picker"));
}
