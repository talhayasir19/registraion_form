import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

extension validDigit on String? {
  bool isValidDigit() {
    var length = this?.length;
    if (length != 0) {
      for (var i = 0; i < length!; i++) {
        var code = (this?.codeUnits[i]) ?? 0;
        if (!(code >= 48 && code <= 57)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}

late Size size;
late double screenWidth, screenHeight, fontSize;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GlobalKey<FormState> keyFirstName, keyPhoneNumber;
  late TextEditingController fNameController,
      lNameController,
      emailController,
      passwordController,
      cpController,
      numController;
  //    keyLastName = GlobalKey();
  bool? isChecked = false, texthide = false;

  _MyHomePageState();
  @override
  void initState() {
    super.initState();
    keyFirstName = GlobalKey<FormState>();
    keyPhoneNumber = GlobalKey<FormState>();
    fNameController = TextEditingController();
    lNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    cpController = TextEditingController();
    numController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    fontSize = (screenHeight + screenWidth) / 2;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(126, 145, 214, 1),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: customHeight(size: 0.9),
              child: Form(
                key: keyFirstName,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Registers",
                      style: TextStyle(
                          fontSize: customFontSize(size: 0.07),
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: Color.fromARGB(255, 58, 52, 52),
                                blurRadius: 5,
                                offset: Offset(2, 2))
                          ]),
                    ),
                    SizedBox(
                      width: customWidth(size: 0.8),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: customWidth(size: 0.35),
                              child: TextFormField(
                                controller: fNameController,
                                // key: keyFirstName,
                                validator: ((value) {
                                  if (value!.length == 0) {
                                    return "Enter Name";
                                  } else {
                                    return null;
                                  }
                                }),
                                decoration: InputDecoration(
                                    hintText: "First Name",
                                    fillColor: Colors.white,
                                    // errorStyle: TextStyle(
                                    //     color:
                                    //         Color.fromARGB(255, 247, 241, 241)),
                                    filled: true,
                                    // enabledBorder: InputBorder.none,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ),
                            SizedBox(
                              width: customWidth(size: 0.35),
                              child: TextFormField(
                                controller: lNameController,
                                validator: ((value) {
                                  if (value!.length == 0) {
                                    return "Enter Lastname";
                                  } else {
                                    return null;
                                  }
                                }),
                                // key: keyLastName,
                                decoration: InputDecoration(
                                    hintText: "Lastname",
                                    fillColor: Colors.white,
                                    filled: true,
                                    // enabledBorder: InputBorder.none,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      width: customWidth(size: 0.8),
                      child: TextFormField(
                        controller: emailController,
                        // key: keyFirstName,
                        validator: (value) {
                          var re = RegExp(
                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+.com");
                          if (re.hasMatch(value!)) {
                            return null;
                          } else {
                            return "Invalid format";
                          }
                          //  @[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]
                          // isEmailValid(value);
                          //bool valid = false;
                          // value!.codeUnits.forEach((element) {
                          //   if (element == 64) {
                          //     valid = true;
                          //   }
                          // });
                          // if (valid && isEmailValid(value)) {
                          //   return null;
                          // } else {
                          //   return "Please enter email in correct format";
                          // }
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Color.fromRGBO(96, 117, 194, 1),
                            ),
                            hintText: "Email",
                            fillColor: Colors.white,
                            filled: true,
                            // enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      width: customWidth(size: 0.8),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: texthide!,
                        validator: ((value) {
                          if (isPassValid(value)) {
                            return null;
                          } else {
                            return 'Password should be greater then 8 character\nand contains at least one upper and lowercase letter';
                          }
                        }),
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: (() {
                                setState(() {
                                  if (!texthide!) {
                                    texthide = true;
                                  } else {
                                    texthide = false;
                                  }
                                });
                              }),
                              child: const Icon(
                                Icons.remove_red_eye,
                                color: Color.fromRGBO(81, 97, 156, 1),
                              ),
                            ),
                            hintText: "Password",
                            fillColor: Colors.white,
                            filled: true,
                            errorStyle: TextStyle(
                                fontSize: customFontSize(size: 0.018)),

                            // enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      width: customWidth(size: 0.8),
                      child: TextFormField(
                        controller: cpController,
                        obscureText: texthide!,
                        validator: ((value) {
                          if (value == cpController.text) {
                            return null;
                          } else {
                            return "Passwords donot matched";
                          }
                        }),
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
                            fillColor: Colors.white,
                            filled: true,
                            // enabledBorder: InputBorder.none,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      width: customWidth(size: 0.8),
                      child: Form(
                        key: keyPhoneNumber,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          controller: numController,
                          onChanged: ((value) {
                            keyPhoneNumber.currentState!.validate();
                          }),
                          obscureText: texthide!,
                          validator: ((value) {
                            if (!value!.isEmpty) {
                              if (value.isValidDigit()) {
                                return null;
                              } else {
                                return "Invalid";
                              }
                            }
                          }),
                          decoration: InputDecoration(
                              hintText: "Phone Number",
                              fillColor: Colors.white,
                              filled: true,
                              // enabledBorder: InputBorder.none,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: customWidth(size: 0.8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: this.isChecked,
                              onChanged: ((value) {
                                setState(() {
                                  this.isChecked = value;
                                });
                              })),
                          Text(
                            "I accept the term of use",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: customFontSize(size: 0.03)),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                        onPressed: ((() {
                          if (keyFirstName.currentState!.validate()) {
                            if (!isChecked!) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    "Please agree to the terms and conditions"),
                              ));
                            } else {
                              fNameController.clear();
                              lNameController.clear();
                              emailController.clear();
                              passwordController.clear();
                              cpController.clear();
                              setState(() {
                                isChecked = false;
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Login Successful"),
                              ));
                            }
                          }
                        })),
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            fixedSize: MaterialStatePropertyAll(Size(
                                customWidth(size: 0.8),
                                customHeight(size: 0.07))),
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromRGBO(56, 222, 231, 1))),
                        child: Text(
                          "Register Now",
                          style:
                              TextStyle(fontSize: customFontSize(size: 0.03)),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

double customWidth({double size = 1}) {
  return screenWidth * size;
}

double customHeight({double size = 1}) {
  return screenHeight * size;
}

double customFontSize({double size = 1}) {
  return fontSize * size;
}

bool isEmailValid(String? email) {
  String trim = "    ";
  if (email!.length > 0) {
    trim = email.substring(email.length - 4);
  }
  if (trim == ".com" || trim == ".COM") {
    return true;
  } else {
    return false;
  }
}

bool isPassValid(String? value) {
  bool upperCase = false, lowerCase = false;
  value!.codeUnits.forEach((element) {
    if (element >= 65 && element <= 90) {
      upperCase = true;
    }
    if (element >= 97 && element <= 122) {
      lowerCase = true;
    }
  });

  if (upperCase && lowerCase && value.length >= 8) {
    return true;
  } else {
    return false;
  }
}
