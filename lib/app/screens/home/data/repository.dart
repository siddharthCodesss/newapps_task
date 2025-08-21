import 'package:dio/dio.dart';
import 'package:newapps_task/app/base/constants/api_endpoints.dart';
import 'package:newapps_task/app/screens/home/model/employee_management_response.dart';
import '../../../apis/error/exception.dart';
import '../../../apis/network/network_api_services.dart';

abstract class EmployeeDetailsRepository {
  Future<EmployeeManagementResponse?> getEmployeeData();
}

class EmployeeDetailsRepositoryImpl implements EmployeeDetailsRepository {
  @override
  Future<EmployeeManagementResponse> getEmployeeData() async {
    try {
      print("CancelRideRepositoryImpl");
      Response response = await restClient.get(ApiEndpoints.apiURL);
      return EmployeeManagementResponse.fromJson(response.data);
    } catch (e) {
      if (e is ServerException) {
        throw ServerException(e.code, e.message);
      } else {
        throw Exception(e.toString());
      }
    }
  }
}
