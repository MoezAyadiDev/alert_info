import 'package:alert_info/src/utils/alerte_helper.dart';
import 'package:flutter/material.dart';

class HolderWidget extends StatelessWidget {
  final GlobalKey globalKey;
  final GlobalKey textKey;
  final AlerteHelper alerteHelper;
  const HolderWidget({
    super.key,
    required this.globalKey,
    required this.textKey,
    required this.alerteHelper,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Opacity(
        opacity: 1.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400, minWidth: 100),
          key: globalKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 10.0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Icon(alerteHelper.icon, size: 25.0),
                ),
                Flexible(child: Text(key: textKey, alerteHelper.text)),
                if (alerteHelper.action == null) const SizedBox(width: 10),
                if (alerteHelper.action != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 3, right: 2),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 120,
                        maxHeight: 45,
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(alerteHelper.action!),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
