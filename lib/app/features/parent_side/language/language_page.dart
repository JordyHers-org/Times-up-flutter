// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/app/features/parent_side/language/language_notififier.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/widgets/jh_display_text.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({
    required this.auth,
    required this.languageModel,
    Key? key,
  }) : super(key: key);
  final AuthBase auth;
  final LanguageNotifier languageModel;

  static Widget create(
    BuildContext context,
    AuthBase auth,
  ) {
    return Consumer<LanguageNotifier>(
      builder: (BuildContext context, value, Widget? child) => LanguagePage(
        auth: auth,
        languageModel: value,
      ),
    );
  }

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : CustomColors.indigoDark;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, value) {
          return [
            SliverAppBar(
              elevation: 0.5,
              shadowColor: CustomColors.indigoLight,
              iconTheme: IconThemeData(color: color),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              expandedHeight: 50,
              pinned: true,
              floating: true,
            )
          ];
        },
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: JHDisplayText(
                  text: 'Languages',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                  fontSize: 32,
                  maxFontSize: 34,
                ).hP16,
              ),
              const SliverPadding(padding: EdgeInsets.only(top: 50)),
              SliverToBoxAdapter(
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  color: CustomColors.indigoLight,
                  child: Center(
                    child: SizedBox(
                      height: 60,
                      child: Center(
                        child: JHDisplayText(
                          text: widget.languageModel.selectedLanguage,
                          style: TextStyles.title,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 1000,
                      child: ListView.separated(
                        itemCount: 4,
                        itemBuilder: (builder, index) => GestureDetector(
                          onTap: () => widget.languageModel.selectLanguage(
                            widget.languageModel.languages[index],
                          ),
                          child: JHDisplayText(
                            text: widget.languageModel.languages[index],
                            style: TextStyles.title,
                          ).p(8),
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                          color: Colors.grey,
                        ).p4,
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
