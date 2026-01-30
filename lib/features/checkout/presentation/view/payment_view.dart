import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/features/checkout/domain/entity/session_entity.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  WebViewController? _controller;
  late SessionEntity session;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    session = ModalRoute.of(context)!.settings.arguments as SessionEntity;

    if (_controller == null) {
      _initializeController();
    }
  }

  void _initializeController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url.toLowerCase();

            if (url.contains('/allorders')) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Toast.showToast(
                  context,
                  "Payment Completed Successfully".tr(),
                  isError: false,
                );

                /// pushNamedAndRemoveUntil
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.appSection,
                  // (route) => false,
                );
              });

              return NavigationDecision.prevent;
            }

            if (url.contains('/cart')) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Toast.showToast(
                  context,
                  "Payment Canceled".tr(),
                  isError: true,
                );

                Navigator.pop(context);
              });

              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(session.url ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('payment'.tr()),
        automaticallyImplyLeading: false,
      ),
      body: _controller == null
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(controller: _controller!),
    );
  }

  @override
  void dispose() {
    _controller?.clearCache();
    super.dispose();
  }
}
