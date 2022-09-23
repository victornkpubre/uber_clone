import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/AllScreens/login_screen.dart';
import 'package:uber_clone/AllScreens/main_screen.dart';
import 'package:uber_clone/AllWidgets/progressDialog.dart';
import 'package:uber_clone/main.dart';

class RegisterationScreen extends StatelessWidget {
  RegisterationScreen({ Key? key }) : super(key: key);

  static const String idScreen = "register";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
      
      
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
      
      
            //Name Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 1,),
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Name",
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


            //Phone Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 1,),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Phone",
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

      
      
            //Password Input
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
                      "Register",
                      style: TextStyle( 
                        fontSize: 18,
                        fontFamily: "Brand Bold",
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                onPressed: (){
                  
                  if(nameController.text.length < 4){
                    displayToastMessage("Name must be atleast 4 characters", context);
                  }
                  else if(!emailController.text.contains("@")){
                    displayToastMessage("Email address is not Valid", context);
                  }
                  else{
                    registerNewUser(context);
                  }
                  
                }, 
              ),
            ),
      
            Container(
              margin: const EdgeInsets.only(bottom: 50, top: 25),
              child: TextButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
                }, 
                child: Text(
                  "Already have an Account? Login"
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerNewUser(BuildContext context) async {

    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context){
        return ProgressDialog(message: "Registering, Please wait");
      }
    );


    //create user account
    final User? firebaseUser = (await _firebaseAuth.createUserWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim()
    ).catchError((error){ 
      Navigator.pop(context);
      displayToastMessage("Error: "+ error.toString(), context);
    })).user;

    if(firebaseUser != null){
      //collect user info
      Map userDataMap = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "phone": phoneController.text.trim()
      };
      //save user info
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Congratulation, your account has been created", context);
      //navigate to main screen
      Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
    }
    else{
      Navigator.pop(context);
      //error occured - display error msg
      displayToastMessage("New user account has not been Created", context);
    }

  }

}

displayToastMessage(String message, BuildContext context){
  Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
}


