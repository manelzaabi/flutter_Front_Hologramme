import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/home/components/home_form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';


class User {
  late String email;
  late String password;

  User({required this.email, required this.password});
}


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}


 



class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;

  @override
  void initState() {
    super.initState();
    email = ''; 
    password = ''; 
  }

  Future<void> save() async {
    print('Bouton de connexion pressé');
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      final response = await http.post(
        Uri.parse("http://192.168.211.1:9090/user/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        String token = responseData['token'];
          ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
           content: Text('Connexion réussie! Welcome'), 
           backgroundColor: Colors.green,
        ),
      );
             Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const homeForm(),
    ),
  );

       
      } else {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Échec de la connexion. Veuillez réessayer.'),
          backgroundColor: Colors.red,
        ),
      );
      }
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
             validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                

                   decoration: const InputDecoration(
                   hintText: "Your email",
                   prefixIcon: Padding(
                   padding: EdgeInsets.all(defaultPadding),
                   child: Icon(Icons.person),
                        ),
                    ),
             
             onSaved: (value) {
              setState(() {
                email = value!;
              });
            },
            
          ),
           
          
              Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
           
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
                obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onSaved: (value) {
              setState(() {
                password = value!;
              });
            },
          ),
            ),
          
           
         const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: save,
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }}