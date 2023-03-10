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
    final theme = Theme.of(context);
    final dh = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => _node.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: dh,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/loginBackground.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const FlutterLogo(size: 100.0),
                    const SizedBox(width: 16.0),
                    Text(
                      'MDA',
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(color: theme.colorScheme.onBackground),
                    )
                  ],
                ),
                SizedBox(height: dh * 0.1),
                Center(
                  child: Padding(
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
                          hintText: 'Employee ID',
                          helperText: 'Enter your 7 digit employee Id',
                          helperStyle: theme.textTheme.caption
                              ?.copyWith(color: theme.colorScheme.onBackground),
                          isDense: true,
                          filled: true,
                          fillColor: theme.colorScheme.surface,
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: const Icon(Icons.person, size: 24.0),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.qr_code_scanner_outlined),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: dh * 0.08),
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
          ),
        ),
        // ),
      ),
    );
  }
}
