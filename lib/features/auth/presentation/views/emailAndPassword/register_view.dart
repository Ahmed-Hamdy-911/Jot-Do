import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/custom/custom_loading.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_states.dart';
import '../../widgets/register_form.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomLoading(
        state: context.watch<AuthCubit>().state is AuthLoadingState,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth >= 600) {
                  return SizedBox(
                    width: constraints.maxWidth * 0.7,
                    child: const RegisterForm(),
                  );
                }
                return const RegisterForm();
              }),
            ),
          ),
        ),
      ),
    );
  }
}
