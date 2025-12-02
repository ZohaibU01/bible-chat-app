class QuestionModel {
  final int id;
  final String questionText;
  final String type;
  final DateTime createdAt;
  final String? description;
  final String? category;
  final int? weight;
  final List<Option>? options;

  QuestionModel({
    required this.id,
    required this.questionText,
    required this.type,
    required this.createdAt,
    this.description,
    this.category,
    this.weight,
    this.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      questionText: json['question_text'] ?? '',
      type: json['type'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      description: json['description'],
      category: json['category'],
      weight: json['weight'],
      options: (json['options'] as List?)
          ?.map((option) => Option.fromJson(option))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_text': questionText,
      'type': type,
      'created_at': createdAt.toIso8601String(),
      'description': description,
      'category': category,
      'weight': weight,
      'options': options?.map((e) => e.toJson()).toList(),
    };
  }
}

class Option {
  final int id;
  final String optionText;

  Option({
    required this.id,
    required this.optionText,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      optionText: json['option_text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'option_text': optionText,
    };
  }
}
