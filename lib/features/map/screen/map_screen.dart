import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_project/core/utils/app_constants.dart';
import 'package:map_project/core/utils/app_strings.dart';
import 'package:map_project/features/authentication/controller/cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:map_project/widgets/custom_circular_indicator.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocData = BlocProvider.of<PhoneAuthCubit>(context);
    return Scaffold(
      body: Center(
        child: Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 45.h,
            width: 100.h,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.radius,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                showProgressIndicator(context);
                 blocData.signOut();
                Navigator.pushReplacementNamed(context,AppStrings.loginRoute,);
              },
              child: Text(
                AppStrings.next,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}
