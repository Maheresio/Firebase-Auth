import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_project/core/utils/app_constants.dart';
import 'package:map_project/core/utils/app_strings.dart';
import 'package:map_project/features/authentication/controller/cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:map_project/shared/helper/replace_char_at.dart';
import 'package:map_project/widgets/custom_circular_indicator.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final blocData = BlocProvider.of<PhoneAuthCubit>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: BlocListener<PhoneAuthCubit, PhoneAuthState>(
            listener: (context, state) {
              if (state is PhoneAuthLoading) {
                showProgressIndicator(context);
              } else if (state is PhoneAuthFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      state.errorMsg,
                    ),
                    duration: const Duration(
                      seconds: AppConstants.snackbarDuration,
                    ),
                  ),
                );
              } else if (state is PhoneOTPVerified) {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(AppStrings.mapRoute);
              }
            },
            listenWhen: (prev, curr) => prev != curr,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadd,
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.verifyYourPhone,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.titleLarge,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        RichText(
                          text: TextSpan(
                              text: AppStrings.enterOtp,
                              style: TextStyle(
                                height: 1.2.h,
                                fontSize: AppConstants.bodyLarge,
                                fontWeight: FontWeight.w400,
                                letterSpacing: AppConstants.letterSpacing,
                                color: Colors.grey.shade500,
                              ),
                              children: [
                                TextSpan(
                                  text: args['phone'],
                                  style: TextStyle(
                                    fontSize: AppConstants.bodyLarge,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0,
                                    color: Colors.green,
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 70.h,
                        ),
                        SizedBox(
                          height: 60.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(end: 1.w),
                                  child: SizedBox(
                                    height: 48.h,
                                    width: 42.w,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                          1,
                                        ),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      autofocus: true,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                          AppConstants.radius,
                                        )),
                                      ),
                                      onChanged: (val) {
                                        val.length == 1
                                            ? FocusScope.of(context).nextFocus()
                                            : null;
                                        blocData.otpCode = replaceCharAt(
                                            blocData.otpCode, 0, val);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 1.w,
                                  ),
                                  child: SizedBox(
                                    height: 48.h,
                                    width: 42.w,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                          1,
                                        ),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20.sp),
                                      onChanged: (val) {
                                        val.length == 1
                                            ? FocusScope.of(context).nextFocus()
                                            : null;
                                        blocData.otpCode = replaceCharAt(
                                            blocData.otpCode, 1, val);
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            AppConstants.radius,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 1.w,
                                  ),
                                  child: SizedBox(
                                    height: 48.h,
                                    width: 42.w,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                          1,
                                        ),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                      ),
                                      onChanged: (val) {
                                        val.length == 1
                                            ? FocusScope.of(context).nextFocus()
                                            : null;
                                        blocData.otpCode = replaceCharAt(
                                            blocData.otpCode, 2, val);
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            AppConstants.radius,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 1.w,
                                  ),
                                  child: SizedBox(
                                    height: 48.h,
                                    width: 42.w,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                          1,
                                        ),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                      ),
                                      onChanged: (val) {
                                        val.length == 1
                                            ? FocusScope.of(context).nextFocus()
                                            : null;
                                        blocData.otpCode = replaceCharAt(
                                            blocData.otpCode, 3, val);
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            AppConstants.radius,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 1.w,
                                  ),
                                  child: SizedBox(
                                    height: 48.h,
                                    width: 42.w,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                          1,
                                        ),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                      ),
                                      onChanged: (val) {
                                        val.length == 1
                                            ? FocusScope.of(context).nextFocus()
                                            : null;
                                        blocData.otpCode = replaceCharAt(
                                            blocData.otpCode, 4, val);
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            AppConstants.radius,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 1.w,
                                  ),
                                  child: SizedBox(
                                    height: 48.h,
                                    width: 42.w,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(
                                          1,
                                        ),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                      ),
                                      onChanged: (val) {
                                        val.length == 1
                                            ? FocusScope.of(context).unfocus()
                                            : null;
                                        blocData.otpCode = replaceCharAt(
                                            blocData.otpCode, 5, val);
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            AppConstants.radius,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Align(
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
                                blocData.submitOtp(blocData.otpCode);
                              },
                              child: Text(
                                AppStrings.next,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
