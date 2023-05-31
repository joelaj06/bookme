import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextInputField extends StatefulWidget {
  AppTextInputField(
      {this.initialValue,
      Key? key,
      this.hintText,
      this.labelText,
      this.readOnly,
      this.maxLines,
      this.maxLength,
      this.minLines,
      this.inputFormatters,
      this.autoFocus,
      this.obscureText,
      this.padding,
      this.disabled = false,
      this.hideLabel,
      this.lableStyle,
      this.errorStyle,
      this.textInputType,
      this.controller,
      this.onChanged,
      this.focusNode,
      this.showObscureTextToggle,
      this.validator,
      this.infoText,
      this.textInputAction,
      this.onFieldSubmitted,
      this.backgroundColor,
      this.textColor,
      this.hintColor,
      this.prefixIcon,
      this.suffixIcon,
      this.textAlign,
      this.textAlignVertical,
      this.onTap,
      this.borderRadius,
      this.borderRadiusOutline,
      this.labelTextPadding,
      this.fontWeight,
      this.autofillHints,
      this.onEditingComplete})
      : super(key: key);

  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final bool? readOnly;
  final int? maxLines;
  final int? maxLength;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autoFocus;
  final bool? obscureText;
  final EdgeInsets? padding;
  final bool disabled;
  final bool? hideLabel;
  final TextStyle? lableStyle;
  final TextStyle? errorStyle;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool? showObscureTextToggle;
  final String? Function(String)? validator;
  final String? infoText;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final void Function()? onTap;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadius? borderRadiusOutline;
  final EdgeInsets? labelTextPadding;
  final FontWeight? fontWeight;
  bool? capitalizeLabel = false;
  final Iterable<String>? autofillHints;
  final VoidCallback? onEditingComplete;

  @override
  State<AppTextInputField> createState() => _AppTextInputFieldState();
}

class _AppTextInputFieldState extends State<AppTextInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.labelText == null)

          const SizedBox.shrink()
        else
          Text(
            widget.labelText.toString(),
            style: widget.lableStyle ?? const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        const AppSpacing(v: 2,),
        Container(
         // height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1,
                color: widget.disabled ? HintColor.color.shade50 :
                HintColor.color.shade100,
              )),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  initialValue: widget.initialValue,
                  onTap: widget.onTap,
                  readOnly: widget.readOnly ?? false,
                  focusNode: widget.focusNode,
                  autofillHints: widget.autofillHints,
                  obscuringCharacter: '*',
                  //obscureText: widget.obscuringText,
                  controller: widget.controller,
                  cursorColor: widget.textColor,
                  textInputAction: widget.textInputAction,
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines,
                  autofocus: widget.autoFocus ?? false,
                  textAlignVertical: widget.textAlignVertical,
                  minLines: widget.minLines,
                  keyboardType: widget.textInputType,

                  onEditingComplete: widget.onEditingComplete,
                  onChanged: widget.onChanged,
                  textAlign: widget.textAlign ?? TextAlign.start,
                  inputFormatters: widget.inputFormatters,
                  onFieldSubmitted: widget.onFieldSubmitted,
                  decoration: InputDecoration(

                    focusedBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),

                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    disabledBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    errorBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    //fillColor: Colors.transparent,
                    //floatingLabelBehavior: FloatingLabelBehavior.always,
                    alignLabelWithHint: true,
                    /* hintStyle: context.body1.copyWith(
                                            color: context.colors.hint,
                                            height: 1.2,
                                          ),*/
                    contentPadding: widget.padding ?? const EdgeInsets.all(8),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.suffixIcon,
                    hintText: widget.hintText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
