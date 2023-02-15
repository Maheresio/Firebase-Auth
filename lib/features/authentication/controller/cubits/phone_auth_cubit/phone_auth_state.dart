part of 'phone_auth_cubit.dart';



@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}
class PhoneAuthFailed extends PhoneAuthState {
     final String errorMsg;
     PhoneAuthFailed(  this.errorMsg);
}
class PhoneAuthLoading extends PhoneAuthState {}
class PhoneNumberSubmitted extends PhoneAuthState{}
class PhoneOTPVerified extends PhoneAuthState{}
