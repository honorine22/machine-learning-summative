import 'package:flutter/material.dart';
import '../components/prediction_result.dart';

class PredictionScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  const PredictionScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prediction Results',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF667eea),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Color(0xFF667eea),
            ),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'New Prediction',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFf8f9fa),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Success Message
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFd4edda),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFc3e6cb)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF155724),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Prediction completed successfully!',
                          style: TextStyle(
                            color: const Color(0xFF155724),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Prediction Results
                PredictionResult(result: result),

                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back to Form'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFF667eea), width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('New Prediction'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF667eea),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Additional Info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFe1e5e9)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: Color(0xFF667eea),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'About This Prediction',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF333333),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'This prediction is based on machine learning analysis of socioeconomic indicators. The model considers education enrollment rates, demographic factors, and economic indicators to estimate employment rates.',
                        style: TextStyle(
                          color: const Color(0xFF666666),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
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