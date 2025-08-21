import 'package:equatable/equatable.dart';

abstract class EmployeeDataState extends Equatable{
  const EmployeeDataState();
}

class InitialEmployeeDataState extends EmployeeDataState {
  @override
  List<Object> get props => [];
}