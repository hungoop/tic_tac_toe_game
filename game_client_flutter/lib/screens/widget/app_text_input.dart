
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppTextInput extends StatefulWidget {
  const AppTextInput({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.keyboardType,
    this.validator,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.onChanged,
    this.focusNode,
  });

  final Key? fieldKey;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? obscureText;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;

  @override
  _AppTextInputState createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  late bool obscureText;

  @override
  void initState() {
    obscureText = widget.obscureText ?? false;
    super.initState();
  }

  Widget? buildSuffixIcon() {
    if (obscureText) {
      return GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        child: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
        ),
      );
    }
    if (widget.controller != null && widget.controller!.text.isNotEmpty) {
      return GestureDetector(
        dragStartBehavior: DragStartBehavior.down,
        onTap: () {
          widget.controller!.text = '';
        },
        child: Icon(Icons.clear),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        key: widget.fieldKey,
        controller: widget.controller,
        obscureText: obscureText,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: widget.focusNode,
        onChanged: (text) {
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          helperText: widget.helperText,
          suffixIcon: buildSuffixIcon(),
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 10.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        )
      ),
    );
  }
}
