import 'dart:io';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static const routName = '/profileScreen';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _coformPasswordController = TextEditingController();

  bool login = true;
  bool progressIndicator = false;
  List loginData = [];
  // String? imageUrl;
  // Widget? imageFile;
  File? fileImage;

  // pickedImage() async {
  //   final _imagePicker = ImagePicker();
  //   XFile? image;
  //
  //   image = await _imagePicker.pickImage(source: ImageSource.gallery);
  //   File file = File(image!.path);
  //   setState(() {
  //     fileImage = file;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 100),
                  Stack(
                    children: [
                      CircleAvatar(
                          radius: 80,
                          child: fileImage != null
                              ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipOval(
                                child: Image.file(
                                  fileImage!,
                                  fit: BoxFit.cover,
                                )),
                          )
                              : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipOval(
                                // child: Image.asset(
                                //   'assets/images/default.jpg',
                                //   fit: BoxFit.cover,
                                // )
                            ),
                          )),
                      Positioned(
                        left: 110,
                        top: 110,
                        child: IconButton(
                            onPressed: () {
                              // pickedImage();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Color(0xFFF57F17),
                            )),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .03,
                  right: MediaQuery.of(context).size.width * .03,
                ),
                height: MediaQuery.of(context).size.height * .5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffebfaf8).withOpacity(0.6100000143051147),
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(flex: 1, child: Container()),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03,
                          right: MediaQuery.of(context).size.width * 0.03),
                      child: TextField(
                          controller: _userNameController,
                          cursorColor: Colors.yellow,
                          decoration: InputDecoration(
                              hintText: 'Nick Name',
                              contentPadding: EdgeInsets.all(15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                  BorderSide(color: Color(0xFFF57F17))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                  BorderSide(color: Color(0xFFF57F17))))),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03,
                          right: MediaQuery.of(context).size.width * 0.03),
                      child: TextField(
                          controller: _emailController,
                          cursorColor: Colors.yellow,
                          decoration: InputDecoration(
                              hintText: 'Enter Your Email',
                              contentPadding: EdgeInsets.all(15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Color(0xFFF57F17))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                  BorderSide(color: Color(0xFFF57F17))))),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03,
                          right: MediaQuery.of(context).size.width * 0.03),
                      child: TextField(
                        // focusNode: FocusNode(),
                        //   autofocus: false,
                          controller: _passwordController,
                          cursorColor: Colors.yellow,
                          decoration: InputDecoration(
                              hintText: 'DOB',
                              contentPadding: EdgeInsets.all(15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Color(0xFFF57F17))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide:
                                  BorderSide(color: Color(0xFFF57F17))))),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03,
                          right: MediaQuery.of(context).size.width * 0.03),
                      decoration: BoxDecoration(
                          color: Colors.yellow[900],
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    // SizedBox(height: 10),
                    // InkWell(
                    //   onTap: () {
                    //     // setState(() {
                    //     //   login = !login;
                    //     // });
                    //   },
                    //   child: Container(
                    //     child: Text(
                    //       login ? 'Not have an account ? SignUp' : 'Back to login',
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold, color: Colors.blue),
                    //     ),
                    //   ),
                    // ),
                    Flexible(flex: 1, child: Container()),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  // logInUser() async {
  //   if (_emailController.text.isNotEmpty ||
  //       _passwordController.text.isNotEmpty) {
  //     try {
  //       await FirebaseAuth.instance.signInWithEmailAndPassword(
  //           email: _emailController.text, password: _passwordController.text);
  //
  //       // setState(() {
  //       //   loginData = [
  //       //     {
  //       //       'name': _userNameController.text,
  //       //       'email': _emailController.text,
  //       //       'password': _passwordController.text
  //       //     }
  //       //   ];
  //       // });
  //       //
  //       final prefs = await SharedPreferences.getInstance();
  //       await prefs.setBool('login', true);
  //       // await prefs.setString('login', json.encode(loginData));
  //       // final String? action = prefs.getString('login');
  //       // var data = json.decode(action!);
  //       // print('--------------data-------------------$data');
  //
  //       // Navigator.of(context)
  //       //     .pushReplacement(MaterialPageRoute(builder: (context) {
  //       //   return MyHomePage();
  //       }));
  //
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('You are Logged in')));
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'user-not-found') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('No user Found with this Email')));
  //       } else if (e.code == 'wrong-password') {
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text('Password did not match')));
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text(e.toString())));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Required all fields')));
  //   }
  //   setState(() {
  //     progressIndicator = false;
  //   });
  // }

  // signUpUser() async {
  //   if (_emailController.text.isNotEmpty &&
  //       _passwordController.text.isNotEmpty &&
  //       _coformPasswordController.text.isNotEmpty &&
  //       _userNameController.text.isNotEmpty &&
  //       fileImage != null) {
  //     if (_passwordController.text == _coformPasswordController.text) {
  //       try {
  //         UserCredential userCredential = await FirebaseAuth.instance
  //             .createUserWithEmailAndPassword(
  //             email: _emailController.text,
  //             password: _passwordController.text);
  //
  //         await FirebaseAuth.instance.currentUser!
  //             .updateDisplayName(_userNameController.text);
  //         await FirebaseAuth.instance.currentUser!
  //             .updateEmail(_emailController.text);
  //
  //         print('---------------fileImage--------------------$fileImage');
  //         final metadata = SettableMetadata(contentType: "image/jpeg");
  //
  //         final storageRef = FirebaseStorage.instance.ref();
  //
  //         final uploadTask = await storageRef
  //             .child("images/users.jpg")
  //             .putFile(fileImage!, metadata);
  //         var imageUrl = await uploadTask.ref.getDownloadURL();
  //         print('---------------imageUrl--------------------$imageUrl');
  //
  //         // loginData = [
  //         //   {
  //         //     'name': _userNameController.text,
  //         //     'email': _emailController.text,
  //         //     'password': _passwordController.text,
  //         //     'imageUrl': imageUrl
  //         //   }
  //         // ];
  //         //
  //         // final prefs = await SharedPreferences.getInstance();
  //         // await prefs.setString('login', json.encode(loginData));
  //         // final String? action = prefs.getString('login');
  //         // var data = json.decode(action!);
  //         // print('--------------data-------------------$data');
  //
  //         await FirebaseFirestore.instance
  //             .collection('users')
  //             .doc(userCredential.user!.uid)
  //             .set({
  //           'name': _userNameController.text,
  //           'email': _emailController.text,
  //           'password': _passwordController.text,
  //           'imageUrl': imageUrl
  //         });
  //         // if (mounted) {
  //         //   print('----------------------------------------uploadImage()');
  //         //   uploadImage();
  //         // }
  //         final prefs = await SharedPreferences.getInstance();
  //         await prefs.setBool('login', true);
  //
  //         Navigator.of(context)
  //             .pushReplacement(MaterialPageRoute(builder: (context) {
  //           return MyHomePage();
  //         }));
  //
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text('Registration Successful')));
  //       } on FirebaseAuthException catch (e) {
  //         if (e.code == 'weak-password') {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Password Provided is too weak')));
  //         } else if (e.code == 'email-already-in-use') {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(content: Text('Email Provided already Exists')));
  //         }
  //       } catch (e) {
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text(e.toString())));
  //         print('-----------e----------${e.toString()}');
  //       }
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Passwords should be same')));
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(const SnackBar(content: Text('Required all fields')));
  //   }
  //   setState(() {
  //     progressIndicator = false;
  //   });
  // }

