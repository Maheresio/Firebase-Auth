import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());

  late String verificationId;
  String otpCode='123456';
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> phoneAuth({required String phoneNumber}) async {
    emit(PhoneAuthLoading());

    await auth.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      timeout: const Duration(seconds: 60),
    );
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await auth.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (e) {
      emit(PhoneAuthFailed(e.toString()));
    }
  }

  //when the code sent and your phone verify it automatically
  Future<void> verificationCompleted(PhoneAuthCredential credential) async {
    await signIn(credential);
  }

  Future<void> verificationFailed(FirebaseAuthException error) async {
    if (error.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
    emit(
      PhoneAuthFailed(
        error.message.toString(),
      ),
    );
    // Handle other errors
  }

  //code sent means the phone number is right but manually we verify it
  Future<void> codeSent(String verificationId, int? resendToken) async {
    print('code sent hahahahahaahhahahaha');
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());

  }

  Future<void> codeAutoRetrievalTimeout(String verificationId) async {
    print('auto retrieval timeout hahahahahahaahahhahaahhaa');
  }

  Future<void> submitOtp(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);
    await signIn(credential);
  }
  Future<void>signOut()async{
    await FirebaseAuth.instance.signOut();
  }User? getCurrentUser(){
    return FirebaseAuth.instance.currentUser!;
  }

}
