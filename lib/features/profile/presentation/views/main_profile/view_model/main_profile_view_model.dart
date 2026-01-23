import 'dart:async';

import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_intents.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_state.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_ui_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class MainProfileViewModel extends Cubit<MainProfileViewState> {
  MainProfileViewModel() : super(const MainProfileViewState.init());
  final _uiControllerBroadcast =
      StreamController<MainProfileViewUIEvents>.broadcast();

  Stream<MainProfileViewUIEvents> get uiEvents => _uiControllerBroadcast.stream;

  doIntent(ProfileViewIntents intent) {
    switch (intent) {
      case OnEditProfileClickIntent():
        _navToEdit();
      case OnMyOrdersClickIntent():
        _navToMyOrders();
      case OnSavedAddressesClickIntent():
        _navToAddresses();
      case OnNotificationClickIntent():
        _navToNotification();
      case OnLanguageClickIntent():
        _openLanguagesBottomSheet();
      case OnTermsClickIntent():
        _navToTerms();
      case OnAboutUsClickIntent():
        _navToAboutUs();
      case OnLogoutClickIntent():
        _logout();
    }
  }

  _navToEdit() => _uiControllerBroadcast.add(NavToEditProfileEvent());

  _navToMyOrders() => _uiControllerBroadcast.add(NavToMyOrdersEvent());

  _navToAddresses() => _uiControllerBroadcast.add(NavToSavedAddressesEvent());

  _navToNotification() => _uiControllerBroadcast.add(NavToNotificationEvent());

  _openLanguagesBottomSheet() =>
      _uiControllerBroadcast.add(OpenLanguageBottomSheetEvent());

  _navToTerms() => _uiControllerBroadcast.add(NavToTermsEvent());

  _navToAboutUs() => _uiControllerBroadcast.add(NavToAboutUsEvent());

  _logout() => _uiControllerBroadcast.add(LogoutEvent());

  @override
  Future<void> close() {
    _uiControllerBroadcast.close();
    return super.close();
  }
}

