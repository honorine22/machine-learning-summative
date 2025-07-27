import 'package:flutter/material.dart';

class FormStepper extends StatelessWidget {
  final List<Map<String, dynamic>> sections;
  final Map<String, TextEditingController> controllers;
  final int currentStep;
  final Set<int> completedSteps;
  final VoidCallback onStepContinue;
  final VoidCallback onStepCancel;

  const FormStepper({
    super.key,
    required this.sections,
    required this.controllers,
    required this.currentStep,
    required this.completedSteps,
    required this.onStepContinue,
    required this.onStepCancel,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Stepper(
      currentStep: currentStep,
      onStepContinue: onStepContinue,
      onStepCancel: onStepCancel,
      type: isMobile ? StepperType.vertical : StepperType.horizontal,
      controlsBuilder: (context, details) {
                return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            children: [
              if (currentStep == sections.length - 1)
                Column(
                  children: [
                    // Back button above predict button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: details.onStepCancel,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: const BorderSide(color: Color(0xFF667eea), width: 2),
                        ),
                        child: const Text(
                          '← Back to Previous Step',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF667eea),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Predict button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF667eea),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          '🚀 Predict Employment Rate',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (currentStep < sections.length - 1)
                Row(
                  children: [
                    if (currentStep > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: details.onStepCancel,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Previous'),
                        ),
                      ),
                    if (currentStep > 0) const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: details.onStepContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF667eea),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
      steps: sections.asMap().entries.map((entry) {
        final index = entry.key;
        final section = entry.value;
        final isCompleted = completedSteps.contains(index);

        return Step(
          title: Text(
            section['title'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 14 : 16,
            ),
          ),
          subtitle: Text(
            'Step ${index + 1} of ${sections.length}',
            style: TextStyle(fontSize: isMobile ? 11 : 12),
          ),
          state: isCompleted ? StepState.complete : StepState.indexed,
          isActive: currentStep == index,
          content: Column(
            children: section['fields'].map<Widget>((field) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  controller: controllers[field['name']],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: field['label'],
                    hintText: field['hint'],
                    suffixIcon: Icon(
                      _getFieldIcon(field['name']),
                      color: const Color(0xFF667eea),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    final numValue = double.tryParse(value);
                    if (numValue == null) {
                      return 'Enter a valid number';
                    }
                    if (numValue < field['min'] || numValue > field['max']) {
                      return 'Must be between ${field['min']} and ${field['max']}';
                    }
                    return null;
                  },
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  IconData _getFieldIcon(String fieldName) {
    switch (fieldName) {
      case 'school_enrollment_primary':
      case 'school_enrollment_secondary':
      case 'literacy_rate':
        return Icons.school;
      case 'urban_population_percent':
      case 'rural_population_percent':
      case 'population':
      case 'life_expectancy':
        return Icons.people;
      case 'gdp_per_capita':
      case 'agriculture_value_added':
      case 'industry_value_added':
      case 'services_value_added':
        return Icons.attach_money;
      case 'internet_users_percent':
      case 'mobile_subscriptions':
      case 'access_to_electricity':
        return Icons.wifi;
      default:
        return Icons.edit;
    }
  }
}
