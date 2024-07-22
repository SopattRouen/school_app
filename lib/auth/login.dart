import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/service/authentication.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phone = TextEditingController();
  final password = TextEditingController();
  final auth = Get.put(Authentication());
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 150,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  'images/book.png',
                ),
              ),
              Center(
                child: Text(
                  "សូមស្វាគមន៍",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  controller: phone,
                  decoration: InputDecoration(
                    hintText: '060486849',
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  obscureText: isClick,
                  controller: password,
                  decoration: InputDecoration(
                    hintText: '123456',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          isClick = !isClick;
                        });
                      },
                      child: isClick
                          ? Icon(Icons.visibility_off_sharp)
                          : Icon(Icons.visibility),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                onPressed: () {
                  final String user =
                      phone.text.isEmpty ? '012672842' : phone.text;
                  final String pass =
                      password.text.isEmpty ? '123456' : password.text;
                  auth.login(phone: user, password: pass);
                },
                child: Obx(() {
                  return auth.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text("ចូលគណនី");
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
