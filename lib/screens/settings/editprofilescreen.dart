// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  int i = 0;
  final TextEditingController _firstNameController =
  TextEditingController();
  final TextEditingController _lastNameController =
  TextEditingController();
  final TextEditingController _passwordController =
  TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  @override
  void initState() {
    _firstNameController.text = AppData.user!.firstName!;
    _lastNameController.text = AppData.user!.lastName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppStyles.MAIN_COLOR,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18,
                  )),
              Text(' Back',
                textScaleFactor: 1,
                style: TextStyle(color: Colors.white, fontSize: 14),
              )
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Edit Profile',style: TextStyle(color: Colors.white),),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16),
              child: Column(
                children: [
                  Center(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        i = 1;
                        setState(() {
                          i = 1;
                        });
                        i == 1 ? showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return changeProfilePicAlertDialog(context);
                          },
                        ): const SizedBox();
                      },
                      child: imageFile == null
                          ? Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: CachedNetworkImage(
                                imageUrl: "https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png",
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url,
                                    downloadProgress) =>
                                    Image.network("https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png"),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                            const Positioned(
                                bottom: 8,
                                right: 8,
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 10,
                                    child: Icon(Icons.edit_outlined,color: Colors.black45,size: 12,))),
                          ],
                        ),
                      ): Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50), // Image border
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(50), // Image radius
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Positioned(
                              bottom: 8,
                              right: 8,
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 10,
                                  child: Icon(Icons.edit_outlined,color: Colors.black45,size: 12,))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppStyles.SECOND_COLOR
                    ),
                    height: 45,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ThemeData().colorScheme.copyWith(
                          primary: AppStyles.MAIN_COLOR,
                        ),
                      ),
                      child: TextField(
                        cursorColor: AppStyles.MAIN_COLOR,
                        autofocus: false,
                        controller: _firstNameController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),

                            // border: InputBorder.none,
                            hintText: "First Name",
                            hintStyle: const TextStyle(
                                color: Colors.brown,
                                fontSize: 14),
                            prefixIcon: const Icon(
                              Icons.person_outline,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppStyles.SECOND_COLOR
                    ),
                    height: 45,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ThemeData().colorScheme.copyWith(
                          primary: AppStyles.MAIN_COLOR,
                        ),
                      ),
                      child: TextField(
                        cursorColor: AppStyles.MAIN_COLOR,
                        autofocus: false,
                        controller: _lastNameController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            // border: InputBorder.none,
                            hintText: "Last Name",
                            hintStyle: const TextStyle(
                                color: Colors.brown,
                                fontSize: 14),
                            prefixIcon: const Icon(
                              Icons.person_outline,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppStyles.SECOND_COLOR
                    ),
                    height: 45,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ThemeData().colorScheme.copyWith(
                          primary: AppStyles.MAIN_COLOR,
                        ),
                      ),
                      child: TextField(
                        cursorColor: AppStyles.MAIN_COLOR,
                        autofocus: false,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            // border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: const TextStyle(
                                color: Colors.brown,
                                fontSize: 14),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppStyles.SECOND_COLOR
                    ),
                    height: 45,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ThemeData().colorScheme.copyWith(
                          primary: AppStyles.MAIN_COLOR,
                        ),
                      ),
                      child: TextField(
                        cursorRadius: Radius.zero,
                        cursorColor: AppStyles.MAIN_COLOR,
                        autofocus: false,
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            // border: InputBorder.none,
                            hintText:
                            "Confirm Password",
                            hintStyle: const TextStyle(
                                color: Colors.brown,
                                fontSize: 14),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                      height: 40.0,
                      width: double.maxFinite,
                      child:
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppStyles.MAIN_COLOR),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                )
                            )
                        ),
                        onPressed: () {

                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Update",style: TextStyle(
                          color: Colors.white,
                        ),
                        ),
                      )
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  changeProfilePicAlertDialog(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          elevation: 0.0,
          // title: Center(child: Text("Evaluation our APP")),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                //   width:650,
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration : const BoxDecoration(color: Color(0xffE7E7E7), borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Column(
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          i = 0;
                        });
                        _getFromCamera();
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: 650,
                        child:  Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Center(
                              child: Text(
                                "Take Picture",
                                style: TextStyle(fontFamily: 'Muller', fontStyle: FontStyle.normal, fontSize: 14, color: Theme.of(context).brightness == Brightness.dark ?  Colors.white.withOpacity(.7):const Color(0xff333333)),
                              )),
                        ),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () async {
                        setState(() {
                          i = 0;
                        });
                        _getFromGallery();
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: 650,
                        child:  Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Center(
                              child: Text(
                                "Select Picture",
                                style: TextStyle(fontFamily: 'Muller', fontStyle: FontStyle.normal, fontSize: 14, color: Theme.of(context).brightness == Brightness.dark ?  Colors.white.withOpacity(.7):const Color(0xff333333)),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => {Navigator.pop(context)},
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration:  const BoxDecoration(color: Color(0xffE7E7E7), borderRadius: BorderRadius.all(Radius.circular(65.0))),
                  child:  Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontStyle: FontStyle.normal, fontSize: 14, color: Theme.of(context).brightness == Brightness.dark ?  Colors.white.withOpacity(.7):const Color(0xff333333)),
                        ),
                      )),
                ),
              )
            ],
          )),
    );
  }

  _getFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  _getFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

}
