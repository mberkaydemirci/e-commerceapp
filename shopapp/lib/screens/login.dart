import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopapp/helpers/common.dart';
import 'package:shopapp/widgets/loading.dart';
import 'package:shopapp/screens/signup.dart';
import './home.dart';
import 'package:firebase_core/firebase_core.dart';
import '../provider/user.dart';

//bool isLogedin = false;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  late SharedPreferences preferences;
  bool loading = false;

  late String userUid;

  /* @override
  void initState() {
    super.initState();
    isSignedIn();
    print(isLogedin);
    print(loading);
  }*/

  /*void isSignedIn() async {
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();

    User? user = await firebaseAuth.currentUser;

    /*if (user != null) {
      setState(() {
        isLogedin = true;
      });
    }*/
    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
    setState(() {
      loading = false;
    });
  }*/

  /*Future<User?> SignIn(String email, String password) async {
    bool exception = false;
    try {
      var user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.user;
    } catch (FirebaseAuthException) {
      exception = true;
      Fluttertoast.showToast(
          msg: "Wrong Password or Email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER // also possible "TOP" and "CENTER"
          );
    } finally {
      if (exception == false) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      exception = false;
    }
  }
*/
  SignOut() async {
    changeScreen(context, Login());
    //print(isLogedin);
    return await firebaseAuth.signOut();
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    AuthCredential authCredential = await GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    final UserCredential userCredential =
        await firebaseAuth.signInWithCredential(authCredential);
    final User? user = userCredential.user;
    assert(user?.uid != null);
    userUid = user!.uid;
    if (user != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: userUid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        // insert to user to our collection
        FirebaseFirestore.instance.collection("users").doc(userUid).set({
          "id": userUid,
          "username": userCredential.user!.displayName,
          "profilePicture": userCredential.user!.photoURL,
        });
        await preferences.setString("id", userUid);
        await preferences.setString("username", user.displayName.toString());
        //await preferences.setString("photoUrl", user.photoURL.toString());
      } else {
        await preferences.setString("id", documents[0]["id"]);
        await preferences.setString("username", documents[0]["username"]);
        //await preferences.setString("photoUrl", documents[0]["photoUrl"]);
      }
      Fluttertoast.showToast(msg: "Login was succesful");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      Fluttertoast.showToast(msg: "Login failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? HomePage()
          : Stack(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 50.0, bottom: 50),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 20,
                            )
                          ]),
                      child: Form(
                          key: _formKey,
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      'images/cart.png',
                                      width: 120.0,
                                      //                height: 240.0,
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.2),
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _emailTextController,
                                      decoration: const InputDecoration(
                                        hintText: "Email",
                                        icon: const Icon(Icons.email),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          Pattern pattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex =
                                              new RegExp(pattern.toString());
                                          if (!regex.hasMatch(value))
                                            return 'Please make sure your email address is valid';
                                          else
                                            return null;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                // PASSWORD
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.2),
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _passwordTextController,
                                      decoration: const InputDecoration(
                                        hintText: "Password",
                                        icon: Icon(Icons.password_outlined),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "The password field cannot be empty";
                                        } else if (value.length < 6) {
                                          return "The password has to be at least 6 characters long";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),

                                // NEW PADDING
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                                child: Material(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black,
                                    elevation: 0,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        /*SignIn(_emailTextController.text,
                                      _passwordTextController.text);*/
                                        if (_formKey.currentState!.validate()) {
                                          if (!await user.signIn(
                                              _emailTextController.text,
                                              _passwordTextController.text))
                                            _key.currentState!.showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        "Sign in failed")));
                                        }
                                      },
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      child: const Text(
                                        "Login",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                                    child: Text(
                                      "Forgot password",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUp()));
                                          },
                                          child: Text(
                                            "Create an account",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))),
                                ],
                              ),
                              // SIGN UP
                              //sign in padding
                              const Divider(color: Colors.white),
                              /*Text("Other login option",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22)),*/
                              //handleSignIn();
                              Text(
                                "Or",
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        14.0, 8.0, 14.0, 8.0),
                                    child: Material(
                                        child: Text(
                                      "Or sign up with",
                                      style: TextStyle(color: Colors.grey),
                                    )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        14.0, 8.0, 14.0, 8.0),
                                    child: Material(
                                        child: MaterialButton(
                                            onPressed: () {
                                              handleSignIn();
                                            },
                                            child: Image.asset(
                                              "images/ggg.png",
                                              width: 60,
                                            ))),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                /* Visibility(
                    visible: loading ?? true,
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.grey.withOpacity(0.2),
                        child: const CircularProgressIndicator(
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      ),
                    ))*/
              ],
            ),
    );
  }
}
