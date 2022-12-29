import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobile_delivery_app/src/features/home/home_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _loginController;
  late final FocusNode _node;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _node = FocusNode();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _node.dispose();
    super.dispose();
  }

  String? _validateEmployeeId(String? val) {
    return (val == null || val.length < 7)
        ? 'Enter a 7 digit employee ID.'
        : null;
  }

  Future<void> _validate() async {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(employeeIdProvider.notifier).state =
          _loginController.text.trim();

      setState(() => _loading = !_loading);
      await Future.delayed(const Duration(seconds: 1));
      setState(() => _loading = !_loading);

      if (mounted) {
        Navigator.of(context).pushNamed(homeRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // 20% of screen height.
    final dimHeight = MediaQuery.of(context).size.height * 0.15;

    return GestureDetector(
      onTap: () => _node.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: dimHeight),
              child: const FlutterLogo(
                size: 160.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _loginController,
                  focusNode: _node,
                  inputFormatters: [LengthLimitingTextInputFormatter(7)],
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (value) => _validate(),
                  validator: (str) => _validateEmployeeId(str),
                  decoration: InputDecoration(
                    labelText: 'Employee ID',
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: const Icon(Icons.person, size: 24.0),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.qr_code_scanner_outlined),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _loading
                  ? const CircularProgressIndicator.adaptive()
                  : ElevatedButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 64.0,
                          vertical: 12.0,
                        ),
                      ),
                      onPressed: () => _validate(),
                      child: const Text('Login'),
                    ),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
        // ),
      ),
    );
  }
}
