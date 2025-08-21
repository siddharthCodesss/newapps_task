import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' /* hide Trans*/;
import 'package:oktoast/oktoast.dart';
import 'package:newapps_task/app/base/constants/color_constants.dart';
import 'package:newapps_task/app/base/network_sensitive/cubit/internet_cubit.dart';
import 'package:newapps_task/app/base/router/router.dart';
import 'package:newapps_task/app/base/theme/cubit/theme_cubit.dart';
import 'package:newapps_task/app/base/theme/theme_data.dart';
import 'package:newapps_task/app/base/theme/theme_manager.dart';
import 'package:newapps_task/app/base/utils/preference_utils.dart';
import 'package:newapps_task/app/base/dependency_injection/di.dart' as di;

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await ScreenUtil.ensureScreenSize();
    SPUtil spUtil = await SPUtil.getInstance();
    di.init();
    runApp(App());
  }, (error, stackTrace) {});
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (_) => InternetCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light
              .copyWith(statusBarColor: AppColors.statusBarColor),
          child: const MyApp()),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorConstants.backgroundColor,
        statusBarBrightness: Brightness.light,
      ),
    );

    return OKToast(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taxi App',
        theme: lightThemeData(),
        onGenerateRoute: MRouter.generateRoute,
        initialRoute: MRouter.employeeDetails,
      ),
    );
  }
}
