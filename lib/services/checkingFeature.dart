import 'package:PALMHR_MOBILE/main.dart';
import 'package:supabase/supabase.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum CheckingType {
  checkin,
  checkout,
}

enum CheckingStatus {
  approved,
  declined,
  pending,
}

Future<void> handleCheckIn(String myUserId) async {
  final currentTime = DateFormat('HH:mm').format(DateTime.now());
  final dayOfWeek = DateFormat('yyyy-MM-dd').format(DateTime.now());

  try {
    // Fetch the user's check-in data for the current day
    final response = await supabase
        .from('CheckingRequestQueue')
        .select('*')
        .eq('employee_id', myUserId)
        .eq('checking_date', dayOfWeek);

    // If a check-in for the current day already exists, return early
    if (response.isNotEmpty) {
      Fluttertoast.showToast(
          msg: 'Already checked In',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5);
      return;
    }

    // Insert profile data into Supabase
    final insertResponse = await supabase
        .from('CheckingRequestQueue')
        .insert([
          {
            'employee_id': myUserId,
            'checking_time': currentTime,
            'checking_type': CheckingType.checkin.toString().split('.')[1],
            'checking_date': dayOfWeek,
            'checking_status': CheckingStatus.pending.toString().split('.')[1]
          }
        ])
        .eq('employee_id', myUserId);

    if (insertResponse.error != null) {
      print('Error Checking In: ${insertResponse.error!.message}');
    } else {
      Fluttertoast.showToast(
          msg: 'Check In Request Sent',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5);
      return insertResponse.data;
    }
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
      final existingCheckout = response[0]['checkout_time']; // Get checkout time from first record
      final attendanceId = response[0]['attendance_id']; // Get attendance id from first record

      if (existingCheckout != null) {
        Fluttertoast.showToast(
            msg: 'You have already checked out today',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
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
              'checking_type': CheckingType.checkout.toString().split('.')[1],
              'checking_date': dayOfWeek,
              'checking_status': CheckingStatus.pending.toString().split('.')[1]
            }
          ])
          .eq('employee_id', myUserId)
          .eq('checking_date', dayOfWeek);

      if (updateResponse.error != null) {
        print('Error updating checkout time: ${updateResponse.error!.message}');
      } else {
        Fluttertoast.showToast(
            msg: 'Check Out Request has been sent successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 5);
        return updateResponse.data;
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please make sure you have checked in first',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 5);
      return;
    }
  } catch (error) {
    print('Error creating account: $error');
  }
}