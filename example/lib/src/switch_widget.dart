import 'package:flutter/material.dart';

class SwitcherWidget extends StatefulWidget {
  final Function(bool) callback;
  final String text;
  final bool initialState;
  const SwitcherWidget({
    super.key,
    required this.callback,
    required this.text,
    this.initialState = true,
  });

  @override
  State<SwitcherWidget> createState() => _SwitcherWidgetState();
}

class _SwitcherWidgetState extends State<SwitcherWidget> {
  late bool currentState;
  @override
  void initState() {
    super.initState();
    currentState = widget.initialState;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.text),
        Transform.scale(
          scale: 0.7,
          child: Switch(
            value: currentState,
            onChanged: (value) {
              _onChanged(value);
            },
          ),
        ),
      ],
    );
  }

  void _onChanged(bool value) {
    setState(() {
      currentState = !currentState;
      widget.callback(value);
    });
  }
}
