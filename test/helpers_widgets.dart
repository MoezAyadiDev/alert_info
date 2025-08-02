import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';

class AlertHelperTest {
  static get infoWidget => widgetCreator(
    onPressed: (context) {
      AlertInfo.show(context: context, text: 'Test alert info');
    },
  );
  static get warningWidget => widgetCreator(
    onPressed: (context) {
      AlertInfo.show(
        context: context,
        text: 'Test alert warning',
        typeInfo: TypeInfo.warning,
      );
    },
  );
  static get errorWidget => widgetCreator(
    onPressed: (context) {
      AlertInfo.show(
        context: context,
        text: 'Test alert error',
        typeInfo: TypeInfo.error,
      );
    },
  );
  static get successWidget => widgetCreator(
    onPressed: (context) {
      AlertInfo.show(
        context: context,
        text: 'Test alert success',
        typeInfo: TypeInfo.success,
      );
    },
  );
}

widgetCreator({required Function onPressed}) => MaterialApp(
  home: Scaffold(
    body: Builder(
      builder: (BuildContext context) {
        return ElevatedButton(
          onPressed: () {
            onPressed(context);
          },
          child: const Text('Display alert'),
        );
      },
    ),
  ),
);
