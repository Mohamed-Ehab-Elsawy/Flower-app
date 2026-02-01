import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/helper/show_toast.dart';
import 'package:flower_app/core/helper/app_routes.dart';
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
  SessionEntity? session;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is SessionEntity) {
      session = args;
      if (_controller == null &&
          session?.url != null &&
          session!.url!.isNotEmpty) {
        _initializeController();
      } else if (session?.url == null || session!.url!.isEmpty) {
        _handleInvalidSession();
      }
    } else {
      _handleInvalidSession();
    }
  }

  void _handleInvalidSession() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Toast.showToast(context, "invalid_payment_session".tr(), isError: true);
        Navigator.pop(context);
      }
    });
  }

  void _initializeController() {
    final uri = Uri.parse(session!.url!);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url.toLowerCase();

            if (url.contains('/allorders')) {
              _navigateWithToast(
                "Payment Completed Successfully".tr(),
                false,
                isSuccess: true,
              );
              return NavigationDecision.prevent;
            }

            if (url.contains('/cart')) {
              _navigateWithToast("Payment Canceled".tr(), true);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(uri);

    setState(() {});
  }

  void _navigateWithToast(
    String message,
    bool isError, {
    bool isSuccess = false,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Toast.showToast(context, message, isError: isError);
      if (isSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.appSection,
          (route) => false,
        );
      } else {
        Navigator.pop(context);
      }
    });
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
    _controller = null;
    super.dispose();
  }
}
