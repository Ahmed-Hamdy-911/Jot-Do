import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../core/widgets/custom_text_form.dart';
import '../../../../generated/l10n.dart';

class CustomEmailField extends StatelessWidget {
  const CustomEmailField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).email,
          style: TextStyle(
            fontSize:
                screenWidth < 600 ? screenWidth * 0.04 : screenWidth * 0.02,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SmallSpace(),
        CustomTextFormField(
          hintText: S.of(context).enter_email,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            FilteringTextInputFormatter.deny(" "),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).error_required_field;
            } else if (!RegExp(
                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                .hasMatch(value)) {
              return S.of(context).error_invalid_email;
            }
            return null;
          },
        ),
      ],
    );
  }
}
