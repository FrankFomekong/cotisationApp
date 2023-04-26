import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/input_component.dart';
import '../models/user_model.dart';
import '../utils/app_colors.dart';
import '../utils/typography.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:gpt/utils/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gpt/models/client_model2.dart';

import 'package:gpt/components/button_component.dart';
//send data
import 'dart:convert';

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
  var enable = true;
  var attemps = 3;
  // controllers client
  final numComptecontroller = TextEditingController();
  final numComptecontroller2 = TextEditingController();
  final birthController = TextEditingController();
  final genderController = TextEditingController();
  final languageController = TextEditingController();

  // controllers document
  final nomController = TextEditingController();
  final professionController = TextEditingController();
  final codeController = TextEditingController();

  final lieuNaissController = TextEditingController();
  final telephoneController = TextEditingController();

  final dateDelivranceController = TextEditingController();
  String _selectedOption = 'F';
  String _selectedOption2 = 'Fr';

  @override
  Widget build(BuildContext context) {
    clearFields() {
      telephoneController.clear();
      lieuNaissController.clear();
      numComptecontroller.clear();
      numComptecontroller2.clear();
      birthController.clear();
      codeController.clear();
      nomController.clear();
    }

    clearFieldsSimple() {
      numComptecontroller.clear();
      nomController.clear();
    }
    _showInformations2() async {
      var msg=AppLocalizations.of(context)!
                                          .attemps +' '+ attemps.toString();
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: TypoText(
                      text: AppLocalizations.of(context)!.information,
                      color: AppColors.colorTextInput)
                  .h2(),
              backgroundColor: AppColors.background,
              surfaceTintColor: AppColors.background,
              content: SingleChildScrollView(
                
                child:ListBody(
                  children:  <Widget> [
                    Text(msg),
                  ],
                ) 

              ),
              actions:<Widget> [
                TextButton(onPressed: ()=>{
                  Navigator.of(context).pop()
                }, 
                child: const Text("OK"))
              ], 
            );
          });
          
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: TypoText(
                text: AppLocalizations.of(context)!.client,
                color: AppColors.colorTextInput)
            .large(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          //shrinkWrap: true,

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                  height: 5,
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColors.red)),
            ),
            const SizedBox(height: 16.0),
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: formKeyClient,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TypoText(
                                      text: AppLocalizations.of(context)!
                                          .info_client,
                                      color: AppColors.colorTextInput)
                                  .long(),
                              const SizedBox(height: 20.0),
                              CustomInput(
                                hint: AppLocalizations.of(context)!.phone,
                                controller: numComptecontroller,
                              ),
                              CustomInput(
                                hint: AppLocalizations.of(context)!.phone,
                                controller: numComptecontroller2,
                              ),
                              CustomInput(
                                hint: AppLocalizations.of(context)!.name,
                                controller: nomController,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: CustomInput(
                                      hint: AppLocalizations.of(context)!
                                          .lieu_naissance,
                                      controller: lieuNaissController,
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Flexible(
                                    flex: 1,
                                    child: DropdownButtonFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text('Feminin'),
                                          value: 'F',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Masculin'),
                                          value: 'M',
                                        ),
                                      ],
                                      style: GoogleFonts.inter(
                                          color: AppColors.colorTextInput,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: AppColors.red),
                                        filled: true,
                                        fillColor: AppColors.background2,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            borderSide: BorderSide.none),
                                        hintText:
                                            AppLocalizations.of(context)!.genre,
                                        hintStyle: GoogleFonts.inter(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      value: _selectedOption,
                                      onChanged: (value) => {
                                        setState(() {
                                          _selectedOption = value.toString();
                                        })
                                      },
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
                              CustomDateInput(
                                hint: AppLocalizations.of(context)!.birthday,
                                controller: birthController,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: DropdownButtonFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      items: [
                                        DropdownMenuItem(
                                          child: Text('Francais'),
                                          value: 'Fr',
                                        ),
                                        DropdownMenuItem(
                                          child: Text('Anglais'),
                                          value: 'An',
                                        ),
                                      ],
                                      style: GoogleFonts.inter(
                                          color: AppColors.colorTextInput,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: AppColors.red),
                                        filled: true,
                                        fillColor: AppColors.background2,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0),
                                            borderSide: BorderSide.none),
                                        hintText:
                                            AppLocalizations.of(context)!.genre,
                                        hintStyle: GoogleFonts.inter(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      value: _selectedOption2,
                                      onChanged: (value) => {
                                        setState(() {
                                          _selectedOption2 = value.toString();
                                        })
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .empty_input;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Flexible(
                                      flex: 1,
                                      child: CustomInput(
                                        hint:
                                            AppLocalizations.of(context)!.code,
                                        controller: codeController,
                                      )),
                                ],
                              ),
                              const SizedBox(width: 16.0),
                              ButtonComponent(
                                onPressed: enable
                                    ? () async {
                                        //*****
                                        var instance = await SharedPreferences
                                              .getInstance();
                                        var codeUser = instance.getString("code_user");
                                        print(codeUser);
                                        var code = codeController.text.toString();
                                        if (code != codeUser){
                                          attemps= attemps-1;
                                          _showInformations2();
                                          codeController.clear();
                                          return ;
                                        }
                                        else{
                                          attemps= 3 ;
                                          if (formKeyClient.currentState!
                                            .validate()) {
                                          setState(() {
                                            enable = !enable;
                                          });
                                          formKeyClient.currentState?.save();
                                          var idZone = instance.getInt("id_zone");
                                          var idUser = instance.getInt("id_user");
                                          var idAgence = instance.getInt("id_agence");
                                          print('====sharedP read ========');
                                          print(idZone);
                                          print(idUser);
                                          print(idAgence);

                                          final uri = Uri(
                                              scheme: Constants.scheme,
                                              host:
                                                  instance.getString("server"),
                                              path: "/api/pages/addClient.php");
  
                                            Object body = json.encode({
                                            "nom": nomController.text,
                                            "sexe": _selectedOption,
                                            "dateNaissance":
                                                birthController.text,
                                            "mobile":
                                                numComptecontroller.text.trim(),
                                            "lieuNaissance":
                                                lieuNaissController.text.trim(),
                                            "idAgence": idAgence,
                                            "idUser": idUser,
                                            "idZone": idZone,
                                            "langue": _selectedOption2,
                                          });

                                          Response response =
                                              await post(uri, body: body);
                                          if (response.statusCode == 200) {
                                            print('ok');
                                            clearFields();
                                            setState(() {
                                              enable = !enable;
                                            });
                                          } else {
                                            // return false;
                                          }
                                        }
                                        }
                                        
                                      }
                                    : null,
                                color: AppColors.backgroundButton,
                                child: TypoText(
                                        text: enable
                                            ? AppLocalizations.of(context)!
                                                .validate
                                            : AppLocalizations.of(context)!
                                                .loading,
                                        color: AppColors.colorTextWhite)
                                    .h2(),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ])),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          height: 5,
          width: double.infinity,
          decoration: BoxDecoration(color: AppColors.red),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {}
}
