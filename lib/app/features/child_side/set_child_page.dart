// ignore_for_file: avoid_bool_literals_in_conditional_expressions, library_private_types_in_public_api, lines_longer_than_80_chars

import 'package:battery_plus/battery_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/app/features/child_side/child_page.dart';
import 'package:times_up_flutter/app/helpers/parsing_extension.dart';
import 'package:times_up_flutter/models/child_model/child_model.dart';
import 'package:times_up_flutter/services/app_usage_service.dart';
import 'package:times_up_flutter/services/database.dart';
import 'package:times_up_flutter/services/geo_locator_service.dart';
import 'package:times_up_flutter/widgets/jh_display_text.dart';
import 'package:times_up_flutter/widgets/jh_form_submit_button.dart';
import 'package:times_up_flutter/widgets/show_alert_dialog.dart';
import 'package:times_up_flutter/widgets/show_logger.dart';

enum AppState { loading, complete }

class SetChildPage extends StatefulWidget {
  const SetChildPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) {
    return const SetChildPage();
  }

  @override
  _SetChildPageState createState() => _SetChildPageState();
}

class _SetChildPageState extends State<SetChildPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _key = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _keyFocusNode = FocusNode();
  AppState appState = AppState.complete;

  @override
  void initState() {
    _nameController.addListener(() {
      setState(() {});
    });
    _key.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _key.dispose();
    _nameController.dispose();
    _nameFocusNode.dispose();
    _keyFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit(String name, String key, BuildContext context) async {
    final databaseStore = Provider.of<Database>(context, listen: false);
    final geo = Provider.of<GeoLocatorService>(context, listen: false);
    final appUsage = Provider.of<AppUsageService>(context, listen: false);
    final position = await geo.getInitialLocation();
    final battery = await Battery().batteryLevel;

    try {
      final response = await databaseStore.getUserCurrentChild(
        key,
        appUsage,
        GeoPoint(position.latitude, position.longitude),
        battery: battery.toString(),
      );

      try {
        if (mounted) {
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute<ChildPage>(
              fullscreenDialog: true,
              builder: (context) =>
                  ChildPage.create(context, databaseStore, response),
            ),
          );
        }
      } catch (e) {
        setState(() {
          appState = AppState.complete;
        });
        if (mounted) {
          await showAlertDialog(
            context,
            title: 'No Such file in Database',
            content: 'ERROR OCCURRED COULD NOT MOVE TO THE NEXT PAGE',
            defaultActionText: 'OK',
          );
        }
        JHLogger.$.e('ERROR OCCURRED COULD NOT MOVE TO THE NEXT PAGE');
      }
    } catch (e) {
      setState(() {
        appState = AppState.complete;
      });
      if (mounted) {
        await showAlertDialog(
          context,
          title: 'Error ❌',
          content: e.toString(),
          defaultActionText: 'OK',
        );
      }
      JHLogger.$.e(e.toString());
    }
  }

  List<Widget> _buildChildren(BuildContext context, {ChildModel? model}) {
    return [
      TextField(
        enabled: appState == AppState.loading ? false : true,
        focusNode: _nameFocusNode,
        controller: _nameController,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          if (model?.name.isValid(model.name) ?? true) {
            FocusScope.of(context).requestFocus(_keyFocusNode);
          }
        },
        decoration: const InputDecoration(
          labelText: 'Name',
        ),
      ),
      TextField(
        textCapitalization: TextCapitalization.characters,
        enabled: appState == AppState.loading ? false : true,
        focusNode: _keyFocusNode,
        controller: _key,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: 'Unique Key',
        ),
      ),
      const SizedBox(height: 16),
      if (appState == AppState.loading)
        Center(
          child: JHDisplayText(
            fontSize: 12,
            maxFontSize: 17,
            text: 'Please wait, this can take up to 2 mins ',
            style: TextStyle(color: Colors.orange.shade300),
          ),
        ),
      const SizedBox(height: 16),
      IgnorePointer(
        ignoring: _nameController.text.isEmpty ||
            _key.text.isEmpty ||
            appState == AppState.loading,
        child: Opacity(
          opacity: _nameController.text.isEmpty ||
                  _key.text.isEmpty ||
                  appState == AppState.loading
              ? 0.3
              : 1,
          child: FormSubmitButton(
            text: appState == AppState.loading ? 'Loading...' : 'Submit',
            onPressed: () {
              setState(() {
                appState = AppState.loading;
              });

              if (_nameController.text.isNotEmpty && _key.text.isNotEmpty) {
                _submit(_nameController.text, _key.text, context);
              }
            },
          ),
        ),
      ),
      const SizedBox(height: 8),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Set up Child '),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildChildren(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
