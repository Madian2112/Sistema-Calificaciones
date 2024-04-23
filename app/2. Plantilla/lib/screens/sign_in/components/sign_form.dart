import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../forgot_password/forgot_password_screen.dart';
import '../../login_success/login_success_screen.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final contraname = TextEditingController();
  String? Usuario;
  String? Contra;
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  Future<dynamic> Login() async{
    final String url = "https://localhost:44348/API/Usuario/LoginHome?Usuario="+username.text+"&Contra="+contraname.text;
    final result = await http.get(Uri.parse(url));

    if(result.statusCode == 200){
      final json = jsonDecode(result.body);
      if (json['code'] == 200) {

        if (json['data'] != null && json['data'].isNotEmpty) {

          final userData = json['data'][0];

            if (userData.containsKey('usua_EsAdmin')) {
              bool isAdmin = userData['usua_EsAdmin'];
              print(isAdmin);
                if(isAdmin == true){
                  int numero = 1;
                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setInt('Numero', numero);
                }
            } 
            
            else {
              print("Error: 'usua_EsAdmin' no está presente en los datos del usuario.");
            }
        } 
        else {
          print("Error: No hay datos en la lista 'data'.");
        }
      } 

    else {
      print("Error: Código de respuesta no es 200.");
    }

     /* final SharedPreferences sharedPreferences = await SharedPreferences.getInstance(); */
      Navigator.push(context, MaterialPageRoute(builder: (home) => LoginSuccessScreen()));
    }

    else{
            Navigator.push(context, MaterialPageRoute(builder: (home) =>  SignInScreen()));
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: username,
            onSaved: (newValue) => Usuario = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kUserNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidUserError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kUserNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidUserError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Usuario",
              hintText: "Ingresa tu usuario",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: contraname,
            obscureText: true,
            onSaved: (newValue) => Contra = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 1) {
                removeError(error: kShortPassError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 1) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Contraseñia",
              hintText: "Ingrese su contraseñia",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: Login,
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
