import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:partner_with_us/widgets/custom_textField.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isExpanded = false;
  late Color buttonBackgroundColor;
  late Color buttonBackgroundColor2;
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fssaiController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackBar = SnackBar(
      content: Text(
        title,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var cred = await FirebaseAuth.instance.signInWithCredential(credential);
    // Once signed in, return the UserCredential
    return cred;
  }

  void signUp() {
    //name validation
    if (nameController.text.length < 3) {
      showSnackBar('Name should have more than 2 characters');
      return;
    }

    //email validation
    if (!(RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailController.text) &&
        emailController.text.length > 0)) {
      showSnackBar('Please Enter a proper Email address');
      return;
    }

    //contact validation
    if (contactController.text.length < 10) {
      showSnackBar('Please Enter a proper Contact number');
      return;
    }

    //fssai validation
    if (fssaiController.text.length < 14 || fssaiController.text.length > 14) {
      showSnackBar('FSSAI number cannot be greater or less than 14 characters');
      return;
    }

    //description validation
    if (descriptionController.text.length < 0) {
      showSnackBar('Please write description');
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => Dialog(
        elevation: 5,
        child: Container(
          alignment: Alignment.center,
          height: 200,
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Registration Complete',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 30,
                  fontFamily: 'Quicksand-SemiBold',
                  
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Back',
                  style: TextStyle(
                    fontFamily: 'Quicksand-SemiBold',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    buttonBackgroundColor = Color(0xFFFCB140);
    buttonBackgroundColor2 = Color(0xFFFCB140);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Color(0xFFFE7A16),
                ),
                height: 240,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'images/icon.jpg',
                      fit: BoxFit.contain,
                      height: 170,
                      width: 170,
                    ),
                    Text(
                      'Partner With Us',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quicksand-SemiBold',
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomTextField(
                        hintAndLabelText: 'Name',
                        controller: nameController,
                        keynoardType: TextInputType.name,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintAndLabelText: 'Contact No.',
                        controller: contactController,
                        keynoardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintAndLabelText: 'Email',
                        controller: emailController,
                        keynoardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        hintAndLabelText: 'FSSAI Number',
                        controller: fssaiController,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orangeAccent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ExpansionTile(
                          textColor: Colors.orange,
                          collapsedTextColor: Colors.orange,
                          iconColor: Colors.orangeAccent,
                          collapsedIconColor: Colors.orangeAccent,
                          title: Text('Address'),
                          childrenPadding: EdgeInsets.all(3),
                          children: [
                            CustomTextField(
                              hintAndLabelText: 'Street/ Building No.',
                              controller: buildingController,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              hintAndLabelText: 'State',
                              controller: stateController,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              hintAndLabelText: 'PIN',
                              controller: pinController,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
                        style: TextStyle(
                          color: Colors.orange,
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.orangeAccent,
                            ),
                          ),
                          hintText: 'Description',
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Colors.orange,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.orange.shade200,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 70,
              color: Color(0xFFFE7A16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: signUp,
                    onTapDown: (var tapDetails) {
                      setState(() {
                        buttonBackgroundColor = Colors.deepOrange;
                      });
                    },
                    onTapUp: (var tapDetails) {
                      setState(() {
                        buttonBackgroundColor = Color(0xFFFCB140);
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: buttonBackgroundColor,
                        border: Border.all(
                          color: Colors.white60,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Quicksand-SemiBold',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                    },
                    onTapDown: (var tapDetails) {
                      setState(() {
                        buttonBackgroundColor2 = Colors.deepOrange;
                      });
                    },
                    onTapUp: (var tapDetails) {
                      setState(() {
                        buttonBackgroundColor2 = Color(0xFFFCB140);
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: buttonBackgroundColor2,
                        border: Border.all(
                          color: Colors.white60,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(5),
                          topLeft: Radius.circular(5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Quicksand-SemiBold',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 200);
    path.quadraticBezierTo(size.width / 2, 270, size.width, 200);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
