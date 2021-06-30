import 'package:flutter/material.dart';

class StepperKullanimi extends StatefulWidget {
  @override
  _StepperKullanimiState createState() => _StepperKullanimiState();
}

class _StepperKullanimiState extends State<StepperKullanimi> {
  int _currentStep = 0;
  String _ad, _email, _password;
  final keyAd = GlobalKey<FormFieldState>();
  AutovalidateMode adValidateMode = AutovalidateMode.disabled;
  final keyEmail = GlobalKey<FormFieldState>();
  AutovalidateMode emailValidateMode = AutovalidateMode.disabled;
  final keyPassword = GlobalKey<FormFieldState>();
  AutovalidateMode passwordValidateMode = AutovalidateMode.disabled;

  bool error = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Stepper(
          steps: _steps(),
          currentStep: _currentStep,
          /**
            onStepTapped: (tiklanilanStep) {
            setState(() {
              _currentStep = tiklanilanStep;
            });
          },
           */

          onStepContinue: () {
            setState(() {
              _continueButtonControl();
            });
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep > 0) {
                _currentStep--;
              }
            });
          },
        ),
      ),
    );
  }

  List<Step> _steps() {
    List<Step> stepler = [
      Step(
        title: Text("Adınız"),
        subtitle: Text("Adınızı giriniz"),
        state: _stepSateteKontrol(0),
        content: TextFormField(
          autovalidateMode: adValidateMode,
          key: keyAd,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          validator: (String value) {
            if (value.length < 3) {
              return "Hatalı giriş";
            } else {
              return null;
            }
          },
          onSaved: (value) {
            _ad = value;
          },
        ),
      ),
      Step(
        title: Text("Email"),
        subtitle: Text("Email giriniz"),
        state: _stepSateteKontrol(1),
        content: TextFormField(
          key: keyEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          validator: (String value) {
            if (value.length < 6 && !value.contains("@")) {
              return "Hatalı giriş";
            } else {
              return null;
            }
          },
          onSaved: (value) {
            _email = value;
          },
        ),
      ),
      Step(
        title: Text("Şifre"),
        subtitle: Text("Şifre giriniz"),
        state: _stepSateteKontrol(2),
        isActive: false,
        content: TextFormField(
          key: keyPassword,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_open_sharp),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          validator: (String value) {
            if (value.length < 6) {
              return "Hatalı giriş";
            } else {
              return null;
            }
          },
          onSaved: (value) {
            _password = value;
          },
        ),
      ),
    ];

    return stepler;
  }

  StepState _stepSateteKontrol(int i) {
    if (_currentStep == i) {
      if (error) {
        return StepState.error;
      } else {
        return StepState.editing;
      }
    } else {
      return StepState.complete;
    }
  }

  AppBar appBar() => AppBar(title: Text("Stepper"));

  void _continueButtonControl() {
    switch (_currentStep) {
      case 0:
        if (keyAd.currentState.validate()) {
          keyAd.currentState.save();
          error = false;
          _currentStep++;
        } else {
          error = true;
        }
        break;
      case 1:
        if (keyEmail.currentState.validate()) {
          keyAd.currentState.save();
          error = false;
          _currentStep++;
        } else {
          error = true;
        }
        break;
      case 2:
        if (keyPassword.currentState.validate()) {
          keyAd.currentState.save();
          error = false;
        } else {
          error = true;
        }
        break;
      default:
    }
  }
}
