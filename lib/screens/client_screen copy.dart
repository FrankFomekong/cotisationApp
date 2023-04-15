import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gpt/components/button_component.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt/models/user_model.dart';
import 'package:gpt/utils/custom_date.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/recherche/recherche_bloc.dart';

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

  // configuration stepper
  int currentStep = 0;

  late File _image;
  late File _image2;
  late File _image3;
  String path1 = "";
  String path2 = "";
  String path3 = "";

  final _picker = ImagePicker();

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

  // Crop Image
  /*_cropImage(filePath)  {
    ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    ).then((value) => print('===========ok'))
    .catchError((e)=>print(e));
  }*/

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
    return BlocProvider(
        create: (context) => RechercheBloc()..add(RechercheInitialEvent()),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.background,
              title: TypoText(
                      text: AppLocalizations.of(context)!.client,
                      color: AppColors.colorTextInput)
                  .large(),
            ),
            body: BlocConsumer<RechercheBloc, RechercheState>(
                listener: (context, state) {
              if (state is RechercheInitial) {
                //clearFields();
              }

              if (state is RechercheSelectFirstDateState) {
                birthController.text = CustomDate.custom(state.date);
              }

              if (state is RechercheSelectSecondDateState) {
                dateDelivranceController.text = CustomDate.custom(state.date);
              }
            }, builder: (context, state) {
              return Container(
                padding: EdgeInsets.zero, // Add this line
                child: Stepper(
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
                                    Row(
                                      children: [
                                        Flexible(
                                          child: TextFormField(
                                            controller: numComptecontroller,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.inter(
                                                color: AppColors.colorTextInput,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                            cursorColor:
                                                AppColors.colorTextInput,
                                            keyboardType: TextInputType.text,
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
                                                  AppLocalizations.of(context)!
                                                      .phone,
                                              hintStyle: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .empty_input;
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Flexible(
                                          child: TextFormField(
                                            controller: numComptecontroller2,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.inter(
                                                color: AppColors.colorTextInput,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                            cursorColor:
                                                AppColors.colorTextInput,
                                            keyboardType: TextInputType.text,
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
                                                  AppLocalizations.of(context)!
                                                      .phone,
                                              hintStyle: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .empty_input;
                                              } else if (numComptecontroller
                                                      .text !=
                                                  numComptecontroller.text) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .check_account;
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16.0),
                                    TextFormField(
                                      controller: nomController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: GoogleFonts.inter(
                                          color: AppColors.colorTextInput,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      cursorColor: AppColors.colorTextInput,
                                      keyboardType: TextInputType.text,
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
                                    const SizedBox(height: 16.0),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: TextFormField(
                                            controller: lieuNaissController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.inter(
                                                color: AppColors.colorTextInput,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                            cursorColor:
                                                AppColors.colorTextInput,
                                            keyboardType: TextInputType.text,
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
                                                  AppLocalizations.of(context)!
                                                      .lieu_naissance,
                                              hintStyle: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .empty_input;
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Flexible(
                                          flex: 1,
                                          child: DropdownButtonFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
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
                                                  AppLocalizations.of(context)!
                                                      .genre,
                                              hintStyle: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            value: _selectedOption,
                                            onChanged: (value) => {
                                              setState(() {
                                                _selectedOption =
                                                    value.toString();
                                              })
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .empty_input;
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16.0),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          child: TextFormField(
                                            controller: birthController,
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
                                                  AppLocalizations.of(context)!
                                                      .birthday,
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
                                                BlocProvider.of<RechercheBloc>(
                                                        context)
                                                    .add(
                                                        RechercheSelectFirstDateEvent(
                                                            date: pickedDate));
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Flexible(
                                          flex: 1,
                                          child: DropdownButtonFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
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
                                                  AppLocalizations.of(context)!
                                                      .genre,
                                              hintStyle: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            value: _selectedOption2,
                                            onChanged: (value) => {
                                              setState(() {
                                                _selectedOption2 =
                                                    value.toString();
                                              })
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
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
                                      controller: cniController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: GoogleFonts.inter(
                                          color: AppColors.colorTextInput,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      cursorColor: AppColors.colorTextInput,
                                      keyboardType: TextInputType.text,
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
                                            AppLocalizations.of(context)!.cni,
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
                                    const SizedBox(width: 16.0),
                                    const SizedBox(width: 16.0),
                                    TextFormField(
                                      controller: cniController2,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: GoogleFonts.inter(
                                          color: AppColors.colorTextInput,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                      cursorColor: AppColors.colorTextInput,
                                      keyboardType: TextInputType.text,
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
                                            AppLocalizations.of(context)!.cni,
                                        hintStyle: GoogleFonts.inter(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .empty_input;
                                        } else if (cniController.text !=
                                            cniController2.text) {
                                          return AppLocalizations.of(context)!
                                              .check_account;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16.0),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: TextFormField(
                                            controller:
                                                dateDelivranceController,
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
                                                  AppLocalizations.of(context)!
                                                      .date2,
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
                                                BlocProvider.of<RechercheBloc>(
                                                        context)
                                                    .add(
                                                        RechercheSelectSecondDateEvent(
                                                            date: pickedDate));
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 16.0),
                                        Flexible(
                                          child: TextFormField(
                                            controller:
                                                lieuDelivranceController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            style: GoogleFonts.inter(
                                                color: AppColors.colorTextInput,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                            cursorColor:
                                                AppColors.colorTextInput,
                                            keyboardType: TextInputType.text,
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
                                                  AppLocalizations.of(context)!
                                                      .lieu,
                                              hintStyle: GoogleFonts.inter(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .empty_input;
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
                                text: AppLocalizations.of(context)!
                                    .info_doc_client,
                                color: AppColors.colorTextInput)
                            .longCast(),
                        content: Column(
                          children: [
                            Form(
                              key: formKeyDoc,
                              child: Column(
                                children: [
                                  Container(
                                      child: path1 == ""
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ButtonComponent(
                                                    color: AppColors
                                                        .backgroundButton,
                                                    onPressed: ()  async{
                                                      await _takePicture();
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .photocni2,
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                  const SizedBox(width: 16.0),
                                  Container(
                                      child: path2 == ""
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ButtonComponent(
                                                    color: AppColors
                                                        .backgroundButton,
                                                    onPressed: () async {
                                                      await _takePicture2();
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .photocni2,
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                                  const SizedBox(width: 16.0),
                                  Container(
                                      child: path3 == ""
                                          ? Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  ButtonComponent(
                                                    color: AppColors
                                                        .backgroundButton,
                                                    onPressed: () async{
                                                      await _takePicture3();
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .photoclient,
                                                      style: TextStyle(
                                                          color: Colors.white),
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
                              ),
                            )
                          ],
                        ),
                        isActive: currentStep >= 1)
                  ],
                ),
              );
            })));
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
