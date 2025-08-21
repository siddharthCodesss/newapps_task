import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:newapps_task/app/base/theme/theme_manager.dart';
import 'package:newapps_task/app/base/widgets/buttons/raised_button.dart';
import 'package:newapps_task/app/base/widgets/text_field_widget/input_text_field_rounded.dart';
import 'package:newapps_task/app/screens/home/cubit/cubit.dart';
import 'package:newapps_task/app/screens/home/model/employee_management_response.dart';

import '../../base/dependency_injection/di.dart';

class EmployeeDetails extends StatefulWidget {
  const EmployeeDetails({Key? key}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails>
    with TickerProviderStateMixin {
  final cubit = sl<EmployeeManagementCubit>();

  @override
  void initState() {
    super.initState();
    initialExecutiveCalls();
  }

  void initialExecutiveCalls() async {
    await cubit.initialiseDatabase();
    await cubit.getDataFromAPI();
    await cubit.getEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Employee Data"),
          backgroundColor: AppColors.coolGray2,
          elevation: 1.5,
          actions: [
            IconButton(
                onPressed: () {
                  cubit.getEmployeeData();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: AppColors.whiteColor,
                ))
          ],
          bottom: PreferredSize(
              preferredSize: Size(context.width, 30),
              child: SizedBox(
                height: context.height * 0.05,
                child: StreamBuilder<List<Datum>?>(
                    stream: cubit.employeeData,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const SizedBox.shrink();
                      }
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                cubit.changeSelectedEmployee(index);
                                cubit.getEmployeeDetail(index);
                                cubit.getEmployeeData();
                              },
                              child: SizedBox(
                                width: context.width * 0.25,
                                height: context.height * 0.05,
                                child: Text(
                                  "Employee ${index + 1}",
                                  style:
                                      const TextStyle(color: AppColors.white),
                                ),
                              ),
                            );
                          });
                    }),
              )),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<List<Datum>?>(
              stream: cubit.employeeData,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return SizedBox(
                      height: context.height,
                      width: context.width,
                      child: const Center(
                        child: Text(
                          "Please Select An Employee To See The \nEmployee Details",
                          textAlign: TextAlign.center,
                        ),
                      ));
                }

                return Container(
                  height: context.height * 0.9,
                  width: context.width,
                  padding: EdgeInsets.all(context.width * 0.1),
                  child: buildInformationWidget(
                      snapshot.data![cubit.selectedEmployeeValue].avatar,
                      snapshot.data![cubit.selectedEmployeeValue].firstName,
                      snapshot.data![cubit.selectedEmployeeValue].lastName,
                      snapshot.data![cubit.selectedEmployeeValue].email,
                      snapshot.data![cubit.selectedEmployeeValue].id),
                );
              }),
        ));
  }

  Widget buildInformationWidget(String avatarUrl, String firstName,
      String lastName, String email, int id) {
    return SizedBox(
      height: context.height * 0.3,
      width: context.width,
      child: Column(
        children: [
          CircleAvatar(
            radius: context.width * 0.2,
            backgroundImage: NetworkImage(avatarUrl),
          ),
          SizedBox(
            height: context.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "First Name : ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Last Name : ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Email : ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    firstName,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    lastName,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    buildEditEmployeeDataDialog(context, firstName, id);
                  },
                  child: const Text("Edit")),
              ElevatedButton(
                  onPressed: () {
                    cubit.deleteRecord(id);
                    setState(() {});
                  },
                  child: const Text("Delete")),
            ],
          ),
          SizedBox(
            height: context.height * 0.05,
          ),
        ],
      ),
    );
  }

  void buildEditEmployeeDataDialog(
      BuildContext context, String firstName, int id) {
    Dialog editDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SingleChildScrollView(
        child: Container(
          height: context.height * 0.75,
          width: context.width * 0.8,
          padding: EdgeInsets.all(context.width * 0.1),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit $firstName's Details",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              StreamBuilder<String>(
                  stream: cubit.firstName,
                  builder: (context, snapshot) {
                    return InputTextFieldRounded(
                        TextInputType.text,
                        1,
                        50,
                        "Enter first name",
                        false,
                        cubit.firstNameController,
                        snapshot.hasError ? snapshot.error.toString() : null,
                        cubit.changeFirstName);
                  }),
              SizedBox(
                height: context.height * 0.01,
              ),
              StreamBuilder<String>(
                  stream: cubit.lastName,
                  builder: (context, snapshot) {
                    return InputTextFieldRounded(
                        TextInputType.text,
                        1,
                        50,
                        "Enter last name",
                        false,
                        cubit.lastNameController,
                        snapshot.hasError ? snapshot.error.toString() : null,
                        cubit.changeLastName);
                  }),
              SizedBox(
                height: context.height * 0.01,
              ),
              StreamBuilder<String>(
                  stream: cubit.email,
                  builder: (context, snapshot) {
                    return InputTextFieldRounded(
                        TextInputType.text,
                        1,
                        50,
                        "Enter email",
                        false,
                        cubit.emailController,
                        snapshot.hasError ? snapshot.error.toString() : null,
                        cubit.changeEmail);
                  }),
              SizedBox(
                height: context.height * 0.01,
              ),
              RaisedRectButton(
                  textWidget: const Text("Update Record"),
                  onPressed: () {
                    cubit.updateRecord(
                        id,
                        cubit.firstNameController.text,
                        cubit.lastNameController.text,
                        cubit.emailController.text);
                    // cubit.emailController.text).then((value) => cubit.getEmployeeData());
                    Navigator.pop(context, true);
                  })
            ],
          ),
        ),
      ),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return editDialog;
        });
  }
}
