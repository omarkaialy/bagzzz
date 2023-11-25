import 'package:bagzzz/core/constants/extensions/context_extensions.dart';
import 'package:bagzzz/core/constants/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    Key? key,
    this.borderColor,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.isPassword = false,
    this.enabled = true,
    this.autoFocus = false,
    this.error = false,
    this.smallSuffixIcon = false,
    this.borderRadius,
    this.maxLines = 1,
    this.width,
    this.height,
    this.label,
    this.labelStyle,
    this.fillColor = Colors.transparent,
    this.hint,
    this.hintStyle,
    this.onSubmitted,
    required this.controller,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.readOnly = false,
    this.onTap,
  }) : super(key: key);

  final TextInputAction textInputAction;
  final Color? borderColor;
  final double? width;
  final Function(String)? onSubmitted;
  final double? height;
  final String? hint;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool enabled;
  final bool autoFocus;
  final bool smallSuffixIcon;
  final bool error;
  final int maxLines;
  final BorderRadius? borderRadius;
  final Color fillColor;
  final Function(String)? onChanged;
  final String? label;
  final TextStyle? labelStyle;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsetsGeometry contentPadding;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> with WidgetsBindingObserver {
  late ValueNotifier<bool> showPassword;
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addObserver(this);
    showPassword = ValueNotifier(widget.isPassword);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ValueListenableBuilder(
          valueListenable: showPassword,
          builder: (context, value, _) {
            return TextFormField(
              controller: widget.controller,
              validator: widget.validator,
              onFieldSubmitted: widget.onSubmitted,
              textInputAction: widget.textInputAction,
              style: widget.textStyle,
              cursorColor: widget.borderColor ?? Theme.of(context).primaryColor,
              enabled: widget.enabled,
              inputFormatters: widget.keyboardType == TextInputType.number ? [FilteringTextInputFormatter.digitsOnly] : null,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              onChanged: widget.onChanged,
              autofocus: widget.autoFocus,
              obscureText: value,
              enableSuggestions: widget.isPassword,
              autocorrect: widget.isPassword,
              autovalidateMode: widget.autovalidateMode,
              textAlign: widget.textAlign,
              readOnly: widget.readOnly,
              minLines: widget.maxLines,
              onTap: () {
                final lastSelectionPosition = TextSelection.fromPosition(
                  TextPosition(offset: widget.controller.text.length - 1),
                );

                final afterLastSelectionPosition = TextSelection.fromPosition(
                  TextPosition(offset: widget.controller.text.length),
                );

                if (widget.controller.selection == lastSelectionPosition) {
                  widget.controller.selection = afterLastSelectionPosition;
                }

                if (widget.onTap != null) {
                  widget.onTap!();
                }
              },
              decoration: InputDecoration(
                contentPadding: widget.contentPadding,
                labelStyle: widget.labelStyle ?? context.textTheme.titleMedium,
                // constraints: BoxConstraints(
                //   maxWidth: size.width,
                //   maxHeight: size.width * .5,
                //   minHeight: size.width * .5,
                // ),
                label: widget.label == null ? null : Text(widget.label!),
                filled: true,
                fillColor: widget.fillColor,
                focusColor: context.theme.primaryColor,
                hintText: widget.hint,
                hintStyle: widget.hintStyle ?? context.textTheme.titleLarge!.copyWith(color: context.theme.hintColor),
                enabledBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: widget.borderColor ?? context.theme.hintColor),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(15.r),
                  borderSide: BorderSide(
                    color: widget.error ? const Color(0xfffe2e2e) : context.theme.hintColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: widget.borderColor ?? context.theme.primaryColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: widget.borderColor ?? Colors.grey.shade300),
                ),

                prefixIcon: widget.prefixIcon,
                prefixIconConstraints: widget.smallSuffixIcon ? BoxConstraints(maxWidth: size.width * .15) : null,
                suffixIcon: widget.isPassword
                    ? SizedBox(
                        height: 10.sp,
                        width: 50.sp,
                        child: Center(
                          child: AnimatedCrossFade(
                            crossFadeState: value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 500),
                            firstChild: const Icon(Icons.visibility),
                            secondChild: const Icon(Icons.visibility_off),
                          ).onTap(() => showPassword.value = !value),
                        ),
                      )
                    : widget.suffixIcon,
                suffixIconConstraints: widget.smallSuffixIcon ? BoxConstraints(maxWidth: size.width * .15) : null,
                // contentPadding: widget.maxLines != 1 ? null : const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            );
          }),
    );
  }
}
