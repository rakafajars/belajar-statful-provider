import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_2/service/image_service.dart';
import 'package:flutter_application_2/widget/button_custome.dart';
import 'package:flutter_application_2/widget/text_field_custome.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiceBearScreen extends StatefulWidget {
  const DiceBearScreen({super.key});

  @override
  State<DiceBearScreen> createState() => _DiceBearScreenState();
}

class _DiceBearScreenState extends State<DiceBearScreen> {
  TextEditingController _nameController = TextEditingController();

  String image = "";

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Image'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image.isNotEmpty
                ? SvgPicture.string(
                    image,
                    height: 100,
                    width: 100,
                  )
                : const Text("Image Belum Generate"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFieldCustome(
                controller: _nameController,
                isValidTextField: true,
                errorMessage: '',
                hintText: 'Cari Image',
              ),
            ),
            ButtonCustome(
              onPressed: () async {
                image = await ImageService().generateImage(
                  _nameController.text,
                );

                debugPrint("halo $image");

                setState(() {});
              },
              title: 'Generate Gambar',
            ),
          ],
        ),
      ),
    );
  }
}
