import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:map_project/core/utils/app_constants.dart';
import 'package:map_project/core/utils/app_strings.dart';
import 'package:map_project/features/authentication/controller/cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'package:map_project/shared/helper/generate_flag.dart';
import 'package:map_project/widgets/custom_circular_indicator.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final blocData = BlocProvider.of<PhoneAuthCubit>(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: BlocListener<PhoneAuthCubit, PhoneAuthState>(
            listener:(context, state) {
              if (state is PhoneAuthLoading) {
                showProgressIndicator(context);
              }
              else if (state is PhoneAuthFailed) {
                Navigator.of(context).pop();
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
              }
              else if (state is PhoneNumberSubmitted) {
                Navigator.of(context).pop();
                Navigator.pushNamed(
                  context,
                  AppStrings.otpRoute,
                  arguments: {
                    'phone': phoneController.text.toString(),
                  },
                );
              }
            },
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
                          AppStrings.questionAboutNumber,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppConstants.titleLarge,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          AppStrings.enterYourPhone,
                          style: TextStyle(
                            fontSize: AppConstants.bodyLarge,
                            fontWeight: FontWeight.w500,
                            letterSpacing: AppConstants.letterSpacing,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        SizedBox(
                          height: 70.h,
                        ),
                        SizedBox(
                          height: 60.h,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 14.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(
                                      AppConstants.radius,
                                    ),
                                  ),
                                  child: Text(
                                    '${generateCountryFlag()} +20',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(
                                      11,
                                    ),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    letterSpacing: 2,
                                  ),
                                  enableInteractiveSelection: true,
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.done,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return AppStrings.phoneIsEmpty;
                                    }
                                    if (val.length != 11) {
                                      return AppStrings.phoneTooShort;
                                    }
                                    if (!(val.startsWith('010') ||
                                        val.startsWith('011') ||
                                        val.startsWith('012') ||
                                        val.startsWith('015'))) {
                                      return AppStrings.phoneInstructions;
                                    }
                                    return null;
                                  },
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    labelText: "Enter your phone",
                                    labelStyle: const TextStyle(
                                      letterSpacing: 0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppConstants.radius,
                                      ),
                                    ),
                                  ),
                                  controller: phoneController,
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

                                if (_formKey.currentState!.validate()) {
                                  Navigator.of(context).pop();
                                  _formKey.currentState!.save();
                                  blocData.phoneAuth(
                                    phoneNumber:
                                        phoneController.text.toString(),
                                  );
                                } else {
                                  Navigator.of(context).pop();
                                }
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
            //
            listenWhen: (prev, curr) => prev != curr,
          ),
        ),
      ),
    );
  }
}
