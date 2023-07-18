import 'package:ams_garaihy/data/model/exam.dart';

class ExamDetails extends Exam {
  //   late final int id;
  //   late final String title;
  //   late final int duration;
  //   late int? totalMark;
  late final bool canReview;
  late final bool isDone;
  late final List<Question> questions;

  ExamDetails.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    canReview = json['can_review'];
    isDone = json['is_done'];
    questions = List.generate(json['questions'].length, (index) => Question.fromJson(json['questions'][index]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'can_review': canReview,
      'is_done': isDone,
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }

  /// Use this function in case when you post question data
  /// in update exam status, to save student questions with answers
  Map<String, dynamic> toJsonApi() {
    return {
      'questions': questions.map((e) => e.toJsonApi()).toList(),
    };
  }
}

class Question {
  late final int id;
  late final String title;
  late final int degree;
  late final bool isMultipleChoice;
  late final String? image;
  late final List<Answer> answers;
  List<Answer> selectedAnswers = [];
  bool corrected = false;
  /// WARNING: Use this variable only if you sure the question has already corrected.
  ///
  /// This variable changes when question corrected in provider and the answer is correct.
  ///
  /// You can add this getter func and use it instead of the variable to be safe when call it:
  ///
  /// [bool get isCorrectAns => corrected ? Di.sl<QuizProvider>().isAnswerCorrect(this) : isCorrect;]
  bool isCorrect = false;
  // bool get isCorrectAns => corrected ? Di.sl<QuizProvider>().isAnswerCorrect(this) : isCorrect;

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['question'];
    degree = int.parse(json['degree'].toString());
    isMultipleChoice = json['multiple_choice'];
    image = json['image'];
    answers = List.generate(json['answers'].length, (index) => Answer.fromJson(json['answers'][index]));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'degree': degree,
      'multiple_choice': isMultipleChoice,
      'image': image,
      'answers': answers.map((e) => e.toJson()).toList(),
    };
  }

  /// Use this function in case when you post question data
  /// in update exam status, to save student questions with answers
  Map<String, dynamic> toJsonApi() {
    return {
      'id': id,
      'degree': degree,
      'title': title,
      'image': image,
      'is_correct': isCorrect,
      'student_answers': selectedAnswers.isNotEmpty
          ? selectedAnswers.map((ans) => ans.toJson()).toList()
          : [Answer(title: 'Not answered').toJson()],
      'correct_answers': isCorrect ? null : answers.where((element) => element.isCorrect).map((e) => e.toJson()).toList(),
      // 'multiple_choice': isMultipleChoice,
    };
  }
}

class Answer {
  late final String title;
  late final bool isCorrect;
  // int? selectedAnswer;

  Answer({
    required this.title,
    this.isCorrect = false,
  });

  Answer.fromJson(Map<String, dynamic> json) {
    title = json['answer'];
    isCorrect = json['is_correct'] ?? false;
    // selectedAnswer = json['selected_answer'];
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'is_correct': isCorrect,
      // 'selected_answer': selectedAnswer,
    };
  }
}
