import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:school_app/auth/login.dart';
import 'package:school_app/const/const.dart';
import 'package:school_app/model/profile.dart';
import 'package:school_app/screen/main-screen.dart';
import 'package:http/http.dart' as http;

class Authentication {
  final isLoading = false.obs; // Observable for loading state
  final token = ''.obs; // Observable for storing token
  final box = GetStorage(); // GetStorage instance for local storage
  late num userId;
  Authentication() {
    // Initialize userId from local storage if available
    var storedUserId = box.read('userId');

    if (storedUserId != null && storedUserId is int) {
      userId = storedUserId;
    } else {
      userId = 0; // or any default value you prefer
    }
  }

  void setUserId(int newUserId) {
    userId = newUserId;
    box.write('userId', userId);
    log("${userId}");
  }

  /// Handles user login
  Future<void> login({
    required String phone,
    required String password,
  }) async {
    try {
      isLoading.value = true; // Set loading state to true

      var data = {
        'phone': phone,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('${urlApi}auth/login'), // API endpoint for login
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      // Check if login request was successful (status code 200)
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        // Check if access token exists in response body
        if (responseBody != null && responseBody['access_token'] != null) {
          isLoading.value = false; // Set loading state to false
          token.value =
              responseBody['access_token']; // Store token in observable
          box.write('token', token.value);

          // Store userId in local storage

          if (responseBody.containsKey('id') && responseBody['id'] is int) {
            setUserId(responseBody['id']);
          } else {
            log("Invalid user id from backend");
          }

          Get.offAll(() => const MainScreen()); // Navigate to home page
          log(response.body); // Log response body
        } else {
          isLoading.value = false; // Set loading state to false
          log('Access token not found in response body: $responseBody');
        }
      } else {
        isLoading.value = false; // Set loading state to false
        Get.snackbar("Notification", 'Login Fail');
        log('HTTP error: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      isLoading.value = false; // Set loading state to false
      log(e.toString()); // Log error message
    }
  }

  /// Retrieves user data from the server
  Future<Object?> view() async {
    try {
      final token = box.read('token'); // Retrieve token from local storage

      // Check if token exists
      if (token != null) {
        var response = await http.get(
          Uri.parse('${urlApi}profile'), // API endpoint for user profile
          headers: {
            'Authorization':
                'Bearer $token', // Send token in Authorization header
          },
        );

        log("${response.statusCode}"); // Log response status code

        // Check if user data retrieval was successful (status code 200)
        if (response.statusCode == 200) {
          final userData = json.decode(response.body); // Decode JSON response
          log("Response data: $userData"); // Log the decoded JSON data

          // Ensure the response data is not null and contains expected fields
          if (userData != null) {
            try {
              return UserData.fromJson(userData); // Return UserData object
            } catch (e) {
              log('Error in fromJson: $e'); // Log error in fromJson method
              return null; // Return null if fromJson fails
            }
          } else {
            log('Decoded user data is null'); // Log null user data
            return null; // Return null if user data is null
          }
        } else {
          log('HTTP error: ${response.statusCode}, ${response.body}'); // Log HTTP error
          return []; // Return empty list in case of error
        }
      } else {
        log('Token not found'); // Log token not found message
        return null; // Return null if token not found
      }
    } catch (e) {
      log('Exception: $e'); // Log error message
      return null; // Return null in case of error
    }
  }

  /// Logs out the user
  Future<void> logout() async {
    try {
      box.remove('token'); // Remove token from local storage
      Get.offAll(const Login()); // Navigate to login screen
    } catch (e) {
      log('Error while logging out: $e'); // Log logout error
    }
  }

  /// Changes user password
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final token = box.read('token'); // Retrieve token from local storage

      // Check if token exists
      if (token != null) {
        isLoading.value = true; // Set loading state to true

        // Validate new password and confirm password
        if (newPassword != confirmPassword) {
          isLoading.value = false; // Set loading state to false
          Get.snackbar(
              'Error', 'New password and confirm password do not match.');
          return;
        }

        var data = jsonEncode({
          'old_password': oldPassword,
          'new_password': newPassword,
          'confirm_password': confirmPassword,
        });
        log("${oldPassword}");
        log("${newPassword}");

        var response = await http.post(
          Uri.parse('${urlApi}profile/change-pass'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: data,
        );
        log("${response.statusCode}");

        // Check if password change was successful (status code 200)
        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);

          // Check if success status is returned
          if (responseBody['status'] == 'success') {
            isLoading.value = false; // Set loading state to false
            Get.snackbar(
              'Success',
              responseBody['message'],
            );
            Get.offAll(() => Login());
          } else {
            isLoading.value = false; // Set loading state to false

            Get.snackbar(
              'Error',
              'Failed to change password. Please try again.',
            );
          }
        } else {
          isLoading.value = false; // Set loading state to false
          log('HTTP error: ${response.statusCode}, ${response.body}');
          Get.snackbar(
            'Error',
            'Failed to change password. Please try again.',
          );
        }
      } else {
        log('Token not found');
        Get.snackbar(
          'Error',
          'Authentication token not found. Please log in again.',
        );
      }
    } catch (e) {
      isLoading.value = false; // Set loading state to false
      log(e.toString()); // Log error message
      Get.snackbar(
        'Error',
        'An error occurred while changing password. Please try again.',
      );
    }
  }

  Future<void> update({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final token = box.read('token');
      if (token != null) {
        isLoading.value = true;
        var data = jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
        });
        var response = await http.post(
          Uri.parse('${urlApi}profile/update'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: data,
        );
        log('${response.statusCode}');
        if (response.statusCode == 200) {
          isLoading.value = false;
          final data = jsonDecode(response.body);
          if (data['status'] == 'success') {
            log('${data}');
          }
        } else {
          Get.snackbar('Fail', 'ការកែប្រែព័ត៏មានទទួលបរាជ័យ');
        }
      }
    } catch (e) {
      log("${e}");
    }
  }
}
