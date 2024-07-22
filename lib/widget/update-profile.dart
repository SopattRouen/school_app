import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/helper/textform.dart';
import 'package:school_app/service/authentication.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    final _name = TextEditingController();
    final _email = TextEditingController();
    final _phone = TextEditingController();
    final auth = Authentication();

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
          'កែប្រែព័ត៏មានផ្ទាល់ខ្លួន',
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
                    hintext: 'ឈ្មោះ',
                    obscure: false,
                    controller: _name,
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  InputWidget(
                    hintext: 'អ៊ីម៉ែល',
                    obscure: false,
                    controller: _email,
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  InputWidget(
                    hintext: 'លេខទូរស័ព្ទ',
                    obscure: false,
                    controller: _phone,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            fixedSize: MaterialStateProperty.all(
                Size(200, 70)), // Width: 200, Height: 50
          ),
          onPressed: () {
            auth
                .update(
              name: _name.text,
              email: _email.text,
              phone: _phone.text,
            )
                .then((_) {
              if (!auth.isLoading.value) {
                _name.clear();
                _email.clear();
                _phone.clear();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      'ការកែប្រែព័ត៏មានទទួលបានជោគជ័យ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              } else {
                SnackBar(
                  content: Text(
                    'ការកែប្រែព័ត៏មានទទួលបានបរាជ័យ',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                );
              }
            });
          },
          child: Obx(
            () => auth.isLoading.value
                ? CircularProgressIndicator()
                : Text(
                    "រួចរាល់",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
