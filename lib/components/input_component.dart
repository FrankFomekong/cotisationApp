import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class CustomInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? hint;
  final int flexVal;

  final controller;
  const CustomInput({Key? key, this.onChanged, this.hint, this.controller,this.flexVal=1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Flexible(
        flex: flexVal,
        child: TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: GoogleFonts.inter(
              color: AppColors.colorTextInput,
              fontSize: 15,
              fontWeight: FontWeight.w400),
          cursorColor: AppColors.colorTextInput,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            errorStyle: TextStyle(color: AppColors.red),
            filled: true,
            fillColor: AppColors.background2,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none),
            hintText: hint,
            hintStyle: GoogleFonts.inter(
                color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocalizations.of(context)!.empty_input;
            }
            return null;
          },
        ),
      ),
    );
  }
}


class CustomDateInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? hint;
  final int flexVal;

  final controller;
  const CustomDateInput({Key? key, this.onChanged, this.hint, this.controller,this.flexVal=1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Flexible(
                                          child: TextFormField(
                                            controller:
                                                controller,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.inter(
                                                color: AppColors.colorTextInput,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                            cursorColor:
                                                AppColors.colorTextInput,
                                            keyboardType:
                                                TextInputType.datetime,
                                            decoration: InputDecoration(
                                              errorStyle: TextStyle(
                                                  color: AppColors.red),
                                              filled: true,
                                              fillColor: AppColors.background2,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  borderSide: BorderSide.none),
                                              hintText:
                                                  hint,
                                              hintStyle: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .birthday;
                                              }
                                              return null;
                                            },
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      keyboardType:
                                                          TextInputType
                                                              .datetime,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime(3000));

                                              /// check if date isn't null
                                              if (pickedDate != null) {
                                                // ignore: use_build_context_synchronously
                                                controller.text= pickedDate.toString();
                                              }
                                            },
                                          ),
                                        ),
    );
  }
}
