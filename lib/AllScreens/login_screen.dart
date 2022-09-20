import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/AllScreens/main_screen.dart';
import 'package:uber_clone/AllScreens/registerationScreen.dart';
import 'package:uber_clone/AllWidgets/progressDialog.dart';
import 'package:uber_clone/main.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({ Key? key }) : super(key: key);

  static const String idScreen = "login";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 100),
      
      
              const Image(
                image: AssetImage("images/logo.png"),
                width: 150,
                alignment: Alignment.center,
              ),
              
              const SizedBox(height: 1,),
              const Text(
                "Login as a Rider",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Brand Bold" 
                ),
                textAlign: TextAlign.center,
              ),
      
      
              //Email Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 1,),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        )
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0
                      ),
                    )
                  ],
                ),
              ),
      
      
              //Email Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 1,),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        )
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 35),
      
      
              //Login Button
              Padding(
                padding: const EdgeInsets.symmetric( horizontal: 25.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  child: SizedBox(
                    height: 50.0,
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle( 
                          fontSize: 18,
                          fontFamily: "Brand Bold",
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  onPressed: (){
                    if(!emailController.text.contains("@")){
                      displayToastMessage("Email address is not Valid", context);
                    }
                    else if (passwordController.text.isEmpty){
                      displayToastMessage("Password is mandatory", context);
                    }
                    else {
                      loginUser(context);
                    }

                  }, 
                ),
              ),
      
      
              Container(
                margin: EdgeInsets.only(bottom: 50, top: 25),
                child: TextButton(
                  onPressed: (){
                    Navigator.pushNamedAndRemoveUntil(context, RegisterationScreen.idScreen, (route) => false);
                  }, 
                  child: Text(
                    "Do not have an Account? Register Here"
                  )
                ),
              )
      
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  loginUser(BuildContext context) async {
    
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return ProgressDialog(message: "Authenticating, Please wait");
      }
    );

    //login user
    final User? firebaseUser = (await _firebaseAuth.signInWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim(),
    ).catchError((err){
      Navigator.pop(context);
      displayToastMessage("Error: "+err.toString(), context);
    })
    ).user;
    //check firebase for user info
    if(firebaseUser != null){
      usersRef.child(firebaseUser.uid).once().then((snap) {
        if(snap.snapshot.value != null){
          Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
          displayToastMessage("Login Successful", context);
        }
        else{
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage("No record exists for this user. Please create new account.", context);
        }
      });
    }
    else{
      Navigator.pop(context);
      //error occured - display error message
      displayToastMessage("Error Occured, can not be signed-in", context);
    }




    


  }



}