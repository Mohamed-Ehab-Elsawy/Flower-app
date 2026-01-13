import 'package:equatable/equatable.dart';

sealed class MainProfileViewUIEvents {}

class NavToEditProfileEvent extends MainProfileViewUIEvents
    with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class NavToMyOrdersEvent extends MainProfileViewUIEvents with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class NavToSavedAddressesEvent extends MainProfileViewUIEvents with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class NavToNotificationEvent extends MainProfileViewUIEvents with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class LogoutEvent extends MainProfileViewUIEvents with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class NavToTermsEvent extends MainProfileViewUIEvents with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class NavToAboutUsEvent extends MainProfileViewUIEvents with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class OpenLanguageBottomSheetEvent extends MainProfileViewUIEvents with EquatableMixin {
  @override
  List<Object?> get props => [];
}
