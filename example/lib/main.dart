import 'package:alert_info/alert_info.dart';
import 'package:example/src/switch_widget.dart';
import 'package:example/src/theme_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isTop = true;
  bool lightTheme = true;
  bool hasAction = false;
  TextEditingController textController = TextEditingController(
    text: 'Congratulation. this is a first animated info',
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: lightTheme ? ThemeMode.light : ThemeMode.dark,
      theme: ThemeService.lightTheme,
      darkTheme: ThemeService.darkTheme,
      home: Builder(
        builder: (context) {
          //Display the alert info
          showInfo(TypeInfo typeInfo) {
            return AlertInfo.show(
              context: context,
              text: textController.text,
              typeInfo: typeInfo,
              position: isTop ? MessagePosition.top : MessagePosition.bottom,
              action: hasAction ? 'Undo' : null,
              actionCallback: hasAction
                  ? () {
                      debugPrint('undo clicked');
                    }
                  : null,
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Alert info example'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SwitcherWidget(
                    text: 'Top info',
                    callback: (value) {
                      setState(
                        () {
                          isTop = value;
                        },
                      );
                    },
                  ),
                  SwitcherWidget(
                    text: 'Light theme',
                    callback: (value) {
                      setState(() {
                        lightTheme = !lightTheme;
                      });
                    },
                  ),
                  SwitcherWidget(
                    text: 'With action',
                    initialState: false,
                    callback: (value) {
                      setState(() {
                        hasAction = !hasAction;
                      });
                    },
                  ),
                  const Text(
                    '--------------- Text to display ---------------',
                  ),
                  SizedBox(
                    width: 400,
                    child: TextField(
                      controller: textController,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => showInfo(TypeInfo.info),
                    child: const Text('Simple info'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => showInfo(TypeInfo.success),
                    child: const Text('Success info'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => showInfo(TypeInfo.warning),
                    child: const Text('Warning info'),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => showInfo(TypeInfo.error),
                    child: const Text('Error alert'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
