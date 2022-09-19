import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({ Key? key }) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 35),


          const Image(
            image: AssetImage("images/logo.png"),
            width: 390,
            height: 250,
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
            padding: const EdgeInsets.all(20),
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
            padding: const EdgeInsets.all(20),
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
          ElevatedButton(
            child: Container(
              color: Colors.yellow,
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
              print("Login Button Clicked");
            }, 
          )



        ],
      ),
    );
  }
}