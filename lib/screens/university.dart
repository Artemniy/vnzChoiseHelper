import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dyplom/data/db/entity/university.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UniversityPage extends StatefulWidget {
  final University university;

  const UniversityPage({Key? key, required this.university}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UniversityPageState();
  }
}

class _UniversityPageState extends State<UniversityPage> {
  University get university => widget.university;

  void _showCopiedToast() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Електронну пошту скопійовано')));
  }

  final _grayTextStyle = const TextStyle(color: Colors.black54);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _AppBar(name: university.shortName ?? ''),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        university.imageUrl ?? '',
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: const Center(
                                child: Text(
                              'Не вдалося завантажити',
                              textAlign: TextAlign.center,
                            )),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[300],
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        university.name ?? '',
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Позиція в рейтингу: '),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                              color: Colors.blue[400], shape: BoxShape.circle),
                          child: Center(
                            child: AutoSizeText(
                              university.rankingPosition.toString(),
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(1, 1),
                                blurRadius: 20,
                                spreadRadius: 3),
                          ]),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(15),
                      child: SelectableText.rich(
                        TextSpan(
                            style: const TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: 'Адреса: ', style: _grayTextStyle),
                              TextSpan(text: university.fullAddress),
                              TextSpan(
                                  text: '\n\nРік: ', style: _grayTextStyle),
                              TextSpan(text: university.year.toString()),
                              TextSpan(
                                  text: '\n\nКількість студентів: ',
                                  style: _grayTextStyle),
                              TextSpan(
                                text: university.studentsCount == null
                                    ? 'Інформація відсутня'
                                    : university.studentsCount.toString(),
                              ),
                              TextSpan(
                                  text: '\n\nТелефон: ', style: _grayTextStyle),
                              TextSpan(text: university.phone ?? ''),
                              TextSpan(
                                text: '\n\nЕлектронна пошта: ',
                                style: _grayTextStyle,
                              ),
                              TextSpan(
                                text: university.email ?? '',
                                style: const TextStyle(color: Colors.orange),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    try {
                                      EmailContent email = EmailContent(
                                        to: [university.email ?? ''],
                                      );

                                      final result = await OpenMailApp
                                          .composeNewEmailInMailApp(
                                              nativePickerTitle:
                                                  'Виберіть додаток електронної пошти, щоб написати листа',
                                              emailContent: email);
                                      if (!result.didOpen && !result.canOpen) {
                                        _showCopiedToast();
                                      } else if (!result.didOpen &&
                                          result.canOpen) {
                                        showDialog(
                                          context: context,
                                          builder: (_) => MailAppPickerDialog(
                                            mailApps: result.options,
                                            emailContent: email,
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      log(e.toString());
                                    }
                                  },
                              ),
                              TextSpan(
                                  text: '\n\nВеб-сайт: ',
                                  style: _grayTextStyle),
                              TextSpan(
                                text: university.site ?? '',
                                style: const TextStyle(color: Colors.orange),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    try {
                                      await launchUrl(
                                          Uri.parse(university.site ?? ''));
                                    } catch (e) {
                                      log(e.toString());
                                    }
                                  },
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          String googleUrl =
                              'https://www.google.com/maps/search/?api=1&query=${university.lat},${university.lng}';
                          try {
                            await launchUrlString(googleUrl);
                          } catch (e) {
                            log(e.toString());
                          }
                        },
                        child: const Text('Знайти маршрут')),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final String name;

  const _AppBar({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back)),
            ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7),
                child: AutoSizeText(
                  name,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      const Divider(
        height: 1,
        color: Colors.black26,
      ),
    ]);
  }
}
