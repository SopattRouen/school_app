import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/model/profile.dart'; // Assuming UserData class is imported correctly
import 'package:school_app/service/authentication.dart';
import 'package:school_app/widget/change-pass.dart';
import 'package:school_app/widget/update-profile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<Authentication>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 29, 65),
      body: FutureBuilder<Object?>(
        future: auth.view(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final responseData = snapshot.data;

            if (responseData is List<dynamic> && responseData.isNotEmpty) {
              final userData = responseData.first;
              return buildProfileFromUserData(userData);
            } else if (responseData is UserData) {
              return buildProfileFromUserData(responseData);
            } else {
              return Center(
                  child: Text(
                'Unexpected data format.',
                style: TextStyle(color: Colors.white),
              ));
            }
          } else {
            return Center(
                child: Text(
              'No data available.',
              style: TextStyle(color: Colors.white),
            ));
          }
        },
      ),
    );
  }

  Widget buildProfileFromUserData(UserData userData) {
    final auth = Get.find<Authentication>();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 55),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40,
                  backgroundImage: AssetImage('images/acc.png'),
                ),
                SizedBox(height: 10),
                Text(
                  "${userData.name}",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "${userData.email}",
                  style: TextStyle(color: Colors.white),
                ),
                // if (userData.phone != null)
                //   Text(
                //     "${userData.phone}",
                //     style: TextStyle(color: Colors.white),
                //   ),
              ],
            ),
          ),
          SizedBox(height: 60),
          ListTile(
            onTap: () {
              Get.to(() => ChangePassword());
            },
            leading: Icon(
              Icons.lock_open_rounded,
              color: Colors.white,
            ),
            title: Text(
              "ផ្លាស់ប្ដូរពាក្យសម្ងាត់",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            onTap: () {
              Get.to(() => UpdateProfile());
            },
            leading: Icon(
              Icons.update,
              color: Colors.white,
            ),
            title: Text(
              "កែប្រែ Profile",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            onTap: () {
              auth.logout();
            },
            leading: Icon(
              Icons.logout_sharp,
              color: Colors.white,
            ),
            title: Text(
              "ចាកចេញ",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
