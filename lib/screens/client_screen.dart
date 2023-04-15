import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../components/input_component.dart';
import '../models/user_model.dart';
import '../utils/app_colors.dart';
import '../utils/typography.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:gpt/components/button_component.dart';

import 'package:image_picker/image_picker.dart';

class ClientScreen extends StatefulWidget {
  final UserModel userModel;

  const ClientScreen({super.key, required this.userModel});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  int currentStep = 0;
  // controllers client
  final numComptecontroller = TextEditingController();
  final numComptecontroller2 = TextEditingController();
  final birthController = TextEditingController();
  final genderController = TextEditingController();
  final languageController = TextEditingController();

  // controllers document
  final nomController = TextEditingController();
  final professionController = TextEditingController();
  final cniController = TextEditingController();
  final cniController2 = TextEditingController();

  final lieuDelivranceController = TextEditingController();
  final lieuNaissController = TextEditingController();

  final dateDelivranceController = TextEditingController();
  String _selectedOption = 'F';
  String _selectedOption2 = 'Fr';
  late File _image;
  late File _image2;
  late File _image3;
  String path1 = "";
  String path2 = "";
  String path3 = "";

  final _picker = ImagePicker();
  final formKeyClient = GlobalKey<FormState>();


  Future<void> _takePicture() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 10,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image.readAsBytesSync().lengthInBytes / (1024));
        /*showDialog(context: context, 
        builder:(BuildContext context) => AlertDialog(
          title: Text('Img'),
          content: Image.file(_image),
        )
        );*/
        path1 = _image.path;
        //_cropImage(path1);
      }
    });
  }

  Future<void> _takePicture2() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 10);

    setState(() {
      if (pickedFile != null) {
        _image2 = File(pickedFile.path);
        path2 = _image2.path;
        //_cropImage(path2);

        //print(_image2.length().toString());
      }
    });
  }

  Future<void> _takePicture3() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 10);

    setState(() {
      if (pickedFile != null) {
        _image3 = File(pickedFile.path);
        path3 = _image3.path;
        //_cropImage(path3);
      }
    });
  }

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

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text(AppLocalizations.of(context)!.step + ' 1'),
        content: 
        Form(
          key:formKeyClient,
          child: 
          SingleChildScrollView(
            child:           Column(
          children: [
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
            CustomInput(
              hint: AppLocalizations.of(context)!.lieu_naissance,
              controller: lieuNaissController,
            ),
            CustomDateInput(
              hint: AppLocalizations.of(context)!.birthday,
              controller: birthController,
            ),
            CustomInput(
              hint: AppLocalizations.of(context)!.cni,
              controller: cniController,
            ),
            CustomInput(
              hint: AppLocalizations.of(context)!.cni,
              controller: cniController2,
            ),
            CustomDateInput(
              hint: AppLocalizations.of(context)!.date2,
              controller: dateDelivranceController,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    items: [
                      DropdownMenuItem(
                        child: Text('F'),
                        value: 'F',
                      ),
                      DropdownMenuItem(
                        child: Text('M'),
                        value: 'M',
                      ),
                    ],
                    style: GoogleFonts.inter(
                        color: AppColors.colorTextInput,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: AppColors.red),
                      filled: true,
                      fillColor: AppColors.background2,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none),
                      hintText: AppLocalizations.of(context)!.genre,
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
                        return AppLocalizations.of(context)!.empty_input;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Flexible(
                  flex: 1,
                  child: DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    items: [
                      DropdownMenuItem(
                        child: Text('Fr'),
                        value: 'Fr',
                      ),
                      DropdownMenuItem(
                        child: Text('An'),
                        value: 'An',
                      ),
                    ],
                    style: GoogleFonts.inter(
                        color: AppColors.colorTextInput,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: AppColors.red),
                      filled: true,
                      fillColor: AppColors.background2,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide.none),
                      hintText: AppLocalizations.of(context)!.genre,
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
                        return AppLocalizations.of(context)!.empty_input;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
          )
),
        
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text(AppLocalizations.of(context)!.step + ' 2'),
        content: SingleChildScrollView(child:Column(
          children: [
            Container(
                child: path1 == ""
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ButtonComponent(
                              color: AppColors.backgroundButton,
                              onPressed: () async {
                                await _takePicture();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.photocni,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ),
                      )),
                                    const SizedBox(height: 16.0),

            Container(
                child: path2 == ""
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ButtonComponent(
                              color: AppColors.backgroundButton,
                              onPressed: () async {
                                await _takePicture2();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.photocni2,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Image.file(
                          _image2,
                          fit: BoxFit.cover,
                        ),
                      )),
                                    const SizedBox(height: 16.0),

            Container(
                child: path3 == ""
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ButtonComponent(
                              color: AppColors.backgroundButton,
                              onPressed: () async {
                                await _takePicture3();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.photoclient,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Image.file(
                          _image3,
                          fit: BoxFit.cover,
                        ),
                      )),
          ],
        ),)
        
      ),
    ];
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
      body: Padding(
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
            Expanded(
                child: Stepper(
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepCancel: () => currentStep == 0
                  ? null
                  : setState(() {
                      currentStep -= 1;
                    }),
              onStepContinue: () {
                bool isLastStep = (currentStep == getSteps().length - 1);
                if (isLastStep) {
                  //Do something with this information
                  
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepTapped: (step) => setState(() {
                currentStep = step;
              }),
              steps: getSteps(),
            ))
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

  Future<void> _submitForm() async {
    if (formKeyClient.currentState!.validate()) {
      formKeyClient.currentState!.save();

      final url = 'https://example.com/upload';

      final bytes = await _image.readAsBytes();
      print('end================');
      /*final formData = FormData.fromMap({
        'name':1,
        'image': await MultipartFile.fromBytes(bytes),
      });

      final response = await http.post(
        Uri.parse(url),
        body: formData,
      );

      if (response.statusCode == 200) {
        // Success!
      } else {
        // Handle error
      }*/
    }
  }
  
}
