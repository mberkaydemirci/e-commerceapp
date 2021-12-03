import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/helpers/common.dart';
import 'package:shopapp/widgets/loading.dart';
import 'package:shopapp/screens/home.dart';
import 'package:shopapp/screens/login.dart';
import 'package:shopapp/provider/user.dart';
import '../services/users.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  UserServices _userServices = UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  // String gender = "male";
  // String groupvalue = "male";
  bool hidePass = true;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late SharedPreferences preferences;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  /*bool loading = false;
  bool isLogedin = false;*/

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text(
          "Login",
          style: TextStyle(color: Colors.red.shade900),
        ),
      ),*/
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius:
                              20.0, // has the effect of softening the shadow
                        )
                      ],
                    ),
                  ),
                ),
                //EMAIL
                Center(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  'images/cart.png',
                                  width: 120.0,
//                height: 240.0,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _nameTextController,
                                    decoration: const InputDecoration(
                                      hintText: "Name",
                                      icon: Icon(Icons.person_outline),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "The name field cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _emailTextController,
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                      icon: const Icon(Icons.email),
                                      border: InputBorder.none,
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
                            ),
                            // PASSWORD
                          ),
                          /* Padding(
                        padding: const EdgeInsets.fromLTRB(14, 8.0, 14, 8),
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    "male",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: Radio(
                                      value: "male",
                                      groupValue: groupvalue,
                                      onChanged: (e) => valueChanged(e)),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    "female",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  trailing: Radio(
                                      value: "female",
                                      groupValue: groupvalue,
                                      onChanged: (e) => valueChanged(e)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),*/
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(
                                    title: TextFormField(
                                      controller: _passwordTextController,
                                      obscureText: hidePass,
                                      decoration: const InputDecoration(
                                        hintText: "Password",
                                        icon: Icon(Icons.password_outlined),
                                        border: InputBorder.none,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "The password field cannot be empty";
                                        } else if (value.length < 6) {
                                          return "The password has to be at least 6 characters long";
                                        } else if (_passwordTextController
                                                .text !=
                                            value) {
                                          return "the passwords do not match";
                                        }
                                        return null;
                                      },
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePass = !hidePass;
                                        });
                                      },
                                      icon: Icon(Icons.remove_red_eye),
                                      iconSize: 12,
                                    )),
                              ),
                            ),
                          ),
                          //Password 2 -------------------------------------
                          /*Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.2),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ListTile(
                                title: TextFormField(
                                  controller: _confirmPasswordTextController,
                                  obscureText: hidePass,
                                  decoration: const InputDecoration(
                                    hintText: "Confirm Password",
                                    icon: Icon(Icons.password_outlined),
                                    border: InputBorder.none,
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
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      hidePass = false;
                                    });
                                  },
                                  icon: Icon(Icons.remove_red_eye),
                                  iconSize: 12,
                                )),
                          ),
                        ),
                      ),*/
                          // SIGN UP ------------------------------------------------------
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                            child: Material(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                                elevation: 0,
                                child: MaterialButton(
                                  onPressed: () async {
                                    //validateForm();

                                    /*SignIn(_emailTextController.text,
                                      _passwordTextController.text);*/
                                    if (_formKey.currentState!.validate()) {
                                      if (!await user.signUp(
                                          _nameTextController.text,
                                          _emailTextController.text,
                                          _passwordTextController.text))
                                        _key.currentState!.showSnackBar(
                                            SnackBar(
                                                content:
                                                    Text("Sign up failed")));
                                      changeScreenReplacement(context, Login());
                                      return;
                                    }
                                  },
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: const Text(
                                    "Sign Up",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                )),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "I already have an account",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Or Sing up with",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                    child: MaterialButton(
                                        onPressed: () {},
                                        child: Image.asset(
                                          "images/fb.png",
                                          width: 60,
                                        ))),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    14.0, 8.0, 14.0, 8.0),
                                child: Material(
                                    child: MaterialButton(
                                        onPressed: () {},
                                        child: Image.asset(
                                          "images/ggg.png",
                                          width: 60,
                                        ))),
                              ),
                            ],
                          ),
                          //sign in padding
                          const Divider(color: Colors.white),
                          /*Text("Other login option",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22)),*/
                        ],
                      )),
                ),

                /* Visibility(
                    visible: loading ?? true,
                    child: Center(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.white.withOpacity(0.9),
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

  /*valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupvalue = e;
        gender = e;
      } else if (e == "female") {
        groupvalue = e;
        gender = e;
      }
    });
  }*/

  /*Future<void> validateForm() async {
    FormState? formState = _formKey.currentState;
    Map value;
    if (formState!.validate()) {
      formState.reset();
      User? user = await firebaseAuth.currentUser;
      createPerson(_nameTextController.text, _emailTextController.text,
          _passwordTextController.text, gender);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }*/

  /* Future<User?> createPerson(
      String name, String email, String password, String gender) async {
    var user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("Person").doc(user.user!.uid).set({
      'userName': name,
      'Email': email,
      "Gender": gender,
      "Password": password
    });

    return user.user;
  }*/
}
