import 'package:PALMHR_MOBILE/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<Map<String, dynamic>>> fetchAttendanceHistory(
    String employeeId) async {
  try {
    final response = await supabase
        .from('EmployeeAttendance')
        .select(
            'attendance_id,employee_id,checkin_time,checkout_time,checking_date,working_time,attendance_tag')
        .eq('employee_id', employeeId)
        .order('checking_date', ascending: false);
    return response;
  } catch (e) {
    print('Exception details:\n $e');
    return [];
  }
}

Future<List<Map<String, dynamic>>> fetchClockingData(String historyId) async {
  final today = DateTime.now().toIso8601String().split('T')[0];
  try {
    final response = await supabase
        .from('EmployeeAttendance')
        .select('checkin_time,checkout_time')
        .eq('employee_id', historyId)
        .eq('checking_date', today)
        .order('checkin_time', ascending: false)
        .limit(1);

    return response;
  } catch (e) {
    print('Exception details:\n $e');
    return [];
  }
}

Future<List<Map<String, dynamic>>> fetchUserData(String userIdKey) async {
  try {
    final response = await supabase
        .from('EmployeeProfile')
        .select('first_name,last_name,profile_image,position')
        .eq('profile_id', userIdKey);
    return response;
  } catch (e) {
    print('Exception details:\n $e');
    return [];
  }
}

Future<int> fetchTotalWorkingDays(String userIdKey) async {
  try {
    final response = await supabase
        .from('EmployeeAttendance')
        .select('attendance_tag')
        .eq('employee_id', userIdKey)
        .eq('attendance_tag', 'PRESENT')
        .count(CountOption.exact);

    return response.count;
  } catch (e) {
    print('Exception details:\n $e');
    return int.parse('0');
  }
}

Future<int> fetchOnTimeArrivalCount(String userIdKey) async {
  try {
    final response = await supabase
        .from('EmployeeAttendance')
        .select('presence_tag')
        .eq('employee_id', userIdKey)
        .eq('presence_tag', 'PRESENT')
        .count(CountOption.exact);
    return response.count;
  } catch (e) {
    print('Exception details:\n $e');
    return int.parse('0');
  }
}

Future<List<Map<String, dynamic>>> fetchDayOfWeekAndWorkHours(
    String userId) async {
  try {
    final response = await supabase
        .from('EmployeeAttendance')
        .select('checking_date, working_time')
        .eq('employee_id', userId);
    return response;
  } catch (e) {
    print('Exception details:\n $e');
    return [];
  }
}

Future<List<Map<String, dynamic>>> leaveRequest(String userId) async {
  try {
    final response = await supabase
        .from('EmployeeLeaveForm')
        .select(
            'leave_id,requested_leave_date,leave_days,leave_approval,leave_type')
        .eq('leave_id', userId);
    return response;
  } catch (e) {
    print('Exception details:\n $e');
    return [];
  }
}

Future<Object> fetchEmployeeAttendance(
    String employeeId, int month, int year) async {
  final startDate = DateTime(year, month);
  final endDate = DateTime(year, month + 1).subtract(const Duration(days: 1));

  final earlyArrivals = <String>[];
  final lateDepartures = <String>[];
  try {
    final response = await supabase
        .from('employee_attendance')
        .select('checking_date, checking_time, attendance_tag')
        .eq('employee_id', employeeId)
        .gte('checking_date', startDate)
        .lte('checking_date', endDate);

    for (final attendance in response) {
      final checkingDate = DateTime.parse(attendance['checking_date']);
      final checkingTime = DateTime.parse(attendance['checking_time']);

      final expectedCheckinTime =
          DateTime(checkingDate.year, checkingDate.month, checkingDate.day, 9);
      final expectedCheckoutTime =
          DateTime(checkingDate.year, checkingDate.month, checkingDate.day, 17);

      if (attendance['attendance_tag'] == 'PRESENT') {
        if (checkingTime.isBefore(expectedCheckinTime)) {
          earlyArrivals.add(attendance['checking_date']);
        } else if (checkingTime.isAfter(expectedCheckoutTime)) {
          lateDepartures.add(attendance['checking_date']);
        }
      }
    }

    return {
      'earlyArrivals': earlyArrivals,
      'lateDepartures': lateDepartures,
    };
  } catch (e) {
    print('Exception details:\n $e');
    return [];
  }
}

Future<Map<String, double>> calculateAttendancePercentages(
    String employeeId) async {
  final totalAttendanceResponse = await supabase
      .from('EmployeeAttendance')
      .select('id')
      .eq('employee_id', employeeId)
      .count(CountOption.exact);

  final onTimeAttendanceResponse = await supabase
      .from('EmployeeAttendance')
      .select('id')
      .eq('employee_id', employeeId)
      .eq('attendance_tag', 'PRESENT')
      .count(CountOption.exact);

  final lateAttendanceResponse = await supabase
      .from('EmployeeAttendance')
      .select('id')
      .eq('employee_id', employeeId)
      .eq('attendance_tag', 'ABSENT')
      .count(CountOption.exact);

  if (totalAttendanceResponse != null ||
      onTimeAttendanceResponse != null ||
      lateAttendanceResponse != null) {
    throw Exception('Error fetching data');
  }

  final totalAttendance = totalAttendanceResponse.data.first['count'];
  final onTimeAttendance = onTimeAttendanceResponse.data.first['count'];
  final lateAttendance = lateAttendanceResponse.data.first['count'];

  final onTimePercentage = (onTimeAttendance / totalAttendance) * 100;
  final latePercentage = (lateAttendance / totalAttendance) * 100;

  return {
    'onTimePercentage': onTimePercentage,
    'latePercentage': latePercentage,
  };
}
