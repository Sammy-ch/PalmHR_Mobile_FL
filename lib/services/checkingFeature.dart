import 'package:PALMHR_MOBILE/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum CheckingType {
  CHECKIN,
  CHECKOUT,
}

enum CheckingStatus { APPROVED, DECLINED, PENDING }
Future<void> handleCheckIn(String myUserId) async {
  final currentTime = DateFormat('HH:mm').format(DateTime.now());
  final dayOfWeek = DateFormat('yyyy-MM-dd').format(DateTime.now());

  try {
    // Fetch the user's check-in data for the current day
    final response = await supabase
        .from('EmployeeAttendance')
        .select('*')
        .eq('employee_id', myUserId)
        .eq('checking_date', dayOfWeek);

    // If a check-in for the current day already exists, return early
    if (response.isNotEmpty) {
      Fluttertoast.showToast(
          msg: 'Already checked In',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.deepOrange,
          timeInSecForIosWeb: 5);
      return;
    }

    // Check if a check-in request is already pending for the current day
    final pendingRequest = await supabase
        .from('CheckingRequestQueue')
        .select('*')
        .eq('employee_id', myUserId)
        .eq('checking_date', dayOfWeek)
        .eq('checking_type', CheckingType.CHECKIN.toString().split('.')[1])
        .eq('checking_status', CheckingStatus.PENDING.toString().split('.')[1]);

    if (pendingRequest.isNotEmpty) {
      Fluttertoast.showToast(
          msg: 'Please wait for checking approval',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.deepOrange,
          timeInSecForIosWeb: 5);
      return;
    }

    // Insert profile data into Supabase
    final insertResponse = await supabase.from('CheckingRequestQueue').insert([
      {
        'employee_id': myUserId,
        'checking_time': currentTime,
        'checking_type': CheckingType.CHECKIN.toString().split('.')[1],
        'checking_date': dayOfWeek,
        'checking_status': CheckingStatus.PENDING.toString().split('.')[1]
      }
    ]);

    Fluttertoast.showToast(
        msg: 'Check In Request Sent',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.green,
        timeInSecForIosWeb: 5);
  } catch (error) {
    print('There was an error while checking you in: $error');
  }
}

Future<void> handleCheckOut(String myUserId) async {
  final currentTime = DateFormat('HH:mm').format(DateTime.now());
  final dayOfWeek = DateFormat('yyyy-MM-dd').format(DateTime.now());

  try {
    // Fetch the user's check-in data for the current day
    final response = await supabase
        .from('EmployeeAttendance')
        .select('*')
        .eq('employee_id', myUserId)
        .eq('checking_date', dayOfWeek);

    // If the User has Checked In then they can check Out
    if (response.isNotEmpty) {
      final existingCheckout =
          response[0]['checkout_time']; // Get checkout time from first record
      final attendanceId =
          response[0]['attendance_id']; // Get attendance id from first record

      if (existingCheckout != null) {
        Fluttertoast.showToast(
            msg: 'You have already checked out today',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.deepOrange,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 5);
        return;
      }

      // Check if a check-out request is already pending for the current day
      final pendingRequest = await supabase
          .from('CheckingRequestQueue')
          .select('*')
          .eq('employee_id', myUserId)
          .eq('checking_date', dayOfWeek)
          .eq('checking_type', CheckingType.CHECKOUT.toString().split('.')[1])
          .eq('checking_status', CheckingStatus.PENDING.toString().split('.')[1]);

      if (pendingRequest.isNotEmpty) {
        Fluttertoast.showToast(
            msg: 'Please wait for checking approval',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.deepOrange,
            timeInSecForIosWeb: 5);
        return;
      }

      final updateResponse = await supabase
          .from('CheckingRequestQueue')
          .insert([
            {
              'id': attendanceId,
              'employee_id': myUserId,
              'checking_time': currentTime,
              'checking_type': CheckingType.CHECKOUT.toString().split('.')[1],
              'checking_date': dayOfWeek,
              'checking_status': CheckingStatus.PENDING.toString().split('.')[1]
            }
          ])
          .eq('employee_id', myUserId)
          .eq('checking_date', dayOfWeek);

      Fluttertoast.showToast(
          msg: 'Check Out Request has been sent successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          timeInSecForIosWeb: 5);
    } else {
      Fluttertoast.showToast(
          msg: 'Please make sure you have checked in first',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.deepOrange,
          timeInSecForIosWeb: 5);
      return;
    }
  } catch (error) {
    print('Error creating account: $error');
  }
}