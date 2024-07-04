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

Future<Map<String, double>> calculateAttendancePercentages(
    String employeeId) async {
  try {
    final totalAttendanceResponse = await supabase
        .from('EmployeeAttendance')
        .select('employee_id')
        .eq('employee_id', employeeId)
        .count(CountOption.exact);

    final onTimeAttendanceResponse = await supabase
        .from('EmployeeAttendance')
        .select('employee_id')
        .eq('employee_id', employeeId)
        .eq('attendance_tag', 'PRESENT')
        .count(CountOption.exact);

    final lateAttendanceResponse = await supabase
        .from('EmployeeAttendance')
        .select('employee_id')
        .eq('employee_id', employeeId)
        .eq('attendance_tag', 'ABSENT')
        .count(CountOption.exact);

    final totalAttendance = totalAttendanceResponse.data.first['count'];
    final onTimeAttendance = onTimeAttendanceResponse.data.first['count'];
    final lateAttendance = lateAttendanceResponse.data.first['count'];

    final onTimePercentage = (onTimeAttendance / totalAttendance) * 100;
    final latePercentage = (lateAttendance / totalAttendance) * 100;

    return {
      'onTimePercentage': onTimePercentage,
      'latePercentage': latePercentage,
    };
  } on PostgrestException catch (e) {
    print('Exception details:\n $e');
    return {
      'onTimePercentage': 0.0,
      'latePercentage': 0.0,
    };
  } catch (e) {
    print('Exception details:\n $e');
    return {
      'onTimePercentage': 0.0,
      'latePercentage': 0.0,
    };
  }
}


Future<int> calculateTotalDaysAbsent(String employeeId) async {
  try {
    final response = await supabase
        .from('EmployeeAttendance')
        .select('employee_id')
        .eq('employee_id', employeeId)
        .eq('attendance_tag', 'ABSENT')
        .count(CountOption.exact);

    return response.count;
  } on PostgrestException catch (e) {
    print('Exception details:\n $e');
    return 0;
  }
}




Future<void> insertEmployeeLeaveForm({
  required DateTime requestedLeaveDate,
  required String leaveId,
  required String leaveType,
  required DateTime leaveStart,
  required DateTime leaveEnd,
  required int leaveDays,
  required String leaveStatus,
}) async {
  try {
    // Initialize Supabase client
    final supabase = Supabase.instance.client;

    // Prepare the data to be inserted
    final Map<String, dynamic> leaveFormData = {
      'requested_leave_date': requestedLeaveDate.toIso8601String(),
      'leave_id': leaveId,
      'leave_type': leaveType,
      'leave_start': leaveStart.toIso8601String(),
      'leave_end': leaveEnd.toIso8601String(),
      'leave_days': leaveDays,
      'leave_status': leaveStatus,
    };

    // Insert the data into the EmployeeLeaveForm table
    final response = await supabase
        .from('EmployeeLeaveForm')
        .insert(leaveFormData)
        .select();

    print('Error inserting employee leave form: $response');
    } catch (e) {
    print('Exception occurred while inserting employee leave form: $e');
  }
}


Future<List<Map<String, dynamic>>> fetchEmployeeLeaveRequests(String employeeId) async {
  try {
    final response = await supabase
        .from('EmployeeLeaveForm')
        .select()
        .eq('leave_id', employeeId)
        .order('requested_leave_date', ascending: false);

    return response;
  } catch (e) {
    print('Error fetching employee leave requests: $e');
    return [];
  }
}