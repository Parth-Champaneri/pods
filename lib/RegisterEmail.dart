// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class _RegisterEmailSection extends StatefulWidget {
//   final String title = 'Registration';
//   @override
//   State<StatefulWidget> createState() => _RegisterEmailSectionState();
// }

// class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _success;
//   String _userEmail;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 40),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextFormField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//               validator: (String value) {
//                 if (value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               validator: (String value) {
//                 if (value.isEmpty) {
//                   return 'Please enter some text';
//                 }
//                 return null;
//               },
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 16.0),
//               alignment: Alignment.center,
//               child: RaisedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState.validate()) {
//                     _register();
//                   }
//                 },
//                 child: const Text('Submit'),
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               child: Text(_success == null
//                   ? ''
//                   : (_success
//                       ? 'Successfully registered ' + _userEmail
//                       : 'Registration failed')),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void _register() async {
//     User user = null;
//     await _auth
//         .createUserWithEmailAndPassword(
//       email: _emailController.text,
//       password: _passwordController.text,
//     )
//         .catchError((error) {
//       switch (error.code) {
//         case "email-already-in-use":
//           print('Email address ${_emailController.text} already in use.');
//           break;
//         case 'invalid-email':
//           print('Email address ${_emailController.text} is invalid.');
//           break;
//         // not sure what this case is for yet
//         case 'operation-not-allowed':
//           print("Error during sign up");
//           break;
//         case 'weak-password':
//           print(
//               "Password is not strong enough. Add additional characters including special characters and numbers.");
//           break;
//         default:
//           print(error.code);
//           break;
//       }
//       // print("------------------ERROR IS--------------");
//       // print(error.code);
//       // print("------------------ERROR IS--------------");
//       setState(() {
//         _success = false;
//       });
//     }).then((onValue) {
//       user = onValue.user;
//     });
//     if (user != null) {
//       setState(() {
//         _success = true;
//         _userEmail = user.email;
//       });
//     } else {
//       setState(() {
//         _success = false;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }

// SIGN IN
// class _EmailPasswordForm extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _EmailPasswordFormState();
// }

// class _EmailPasswordFormState extends State<_EmailPasswordForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _success;
//   String _userEmail;

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             child: const Text('Test sign in with email and password'),
//             padding: const EdgeInsets.all(16),
//             alignment: Alignment.center,
//           ),
//           TextFormField(
//             controller: _emailController,
//             decoration: const InputDecoration(labelText: 'Email'),
//             validator: (String value) {
//               if (value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: _passwordController,
//             decoration: const InputDecoration(labelText: 'Password'),
//             validator: (String value) {
//               if (value.isEmpty) {
//                 return 'Please enter some text';
//               }
//               return null;
//             },
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             alignment: Alignment.center,
//             child: RaisedButton(
//               onPressed: () async {
//                 if (_formKey.currentState.validate()) {
//                   _signInWithEmailAndPassword();
//                 }
//               },
//               child: const Text('Submit'),
//             ),
//           ),
//           Container(
//             alignment: Alignment.center,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               _success == null
//                   ? ''
//                   : (_success
//                       ? 'Successfully signed in ' + _userEmail
//                       : 'Sign in failed'),
//               style: TextStyle(color: Colors.red),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _signInWithEmailAndPassword() async {
//     User user = null;
//     await _auth
//         .signInWithEmailAndPassword(
//       email: _emailController.text,
//       password: _passwordController.text,
//     )
//         .catchError((error) {
//       switch (error.code) {
//         case "email-already-in-use":
//           print('Email address ${_emailController.text} already in use.');
//           break;
//         case 'invalid-email':
//           print('Email address ${_emailController.text} is invalid.');
//           break;
//         // not sure what this case is for yet
//         case 'operation-not-allowed':
//           print("Error during sign up");
//           break;
//         case 'weak-password':
//           print(
//               "Password is not strong enough. Add additional characters including special characters and numbers.");
//           break;
//         default:
//           print(error.code);
//           break;
//       }
//       print("------------------ERROR IS--------------");
//       print(error.code);
//       print("------------------ERROR IS--------------");
//       setState(() {
//         _success = false;
//       });

//       setState(() {
//         _success = false;
//       });
//     }).then((onValue) {
//       user = onValue.user;
//     });

//     if (user != null) {
//       setState(() {
//         _success = true;
//         _userEmail = user.email;
//       });
//     } else {
//       setState(() {
//         _success = true;
//       });
//     }
//   }
// }

//--
// class _EmailLinkSignInSection extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _EmailLinkSignInSectionState();
// }

// class _EmailLinkSignInSectionState extends State<_EmailLinkSignInSection>
//     with WidgetsBindingObserver {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   bool _success;
//   String _userEmail;
//   String _userID;
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Container(
//             child: const Text('Test sign in with email and link'),
//             padding: const EdgeInsets.all(16),
//             alignment: Alignment.center,
//           ),
//           TextFormField(
//             controller: _emailController,
//             decoration: const InputDecoration(labelText: 'Email'),
//             validator: (String value) {
//               if (value.isEmpty) {
//                 return 'Please enter your email.';
//               }
//               return null;
//             },
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             alignment: Alignment.center,
//             child: RaisedButton(
//               onPressed: () async {
//                 if (_formKey.currentState.validate()) {
//                   _signInWithEmailAndLink();
//                 }
//               },
//               child: const Text('Submit'),
//             ),
//           ),
//           Container(
//             alignment: Alignment.center,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               _success == null
//                   ? ''
//                   : (_success
//                       ? 'Successfully signed in, uid: ' + _userID
//                       : 'Sign in failed'),
//               style: TextStyle(color: Colors.red),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Future<void> _signInWithEmailAndLink() async {
//     _userEmail = _emailController.text;
//     return await _auth.sendSignInLinkToEmail(
//       email: _userEmail,
//       actionCodeSettings: ActionCodeSettings(
//         url: 'https://parthchampaneri.page.link/iDzQ/',
//         handleCodeInApp: true,
//         iOSBundleId: 'parth.champaneri98-icloud.com',
//         // androidPackageName: 'com.google.firebase.flutterauth',
//         // androidInstallApp: true,
//         // androidMinimumVersion: "1",
//       ),
//     );
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     if (state == AppLifecycleState.resumed) {
//       final PendingDynamicLinkData data =
//           await FirebaseDynamicLinks.instance.getInitialLink();
//       if (data?.link != null) {
//         handleLink(data?.link);
//       }
//       FirebaseDynamicLinks.instance.onLink(
//           onSuccess: (PendingDynamicLinkData dynamicLink) async {
//         final Uri deepLink = dynamicLink?.link;
//         handleLink(deepLink);
//       }, onError: (OnLinkErrorException e) async {
//         print('onLinkError');
//         print(e.message);
//       });
//     }
//   }

//   void handleLink(Uri link) async {
//     if (link != null) {
//       final User user = (await _auth.signInWithEmailLink(
//         email: _userEmail,
//         emailLink: link.toString(),
//       ))
//           .user;
//       if (user != null) {
//         setState(() {
//           _userID = user.uid;
//           _success = true;
//         });
//       } else {
//         setState(() {
//           _success = false;
//         });
//       }
//     } else {
//       setState(() {
//         _success = false;
//       });
//     }
//     setState(() {});
//   }
// }
