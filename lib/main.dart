import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:map_project/core/routing/routing.dart';
import 'package:map_project/core/utils/app_colors.dart';
import 'package:map_project/features/authentication/controller/cubits/phone_auth_cubit/phone_auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneAuthCubit>(
      create: (ctx) => PhoneAuthCubit(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.latoTextTheme(),
            primarySwatch: AppColors.primarySwatchColor,
          ),
          onGenerateRoute: Routing.generateRoute,
        ),
      ),
    );
  }
}
