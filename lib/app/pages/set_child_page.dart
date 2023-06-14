import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parental_control/app/pages/child_page.dart';
import 'package:parental_control/common_widgets/form_submit_button.dart';
import 'package:parental_control/common_widgets/show_alert_dialog.dart';
import 'package:parental_control/models/set_child_model.dart';
import 'package:parental_control/services/database.dart';
import 'package:parental_control/services/geo_locator_service.dart';
import 'package:provider/provider.dart';
import 'package:parental_control/common_widgets/show_logger.dart';

enum AppState { loading, complete }

class SetChildPage extends StatefulWidget {
  static Widget create(BuildContext context) {
    return SetChildPage();
  }

  @override
  _SetChildPageState createState() => _SetChildPageState();
}

class _SetChildPageState extends State<SetChildPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _key = TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _keyFocusNode = FocusNode();
  GeoLocatorService geo = GeoLocatorService();
  var appState = AppState.complete;

  ///void Dispose Method
  @override
  void dispose() {
    _nameController.dispose();
    _key.dispose();

    _nameFocusNode.dispose();
    _keyFocusNode.dispose();
    super.dispose();
  }

  void _submit(String name, String key) async {
    final position = await geo.getInitialLocation();
    Logging.logger.d(
        'Method latitude :${position.latitude} , Longitude : ${position.longitude}');
    final database = Provider.of<Database>(context, listen: false);
    try {
      final response = await database.getUserCurrentChild(
          name, key, GeoPoint(position.latitude, position.longitude));
      Logging.logger.d('RESPONSE : ${response}');
      if (response != null) {
        await Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (context) => ChildPage.create(context, database, response),
          ),
        );
      } catch (e) {
        setState(() {
          appState = AppState.complete;
        });
        await showAlertDialog(context,
            title: 'No Such file in Database',
            content: 'ERROR OCCURED COULD NOT MOVE TO THE NEXT PAGE',
            defaultActionText: 'OK');
        Logging.logger.e('ERROR OCCURED COULD NOT MOVE TO THE NEXT PAGE');
      }
    } catch (e) {
      Logging.logger.e(e.toString());
    }
  }

  List<Widget> _buildChildren(BuildContext context, {SetChildModel? model}) {
    return [
      TextField(
        enabled: appState == AppState.loading ? false : true,
        focusNode: _nameFocusNode,
        controller: _nameController,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          if (model?.nameValidator.isValid(model.name) == true) {
            FocusScope.of(context).requestFocus(_keyFocusNode);
          }
        },
        decoration: InputDecoration(
          labelText: 'Name',
        ),
      ),
      TextField(
        enabled: appState == AppState.loading ? false : true,
        focusNode: _keyFocusNode,
        controller: _key,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: 'Unique Key',
        ),
      ),
      SizedBox(height: 8.0),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: appState == AppState.complete ? 'Submit' : 'Loading ...',
        onPressed: () {
          setState(() {
            appState = AppState.loading;
          });
          _submit(_nameController.text, _key.text);
        },
      ),
      SizedBox(height: 8.0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Set up Child '),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: _buildChildren(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
