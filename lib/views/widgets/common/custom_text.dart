import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Color? color;
  final bool? underline;
  final bool? isItalic;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double? fontheight;
  final String? fontFamily;
  final bool? needShadow;

  const CustomText(this.text,
      {super.key,
      this.fontSize,
      this.textAlign,
      this.overflow,
      this.needShadow,
      this.color,
      this.fontWeight,
      this.underline = false,
      this.isItalic = false,
      this.maxLines,
      this.fontheight,
      this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text(text ?? '',
        textAlign: textAlign ?? TextAlign.start,
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
        style: TextStyle(
            shadows: needShadow != null
                ? needShadow!
                    ? [
                        const Shadow(
                          offset:
                              Offset(2, 1.0), // Horizontal and vertical offset
                          blurRadius: 1.0, // Blur effect
                          color: Colors.white, // Shadow color
                        ),
                      ]
                    : null
                : null,
            fontFamily: fontFamily ?? 'Poppins',
            height: fontheight,
            fontWeight: fontWeight ?? FontWeight.w500,
            fontSize: fontSize ?? 16,
            fontStyle: isItalic! ? FontStyle.italic : FontStyle.normal,
            color: color,
            decoration:
                underline! ? TextDecoration.underline : TextDecoration.none));
  }
}
 