import 'package:flutter/material.dart';
import 'package:treatment_checkup_app/configs/app_colors.dart';
import 'package:treatment_checkup_app/widgets/game_screen/base_card.dart';

class ResultCard extends StatelessWidget {
  final bool isCorrect;
  final String titleLabel;

  const ResultCard({
    @required this.titleLabel,
    @required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      titleLabel: titleLabel,
      borderColor: isCorrect ? AppColors.green : AppColors.darkSlateBlue,
      iconColor: isCorrect ? AppColors.green : AppColors.darkSlateBlue,
      icon: isCorrect ? Icons.check : Icons.check_circle,
    );
  }
}