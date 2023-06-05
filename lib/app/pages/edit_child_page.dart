import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parental_control/common_widgets/show_alert_dialog.dart';
import 'package:parental_control/common_widgets/show_exeption_alert.dart';
import 'package:parental_control/models/child_model.dart';
import 'package:parental_control/services/database.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

enum AppState { loading, complete }

class EditChildPage extends StatefulWidget {
  final Database? database;
  final ChildModel? model;

  const EditChildPage({Key? key, required this.database, this.model})
      : assert(database != null),
        super(key: key);

  /// The [context]  here is the context pf the JobsPage
  ///
  /// as the result we can get the provider of Database
  static Future<void> show(
    BuildContext context, {
    Database? database,
    ChildModel? model,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditChildPage(database: database, model: model),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditChildPageState createState() => _EditChildPageState();
}

class _EditChildPageState extends State<EditChildPage> {
  final _formkey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String? _name;
  String? _email;
  String? _imageURL;
  late String id;
  XFile? _imageFile;
  var uuid = Uuid();
  AppState appState = AppState.complete;
  bool isSavedPressed = false;

  @override
  void initState() {
    if (widget.model != null) {
      _name = widget.model!.name;
      _email = widget.model!.email;
      _imageURL = widget.model!.image!;
    }

    super.initState();
  }

  bool _validateAndSaveForm() {
    final form = _formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _getLocalImage() async {
    var imageFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 200,
    );
    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Future<dynamic> _submit(XFile localFile) async {
    id = uuid.v4().substring(0, 8).toUpperCase();
    try {
      var fileExtension = path.extension(localFile.path);
      debugPrint(fileExtension);
      //final _id = widget.model?.id ?? id;
      //var id = documentIdFromCurrentDate();
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('Child/"${id}"/$id$fileExtension');

      await firebaseStorageRef
          .putFile(File(localFile.path))
          //.onComplete
          .catchError((onError) {
        debugPrint(onError);
        // ignore: return_of_invalid_type_from_catch_error
        return false;
      });
      var url = await firebaseStorageRef.getDownloadURL();
      _imageURL = url;
      debugPrint('download url: $url');
    } catch (e) {
      debugPrint('...skipping image upload with error ${e.toString()}');
    }

    if (_validateAndSaveForm()) {
      setState(() {
        appState = AppState.loading;
      });
      try {
        /// this section makes sure the name entered does not already exist
        /// in the stream
        /// Stream.first is a getter that get the most up-to-date value

        final children = await widget.database!.childrenStream().first;
        final allNames = children.map((child) => child.name).toList();
        if (widget.model != null) {
          allNames.remove(widget.model!.name);
        }
        if (allNames.contains(_name)) {
          await showAlertDialog(
            context,
            title: ' Name already used',
            content: 'Please choose a different job name',
            defaultActionText: 'OK',
          );
        } else {
          final child = ChildModel(
            id: id,
            name: _name ?? 'No name',
            email: _email ?? 'No email',
            image: _imageURL,
          );

          await widget.database!.setChild(child).whenComplete(
                () => setState(() {
                  debugPrint('form Saved : $_name and email : $_email');
                  appState = AppState.complete;
                  Navigator.of(context).pop();
                }),
              );
        }
      } on FirebaseException catch (e) {
        await showExceptionAlertDialog(
          context,
          title: 'Operation failed',
          exception: e,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.model == null ? 'New Child' : 'Edit Child'),
        centerTitle: true,
        actions: [
          OutlinedButton(
            onPressed: () => _submit(_imageFile!),
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          )
        ],
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return !isSavedPressed
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildForm(),
                ),
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  Widget _buildForm() {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 8),
            appState == AppState.complete
                ? _showImage()
                : Container(
                    height: 90,
                    color: Colors.black.withOpacity(0.14),
                    child: Center(child: CircularProgressIndicator()),
                  ),
            ButtonTheme(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () => _getLocalImage(),
                child: Text(
                  'add picture',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'child name'),
        initialValue: _name,
        validator: (value) => value!.isNotEmpty ? null : "Name can't be empty",
        onSaved: (value) => _name = value!,
        enabled: appState == AppState.complete ? true : false,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'email'),
        initialValue: _email,
        validator: (value) => value!.isNotEmpty ? null : "email can't be empty",
        onSaved: (value) => _email = value!,
        enabled: appState == AppState.complete ? true : false,
      ),
    ];
  }

  Widget _showImage() {
    if (_imageFile == null && _imageURL == null) {
      return Icon(
        Icons.person,
        size: 90,
        color: Colors.grey[500],
      );
    } else if (_imageFile != null) {
      debugPrint('showing image from local file');
      return InkWell(
        onTap: _getLocalImage,
        child: Image.file(
          File(_imageFile!.path),
          fit: BoxFit.contain,
        ),
      );
    }
    return Icon(
      Icons.person,
      size: 90,
      color: Colors.grey[500],
    );
  }
}
