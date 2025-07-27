import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 8 : 12),
      child: Column(
        children: [
          Text(
            '🌍 Employment Rate Predictor',
            style: TextStyle(
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            'Predict employment rates using UNICEF data and ML',
            style: TextStyle(
              fontSize: isMobile ? 11 : 13,
              color: const Color(0xFF666666),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
