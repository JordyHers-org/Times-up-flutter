// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages, lines_longer_than_80_chars, tighten_type_of_initializing_formals

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/common_widgets/show_alert_dialog.dart';
import 'package:times_up_flutter/common_widgets/show_exeption_alert.dart';
import 'package:times_up_flutter/common_widgets/show_logger.dart';
import 'package:times_up_flutter/models/child_model/child_model.dart';
import 'package:times_up_flutter/services/database.dart';
import 'package:uuid/uuid.dart';

enum AppState { loading, complete }

class EditChildPage extends StatefulWidget {
  const EditChildPage({required this.database, Key? key, this.model})
      : assert(database != null, 'Database should be initialized first !'),
        super(key: key);
  final Database? database;
  final ChildModel? model;

  static Future<void> show(
    BuildContext context, {
    Database? database,
    ChildModel? model,
  }) async {
    await Navigator.of(context).push(
      MaterialPageRoute<EditChildPage>(
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
  Uuid uuid = const Uuid();
  AppState appState = AppState.complete;
  bool isSavedPressed = false;

  @override
  void initState() {
    if (widget.model != null) {
      _name = widget.model!.name;
      _email = widget.model!.email;
      _imageURL = widget.model!.image;
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
    final imageFile = await _picker.pickImage(
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

  Future<void> _submit(XFile? localFile) async {
    if (appState == AppState.loading) return;
    if (_validateAndSaveForm()) {
      if (localFile == null) return;
      setState(() {
        appState = AppState.loading;
      });

      id = uuid.v4().substring(0, 8).toUpperCase();
      try {
        final fileExtension = path.extension(localFile.path);
        JHLogger.$.d(fileExtension);

        final firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('Child/"$id"/$id$fileExtension');

        await firebaseStorageRef
            .putFile(File(localFile.path))
            .catchError((Function onError) {
          JHLogger.$.e(onError);
          // ignore: return_of_invalid_type_from_catch_error
          return false;
        });
        final url = await firebaseStorageRef.getDownloadURL();
        _imageURL = url;
        JHLogger.$.d('download url: $url');
      } catch (e) {
        JHLogger.$.d('...skipping image upload');
      }

      try {
        final children = await widget.database!.childrenStream().first;
        final allNames = children.map((child) => child.name).toList();
        if (widget.model != null) {
          allNames.remove(widget.model!.name);
        }
        if (allNames.contains(_name)) {
          if (mounted) {
            await showAlertDialog(
              context,
              title: ' Name already used',
              content: 'Please choose a different job name',
              defaultActionText: 'OK',
            );
          }
        } else {
          final child = ChildModel(
            id: id,
            name: _name ?? 'No name',
            email: _email ?? 'No email',
            image: _imageURL,
          );
          await widget.database!.setChild(child).whenComplete(
                () => setState(() {
                  JHLogger.$.d('form Saved : $_name and email : $_email');
                  appState = AppState.complete;
                  Navigator.of(context).pop();
                }),
              );
        }
      } on FirebaseException catch (e) {
        if (mounted) {
          await showExceptionAlertDialog(
            context,
            title: 'Operation failed',
            exception: e,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      appBar: AppBar(
        elevation: 2,
        title: JHDisplayText(
          text: widget.model == null ? 'New Child' : 'Edit Child',
          style: const TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async => _submit(_imageFile),
            child: const Align(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: JHDisplayText(
                  text: 'Save',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: _buildContents(),
    );
  }

  Widget _buildContents() {
    return !isSavedPressed
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildForm(),
                ),
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator());
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
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: 8),
            if (appState == AppState.complete)
              _showImage()
            else
              Container(
                height: 90,
                color: Colors.black.withOpacity(0.14),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ButtonTheme(
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: _getLocalImage,
                child: const JHDisplayText(
                  text: 'Add picture',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Child name'),
        initialValue: _name,
        validator: (value) => value!.isNotEmpty ? null : "Name can't be empty",
        onSaved: (value) => _name = value,
        enabled: appState == AppState.complete || false,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Email'),
        initialValue: _email,
        validator: (value) => value!.isNotEmpty ? null : "Email can't be empty",
        enabled: appState == AppState.complete || false,
        onSaved: (value) => _email = value,
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
      JHLogger.$.d('showing image from local file');
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
