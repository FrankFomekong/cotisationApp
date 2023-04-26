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
import 'package:gpt/models/client_model.dart';

import 'dart:convert';
import 'package:gpt/components/button_component.dart';

import 'package:image_picker/image_picker.dart';

class PhotoScreen extends StatefulWidget {
  final UserModel userModel;

  const PhotoScreen({super.key, required this.userModel});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
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

  final formKeyCotisation = GlobalKey<FormState>();
  var enable = true;
  final numCompteClientController = TextEditingController();
  final nomClientController = TextEditingController();
  final montantClientController = TextEditingController();
  final numeroClientController = TextEditingController();
  final confirmMontantClientController = TextEditingController();
  final userCodeController = TextEditingController();

  // form key for search client
  final formKeyCompte = GlobalKey<FormState>();
  final telephoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    clearFields() {
      telephoneController.clear();
    }

    clearFieldsSimple() {
      numCompteClientController.clear();
      nomClientController.clear();
      numeroClientController.clear();
      userCodeController.clear();
    }

    fillFields({required ClientModel clientModel}) {
      numCompteClientController.text = clientModel.numCompte.toString();
      nomClientController.text = clientModel.nom.toString();
      numeroClientController.text = clientModel.mobile;

      print(numCompteClientController.text);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: TypoText(
                text: AppLocalizations.of(context)!.photoclient,
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
                child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                
                children: [
                Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKeyCompte,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TypoText(
                          text: AppLocalizations.of(context)!.acc_more,
                          color: AppColors.colorTextInput)
                      .long(),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: telephoneController,
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
                            hintText: AppLocalizations.of(context)!.phone,
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
                      ),
                      const SizedBox(width: 12.0),
                      // ignore: deprecated_member_use
                      ButtonComponent(
                        onPressed: () {
                          if (formKeyCompte.currentState!.validate()) {}
                        },
                        color: AppColors.backgroundButton,
                        // ignore: deprecated_member_use
                        child: const Icon(Icons.search),
                      ),
                      const SizedBox(width: 12.0),
                      // ignore: deprecated_member_use
                      ButtonComponent(
                        onPressed: () {
                          clearFields();
                          clearFieldsSimple();
                        },
                        color: AppColors.backgroundButton,
                        // ignore: deprecated_member_use
                        child: const Icon(Icons.refresh),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Form(
              key: formKeyCotisation,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    Flexible(
                      flex: 4,
                      child: TextFormField(
                        readOnly: true,
                        controller: nomClientController,
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
                    ),
                    const SizedBox(width: 12.0),
                    Flexible(
                      flex: 2,
                      child: TextFormField(
                        controller: userCodeController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: GoogleFonts.inter(
                            color: AppColors.colorTextInput,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                        cursorColor: AppColors.colorTextInput,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: AppColors.red),
                          filled: true,
                          fillColor: AppColors.background2,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                              borderSide: BorderSide.none),
                          hintText: 'code',
                          hintStyle: GoogleFonts.inter(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.empty_input;
                          }
                          /*else if(value.compareTo(userModel.code.toString())==0){
                                      attemps=attemps-1;
                                      if(attemps>0){
                                      return AppLocalizations.of(context)!
                                          .attemps +' '+ attemps.toString();
                                          }
                                          else{
                                            
                                          }    
                                    }*/
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 4.0),
                  ]),
                  const SizedBox(height: 16.0),
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
                  const SizedBox(height: 16.0),
                  
                  ButtonComponent(
                    onPressed: enable
                        ? () async {
                            //*****
                            enable = false;
                            var code2 = userCodeController.text.trim();
                            enable = true;
                          }
                        : null,
                    color: AppColors.backgroundButton,
                    child: TypoText(
                            text: true
                                ? AppLocalizations.of(context)!.loading
                                : AppLocalizations.of(context)!.validate,
                            color: AppColors.colorTextWhite)
                        .h2(),
                  )
                ],
              ),
            ),
              ])) ,
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
