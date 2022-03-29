import 'package:flutter/material.dart';

class ChoiceChipData {
  String? label;
  String? id;
  bool? isSelected;
  Color? textColor;
  Color? selectedColor;

  ChoiceChipData({
    @required this.label,
    @required this.isSelected,
    @required this.textColor,
    @required this.selectedColor,
    @required this.id,
  });

  ChoiceChipData copy({
    String? label,
    String? id,
    bool? isSelected,
    Color? textColor,
    Color? selectedColor,
  }) =>
      ChoiceChipData(
        label: label ?? this.label,
        id: id ?? this.id,
        isSelected: isSelected ?? this.isSelected,
        textColor: textColor ?? this.textColor,
        selectedColor: selectedColor ?? this.selectedColor,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoiceChipData &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          id == other.id &&
          isSelected == other.isSelected &&
          textColor == other.textColor &&
          selectedColor == other.selectedColor;

  @override
  int get hashCode =>
      label.hashCode ^
      id.hashCode ^
      isSelected.hashCode ^
      textColor.hashCode ^
      selectedColor.hashCode;
}
