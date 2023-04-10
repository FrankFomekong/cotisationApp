import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt/components/button_component.dart';
import 'package:gpt/models/user_model.dart';

import '../utils/app_colors.dart';
import '../utils/typography.dart';


class ClientScreen extends StatefulWidget {
  final UserModel userModel;

  const ClientScreen({super.key, required this.userModel});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  // configuration forms
  final formKeyDoc = GlobalKey<FormState>();
  final formKeyClient = GlobalKey<FormState>();

  // controllers client
  final numComptecontroller = TextEditingController();


  // controllers document
  final nomController = TextEditingController();
  final professionController = TextEditingController();
  final cniController = TextEditingController();
  final dateDelivranceController = TextEditingController();

  // configuration stepper
  int currentStep = 0;

  onStepContinue() async {
    if (currentStep < 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  onStepCancel() async {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  onStepTapped(int value) async {
    setState(() {
      currentStep = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: TypoText(
                text: AppLocalizations.of(context)!.client,
                color: AppColors.colorTextInput)
            .large(),
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: currentStep,
        onStepContinue: onStepContinue,
        onStepCancel: onStepCancel,
        onStepTapped: onStepTapped,
        controlsBuilder: controlsBuilder,
        elevation: 0,
        steps: [
          Step(
              title: TypoText(
                      text: AppLocalizations.of(context)!.step + " 1",
                      color: AppColors.colorTextInput)
                  .longCast(),
              subtitle: TypoText(
                      text: AppLocalizations.of(context)!.info_client,
                      color: AppColors.colorTextInput)
                  .longCast(),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: formKeyClient,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: numComptecontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              hintText:
                                  AppLocalizations.of(context)!.acc_number,
                              hintStyle: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .empty_input;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  controller: numComptecontroller,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                    hintText:
                                        AppLocalizations.of(context)!.name, 
                                    hintStyle: GoogleFonts.inter(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .empty_input;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              Flexible(
                                child: TextFormField(
                                  controller: numComptecontroller,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                    hintText:
                                        AppLocalizations.of(context)!.genre,
                                    hintStyle: GoogleFonts.inter(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .empty_input;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: numComptecontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              hintText:
                                  AppLocalizations.of(context)!.birthday,
                              hintStyle: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .empty_input;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: numComptecontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              hintText:
                                  AppLocalizations.of(context)!.acc_number,
                              hintStyle: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .empty_input;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: numComptecontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              hintText:
                                  AppLocalizations.of(context)!.acc_number,
                              hintStyle: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .empty_input;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: numComptecontroller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              hintText:
                                  AppLocalizations.of(context)!.acc_number,
                              hintStyle: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .empty_input;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              isActive: currentStep >= 0),
          Step(
              title: TypoText(
                      text: AppLocalizations.of(context)!.step + " 2",
                      color: AppColors.colorTextInput)
                  .longCast(),
              subtitle: TypoText(
                      text: AppLocalizations.of(context)!.info_doc_client,
                      color: AppColors.colorTextInput)
                  .longCast(),
              content: Column(
                children: [
                  Form(
                    key: formKeyDoc,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nomController,
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
                            hintText: AppLocalizations.of(context)!.name,
                            hintStyle: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.empty_input;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: professionController,
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
                            hintText: AppLocalizations.of(context)!.profession,
                            hintStyle: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.empty_input;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: cniController,
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
                            hintText: AppLocalizations.of(context)!.cni,
                            hintStyle: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.empty_input;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: dateDelivranceController,
                          readOnly: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: GoogleFonts.inter(
                              color: AppColors.colorTextInput,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          cursorColor: AppColors.colorTextInput,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: AppColors.red),
                            filled: true,
                            fillColor: AppColors.background2,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: BorderSide.none),
                            hintText: AppLocalizations.of(context)!.date,
                            hintStyle: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!.empty_input;
                            }
                            return null;
                          },
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                keyboardType: TextInputType.datetime,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(3000));

                            /// check if date isn't null
                            if (pickedDate != null) {
                              // ignore: use_build_context_synchronously
                              dateDelivranceController.text =
                                  pickedDate.toString();
                            }
                          },
                        ),
                        const SizedBox(height: 16.0)
                      ],
                    ),
                  )
                ],
              ),
              isActive: currentStep >= 1)
        ],
      ),
    );
  }

  Widget controlsBuilder(BuildContext context, ControlsDetails details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonComponent(
            onPressed: details.onStepContinue,
            child: currentStep > 0
                ? TypoText(
                        text: AppLocalizations.of(context)!.validate,
                        color: AppColors.colorTextWhite)
                    .h2()
                : TypoText(
                        text: AppLocalizations.of(context)!.next,
                        color: AppColors.colorTextWhite)
                    .h2(),
            color: AppColors.backgroundButton),
        ButtonComponent(
            onPressed: details.onStepCancel,
            child: TypoText(
                    text: AppLocalizations.of(context)!.cancel,
                    color: AppColors.backgroundButton)
                .h2(),
            color: AppColors.background)
      ],
    );
  }
}
