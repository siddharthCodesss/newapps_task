import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:vritti_task/screens/home/employee_management.dart';

class MRouter {
  static const String employeeDetails = "EmployeeDetails";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case employeeDetails:
      //   return CupertinoPageRoute(builder: (_) => const EmployeeDetails());
      default:
        return CupertinoPageRoute(builder: (_) => NoRouteScreen(settings.name));
    }
  }
}

class NoRouteScreen extends StatelessWidget {
  final String? screenName;

  const NoRouteScreen(this.screenName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('${'no_route_defined'} "$screenName"')),
    );
  }
}
