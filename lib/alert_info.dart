import 'package:alert_info/src/utils/alerte_helper.dart';
import 'package:alert_info/src/widgets/alerte_info_widget.dart';
import 'package:flutter/material.dart';

enum MessagePosition { top, bottom }

enum TypeInfo { warning, error, success, info }

OverlayEntry? _previousEntry;
OverlayState? overlayState;

class AlertInfo {
  ///represents a handle to the location of a widget in the widget tree
  final BuildContext context;

  ///The text to be displayed
  final String text;

  ///The position of the alerte info `Top` or `Bottom`
  ///
  ///By default is [MessagePosition.top]
  ///
  ///to display the alrte info at the bottom
  ///use [MessagePosition.bottom]
  final MessagePosition position;

  ///The padding from top or bottom
  ///
  ///by default `padding = 30`
  final double padding;

  ///The duration in seconde of the alert info
  ///
  ///by default `duration = 3` seconde
  final int duration;

  ///Optionnal : background color
  ///
  ///by default the surface color of the inverse theme
  final Color? backgroundColor;

  ///Optionnal : text color
  ///
  ///by default the onSurface color of the inverse theme
  ///
  final Color? textColor;

  ///Optionnal : icon color
  ///
  ///by default depond on [TypeInfo] and [ThemeMode]
  ///
  /// - `info` : ThemeMode is dark `greenAccent` else `green`
  /// - `success` : ThemeMode is dark `greenAccent` else `green`
  /// - `warning` : ThemeMode is dark `orangeAccent` else `orange`
  /// - `error` : ThemeMode is dark `redAccent` else `red`
  final Color? iconColor;

  /// Optional callback that is called when the [action] is clicked.
  final Color? actionColor;
  final String? action;

  /// Optional : action color
  ///
  /// by default the color of TextButton of the inverse theme
  final Function? actionCallback;

  /// Optional : icon to diplay
  ///
  /// by default depend of [TypeInfo]
  final IconData? icon;

  /// Optional : [TypeInfo] `warning`, `error`, `success`, `info`
  ///
  /// by default `TypeInfo.info`
  ///
  /// Change the icon and his color
  final TypeInfo typeInfo;

  ///Display an animated Alert info
  ///
  ///Require the context and the text to be displayed
  ///
  ///There a four type of alert `warning`, `error`, `success`, `info`
  ///
  /// ```dart
  /// AlertInfo.show(
  ///   context: context,
  ///   text: 'Alert info demo',
  /// );
  /// ```
  ///
  /// [typeInfo] : to change the type of the alert by default `TypeInfo.info`
  ///
  /// - [TypeInfo.info] : [icon]=`Icons.error_outline`, [iconColor]=`green`
  /// - [TypeInfo.warning] : [icon]=`Icons.warning_amber_rounded`, [iconColor]=`orange`
  /// - [TypeInfo.success] : [icon]=`Icons.check_circle_outline`, [iconColor]=`green`
  /// - [TypeInfo.error] : [icon]=`Icons.help_outline`, [iconColor]=`red`
  ///
  /// [position] : the position of the alert by default `MessagePosition.top`
  AlertInfo.show({
    required this.context,
    required this.text,
    this.position = MessagePosition.top,
    this.padding = 30.0,
    this.duration = 3,
    this.typeInfo = TypeInfo.info,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.actionColor,
    this.action,
    this.actionCallback,
    this.icon,
  }) {
    _buildAlertInfo();
  }

  _buildAlertInfo() {
    AlerteHelper alerteHelper = AlerteHelper(
      context: context,
      text: text,
      position: position,
      padding: padding,
      duration: duration,
      action: action,
      actionCallback: actionCallback,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      actionColor: actionColor,
      typeInfo: typeInfo,
      icon: icon,
    );

    overlayState ??= Overlay.of(context);
    if (!overlayState!.mounted) {
      overlayState = Overlay.of(context);
    }
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return AlerteInfoWidget(
          alerteHelper: alerteHelper,
          onDismissed: () {
            if (overlayEntry.mounted && _previousEntry == overlayEntry) {
              overlayEntry.remove();
              _previousEntry = null;
            }
          },
        );
      },
    );
    if (_previousEntry != null && _previousEntry!.mounted) {
      _previousEntry?.remove();
    }
    if (overlayState != null) {
      overlayState!.insert(overlayEntry);
      _previousEntry = overlayEntry;
    }
  }
}
