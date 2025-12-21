import 'package:alert_info/src/utils/alerte_helper.dart';
import 'package:flutter/material.dart';

class AlerteInfoAnimated extends StatelessWidget {
  final AlerteHelper alerteHelper;
  final double finalWidth;
  final double finalHeight;
  final double textWidth;
  final double textHeight;
  final Animation<double> controller;
  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<double> topPosition;
  final VoidCallback onDismissed;

  static const sequence1 = 30.0;
  static const sequence23 = 70.0;
  static const sequence2 = 65.0;
  static const sequence3 = 5.0;
  AlerteInfoAnimated({
    super.key,
    required this.controller,
    required this.alerteHelper,
    required this.finalWidth,
    required this.finalHeight,
    required this.textWidth,
    required this.textHeight,
    required this.onDismissed,
  }) : opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
         CurvedAnimation(
           parent: controller,
           curve: const Interval(0.0, 0.200, curve: Curves.ease),
         ),
       ),
       topPosition =
           TweenSequence(<TweenSequenceItem<double>>[
             TweenSequenceItem<double>(
               tween: Tween(
                 begin: alerteHelper.isTop
                     ? -(finalHeight + 10)
                     : alerteHelper.maxHeight + finalHeight,
                 end: alerteHelper.isTop
                     ? alerteHelper.padding
                     : alerteHelper.maxHeight -
                           alerteHelper.padding -
                           finalHeight,
               ).chain(CurveTween(curve: Curves.easeInOut)),
               weight: sequence1,
             ),
             TweenSequenceItem<double>(
               tween: ConstantTween<double>(
                 alerteHelper.isTop
                     ? alerteHelper.padding
                     : alerteHelper.maxHeight -
                           alerteHelper.padding -
                           finalHeight,
               ),
               weight: sequence23,
             ),
           ]).animate(
             CurvedAnimation(
               parent: controller,
               curve: const Interval(0.0, 1.0),
             ),
           ),
       height =
           TweenSequence(<TweenSequenceItem<double>>[
             TweenSequenceItem<double>(
               tween: Tween(
                 begin: 55.0,
                 end: 45.0,
               ).chain(CurveTween(curve: Curves.linear)),
               weight: 20,
             ),
             TweenSequenceItem<double>(
               tween: Tween(
                 begin: 45.0,
                 end: finalHeight,
               ).chain(CurveTween(curve: Curves.linear)),
               weight: 10,
             ),
             TweenSequenceItem<double>(
               tween: ConstantTween<double>(finalHeight),
               weight: 70,
             ),
             //
           ]).animate(
             CurvedAnimation(
               parent: controller,
               curve: const Interval(0.0, 1.0),
             ),
           ),
       width =
           TweenSequence(<TweenSequenceItem<double>>[
             TweenSequenceItem<double>(
               tween: ConstantTween<double>(44.0),
               weight: sequence1,
             ),
             TweenSequenceItem<double>(
               tween: Tween(
                 begin: 44.0,
                 end: finalWidth - 40,
               ).chain(CurveTween(curve: Curves.easeIn)),
               weight: sequence2 / 2,
             ),
             TweenSequenceItem<double>(
               tween: Tween(
                 begin: finalWidth - 40,
                 end: finalWidth,
               ).chain(CurveTween(curve: Curves.elasticOut)),
               weight: sequence2 / 2,
             ),
           ]).animate(
             CurvedAnimation(
               parent: controller,
               curve: const Interval(0.0, 1.0),
             ),
           );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Positioned(
          left: (alerteHelper.maxWidth - width.value) / 2,
          top: topPosition.value,
          child: Material(
            color: Colors.transparent,
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                onDismissed.call();
              },
              child: Opacity(
                opacity: opacity.value,
                child: Container(
                  width: width.value,
                  height: height.value,
                  decoration: BoxDecoration(
                    color: alerteHelper.backgroundColor,
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: [
                      BoxShadow(
                        color: alerteHelper.backgroundColor.withValues(
                          alpha: 0.3,
                        ),
                        blurRadius: 20.0,
                        offset: alerteHelper.isThemeDark
                            ? const Offset(0, 1)
                            : const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    // clipBehavior: Clip.antiAlias,
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      Positioned(
                        left: 10,
                        child: Icon(
                          alerteHelper.icon,
                          size: 25.0,
                          color: alerteHelper.iconColor,
                        ),
                      ),
                      Positioned(
                        left: 45,
                        child: SizedBox(
                          width: textWidth,
                          height: textHeight,
                          child: Text(
                            alerteHelper.text,
                            style: TextStyle(color: alerteHelper.textColor),
                            maxLines: 10,
                          ),
                        ),
                      ),
                      if (alerteHelper.action != null)
                        Positioned(
                          left: textWidth + 48,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 120,
                              maxHeight: 45,
                            ),
                            child: Theme(
                              data: ThemeData(
                                brightness: alerteHelper.isThemeDark
                                    ? Brightness.light
                                    : Brightness.dark,
                                colorScheme: alerteHelper.scheme,
                              ),
                              child: TextButton(
                                onPressed: () =>
                                    alerteHelper.actionCallback != null
                                    ? alerteHelper.actionCallback!()
                                    : null,
                                child: Text(
                                  alerteHelper.action!,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
