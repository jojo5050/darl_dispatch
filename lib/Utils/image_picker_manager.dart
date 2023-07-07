import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';

enum ProfileOptionAction {
  viewImage,
  library,
  videoLibrary,
  remove,
}

class ImagePickerManager {

  File? file;

  BuildContext? context;

  bool loading = false;

  Future<void> pickImage({@required BuildContext? context,
    Function(File file)? file}) async {

    ProfileOptionAction? action;

    if (Platform.isAndroid) {
      action = await showModalBottomSheet(
          context: context!,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          builder: (context) => BottomSheet(
              onClosing: () {},
              builder: (context) => Wrap(
                children: <Widget>[
                  ListTile(
                      title: const Center(
                        child: Text(
                          'Pick Image',
                          style: TextStyle(),
                        ),
                      ),
                      onTap: () => Navigator.pop(
                          context, ProfileOptionAction.library)),
                  InkWell(
                    onTap: () => Navigator.pop(
                        context, ProfileOptionAction.remove),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12.0),
                      color: Colors.grey[200],
                      child: const Center(
                        child: Text('Cancel'),
                      ),
                    ),
                  ),
                ],
              )));
    }else if(Platform.isIOS){
      action = await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context!,
          builder: (context) => CupertinoActionSheet(
              actions: <Widget>[
                CupertinoButton(
                    child: const Text('Pick from library'),
                    onPressed: () => Navigator.pop(
                        context, ProfileOptionAction.library)),
              ],
              cancelButton: CupertinoButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context))));
    }
    if (action == null) return;
    final getFile = await handleProfileAction(context!, action: action);
    file!(getFile!);
  }

  Future<File?>? handleProfileAction(BuildContext context, {required ProfileOptionAction? action}) {
    switch (action!) {
      case ProfileOptionAction.viewImage:
      case ProfileOptionAction.library:
        return _getImage(context, ImageSource.gallery);
      case ProfileOptionAction.remove:
        break;
      case ProfileOptionAction.videoLibrary:
        // TODO: Handle this case.
        break;
    }
    return null;

  }

  Future<File?> _getImage( BuildContext context, ImageSource source) async {
    try {
      final pickedFile = await ImagePicker.platform.pickImage(source: source);
      if (pickedFile != null) {
        print("line before croping");
        return await _cropImage(context, pickedFile);

      }
      print("line after croping");
    } catch (e) {
      debugPrint('Error: $e');
    }
    return null;

  }

  _cropImage(BuildContext context, PickedFile imageFile) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [CropAspectRatioPreset.square]
            : [CropAspectRatioPreset.square],
        androidUiSettings:  const AndroidUiSettings(
            toolbarTitle: 'Clip',
            toolbarColor: Colors.black38,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings:  IOSUiSettings(
          title: 'Clip',
        )
    );

    return croppedFile;

  }

}