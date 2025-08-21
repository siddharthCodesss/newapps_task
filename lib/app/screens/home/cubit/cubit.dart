import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:newapps_task/app/base/database_helper/database_helper.dart';
import 'package:newapps_task/app/screens/home/cubit/state.dart';
import 'package:newapps_task/app/screens/home/data/repository.dart';
import 'package:newapps_task/app/screens/home/model/employee_management_response.dart';

class EmployeeManagementCubit extends Cubit<EmployeeDataState> {
  late final EmployeeDetailsRepository _repository;
  late final DatabaseHelper _databaseHelper;

  EmployeeManagementCubit(this._repository, this._databaseHelper)
      : super(InitialEmployeeDataState());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _firstName = BehaviorSubject<String>();

  Stream<String> get firstName => _firstName.stream;

  Function(String) get changeFirstName => _firstName.sink.add;

  final _lastName = BehaviorSubject<String>();

  Stream<String> get lastName => _lastName.stream;

  Function(String) get changeLastName => _lastName.sink.add;

  final _email = BehaviorSubject<String>();

  Stream<String> get email => _email.stream;

  Function(String) get changeEmail => _email.sink.add;

  final _employeeData = BehaviorSubject<List<Datum>?>();

  Stream<List<Datum>?> get employeeData => _employeeData.stream;

  Function(List<Datum>?) get changeEmployeeData => _employeeData.sink.add;

  List<Datum>? get employeeDataValue => _employeeData.value;

  // int selectedEmployee = 0;
  final _selectedEmployee = BehaviorSubject<int>.seeded(0);

  Stream<int> get selectedEmployee => _selectedEmployee.stream;

  Function(int) get changeSelectedEmployee => _selectedEmployee.sink.add;

  int get selectedEmployeeValue => _selectedEmployee.value;

  EmployeeManagementResponse? apiResponse;

  Future<void> getDataFromAPI() async {
    apiResponse = await _repository.getEmployeeData();
  }

  Future<void> getEmployeeData() async {
    try {
      if (apiResponse!.data.isNotEmpty) {
        List<Datum> data = await _databaseHelper.getData();

        if (data != apiResponse!.data) {
          await _databaseHelper.insertAllData(apiResponse!.data);
          changeEmployeeData(apiResponse!.data);
        }
      } else {
        debugPrint("The API response is empty");
      }
    } catch (e) {
      debugPrint("Error caught calling the getEmployeeData method : $e");
    }
  }

  Future<void> initialiseDatabase() async {
    await _databaseHelper.openDB();
  }

  getEmployeeDetail(int id) async {
    List<Datum> result = await _databaseHelper.getEmployeeDetails(id);
    debugPrint("Data in result :  $result");
    changeEmployeeData(result);
  }

  Future<void> updateRecord(
      int id, String? firstName, String? lastName, String? email) async {
    try {
      if (firstNameController.text.isEmpty) {
        _firstName.sink.addError("First Name cannot be empty");
        return;
      } else if (lastNameController.text.isEmpty) {
        _lastName.sink.addError("Last name cannot be empty");
        return;
      } else if (emailController.text.isEmpty) {
        _email.sink.addError("Email cannot be empty");
        return;
      }

      await _databaseHelper.updateRecord(id, firstName!, lastName!, email!);
      List<Datum> data = await _databaseHelper.getData();
      changeEmployeeData(data);
    } catch (e) {
      debugPrint("Error caught  while updating the record : $e");
    }
  }

  Future<void> deleteRecord(int id) async {
    await _databaseHelper.deleteRecord(id);
    List<Datum> data = await _databaseHelper.getData();
    print(
        "New Data : ${data[0].firstName} | ${data[0].lastName} | ${data[0].email}");
    changeEmployeeData(data);
  }

  @override
  Future<void> close() {
    // TODO: implement close
    _employeeData.close();
    return super.close();
  }
}
