import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/views/theme.dart';

class inputField extends StatelessWidget {
  final String hintText;
  final String title;
  final TextEditingController? controller;
  final Widget? widget;
  final bool? isDescription;

  const inputField(
      {Key? key,
      required this.hintText,
      required this.title,
      this.isDescription,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: titleTextStyle,
        ),
        Container(
            height: isDescription == true ? 100 : 50,
            padding: EdgeInsets.only(left: 15, right: 15),
            margin: EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: Get.isDarkMode ? Colors.white : Colors.grey)),
            child: widget == null
                ? Expanded(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.top,
                      maxLines: 5,
                      minLines: 1,
                      autofocus: false,
                      cursorColor:
                          Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                      controller: controller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: hintText,
                          hintStyle: titleTextFormStyle),
                      style: titleTextFormStyle,
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          textAlignVertical: TextAlignVertical.top,
                          keyboardType: isDescription == true
                              ? TextInputType.multiline
                              : TextInputType.text,
                          maxLines: null,
                          autofocus: false,
                          cursorColor: Get.isDarkMode
                              ? Colors.grey[100]
                              : Colors.grey[700],
                          controller: controller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: hintText,
                              hintStyle: titleTextFormStyle),
                          style: titleTextFormStyle,
                        ),
                      ),
                      Container(
                        child: widget,
                      ),
                    ],
                  )),
      ]),
    );
  }
}
