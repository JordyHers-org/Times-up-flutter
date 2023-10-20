import 'package:flutter/material.dart';
import 'package:times_up_flutter/app/helpers/parsing_extension.dart';
import 'package:times_up_flutter/models/child_model/child_model.dart';

class AppListPage extends StatelessWidget {
  const AppListPage({
    required this.childModel,
    Key? key,
  }) : super(key: key);

  final ChildModel childModel;

  static Future<void> show(BuildContext context, ChildModel model) async {
    await Navigator.of(context).push(
      PageRouteBuilder<Widget>(
        pageBuilder: (context, animation, secondaryAnimation) {
          return AppListPage(childModel: model);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: themeData.scaffoldBackgroundColor,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast),
        itemCount: childModel.appsUsageModel.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: childModel.appsUsageModel[index].appIcon != null
                    ? Image.memory(
                        childModel.appsUsageModel[index].appIcon!,
                        height: 35,
                      )
                    : const Icon(Icons.android),
                title: Text(
                  childModel.appsUsageModel[index].appName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: themeData.dividerColor,
                  ),
                ),
                trailing: Text(
                  childModel.appsUsageModel[index].usage.toString().t(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: themeData.dividerColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
