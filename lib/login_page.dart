import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  void sendOTP() async {
    EmailAuth.sessionName = "Test Session";

    var response = await EmailAuth.sendOtp(receiverMail: _emailController.text);

    if (response) {
      print("OTP Sent");
    } else {
      print("We Could not sent the OTP");
    }
  }

  void verifyOTP() {
    var response = EmailAuth.validate(
        receiverMail: _emailController.text, userOTP: _otpController.text);
    if (response) {
      print("OTP Verified");
    } else {
      print("Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Image.asset(
                "images/login.png",
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Enter Your Email",
                        suffixIcon: TextButton(
                          onPressed: () => sendOTP(),
                          child: Text("Send OTP"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter Otp",
                        labelText: "OTP",
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () => verifyOTP(),
                      child: Text("Verify OTP"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

