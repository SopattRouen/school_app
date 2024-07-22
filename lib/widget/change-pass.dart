import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/helper/textform.dart';
import 'package:school_app/service/authentication.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final old = TextEditingController();
    final newp = TextEditingController();
    final con = TextEditingController();
    final Authentication auth = Authentication();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 29, 65),
      appBar: AppBar(
        leading: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        title: Text(
          'ផ្លាស់ប្ដូរពាក្យសម្ងាត់',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 18, 29, 65),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  InputWidget(
                    hintext: 'ពាក្យសម្ងាត់ចាស់',
                    obscure: true,
                    controller: old,
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  InputWidget(
                    hintext: 'ពាក្យសម្ងាត់ថ្មី',
                    obscure: true,
                    controller: newp,
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  InputWidget(
                    hintext: 'បញ្ជាក់ពាក្យសម្ងាត់',
                    obscure: true,
                    controller: con,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottom(auth: auth, old: old, newp: newp, con: con),
    );
  }
}

class Bottom extends StatelessWidget {
  const Bottom({
    super.key,
    required this.auth,
    required this.old,
    required this.newp,
    required this.con,
  });

  final Authentication auth;
  final TextEditingController old;
  final TextEditingController newp;
  final TextEditingController con;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
          fixedSize: MaterialStateProperty.all(
              Size(200, 70)), // Width: 200, Height: 50
        ),
        onPressed: () {
          auth.changePassword(
            oldPassword: old.text,
            newPassword: newp.text,
            confirmPassword: con.text,
          );
        },
        child: Obx(() {
          return auth.isLoading.value
              ? const CircularProgressIndicator()
              : const Text("រួចរាល់");
        }),
      ),
    );
  }
}