// uploadImage() async {
//   // final _imagePicker = ImagePicker();
//   // XFile? image;
//   //
//   // image = await _imagePicker.pickImage(source: ImageSource.gallery);
//   // File file = File(image!.path);
//   // setState(() {
//   //   imageFile = Image.file(file);
//   // });
//
//   // PermissionStatus permissionResult = await Permission.storage.request();
//   // print(
//   //     '-----------------permissionResult-------------------$permissionResult');
//   //
//   // if (permissionResult == PermissionStatus.denied) {
//   //   permissionResult = await Permission.storage.request();
//   //   if (permissionResult == PermissionStatus.denied) {
//   //     String message = 'Enable Location Service to Continue';
//   //     // _showDialog(context, message);
//   //     return Future.error('Permission Denied.');
//   //   }
//   // }
//
//   if (fileImage != null) {
//     print('---------------fileImage--------------------$fileImage');
//     final metadata = SettableMetadata(contentType: "image/jpeg");
//
//     final storageRef = FirebaseStorage.instance.ref();
//
//     final uploadTask = await storageRef
//         .child("images/users.jpg")
//         .putFile(fileImage!, metadata);
//     var imageUrl = await uploadTask.ref.getDownloadURL();
//     print('---------------imageUrl--------------------$imageUrl');
//
//     loginData = [
//       {
//         'name': _userNameController.text,
//         'email': _emailController.text,
//         'password': _passwordController.text,
//         'imageUrl': imageUrl
//       }
//     ];
//
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('login', json.encode(loginData));
//     final String? action = prefs.getString('login');
//     var data = json.decode(action!);
//     print('--------------data-------------------$data');
//
//     // uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
//     //   switch (taskSnapshot.state) {
//     //     case TaskState.running:
//     //       final progress =
//     //           100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
//     //       print("------------------------------Upload is $progress% complete.");
//     //       break;
//     //     case TaskState.paused:
//     //       print("-------------------------------Upload is paused.");
//     //       break;
//     //     case TaskState.canceled:
//     //       print("-------------------------------Upload was canceled");
//     //       break;
//     //     case TaskState.error:
//     //     // Handle unsuccessful uploads
//     //       break;
//     //     case TaskState.success:
//     //     // Handle successful uploads on complete
//     //     // ...
//     //       break;
//     //   }
//     // });
//   } else {
//     print('-------------------------------------null--null');
//   }
// }
}
