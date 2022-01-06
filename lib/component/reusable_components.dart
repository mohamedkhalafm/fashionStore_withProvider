import 'package:flutter/material.dart';

Widget defaultButton({required Function Function() function, required String text}) =>
    ElevatedButton(onPressed: function, child: Text(text.toUpperCase()));

Widget defaultFormField(
        {required BuildContext context,
        required TextEditingController controller,
        required TextInputType inputType,
        required String? Function(String?)? validate,
        required String label,
        required IconData? prefixIcon,
        IconData? suffixIcon,
        void Function()? onSubmit,
        void Function()? onChange,
        void Function()? onTap,
        bool isPasswordShown = false}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(width: 2, color: Colors.black)),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        onTap: onTap,
        validator: validate ??
            (input) {
              if (input?.isEmpty ?? true) {
                return 'input must not be empty';
              }
              return null;
            },
        obscureText: isPasswordShown,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 25),
            labelText: label,
            prefixIcon: Icon(prefixIcon),
            suffixIcon: Icon(suffixIcon),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)))),
      ),
    );

const Color firstColor = Color.fromRGBO(254, 206, 190, 2);
const Color secondColor = Color.fromRGBO(255, 183, 197, 2);
const Color thirdColor = Color.fromRGBO(173, 206, 215, 2);
