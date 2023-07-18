import 'package:ams_garaihy/data/model/base/response_model.dart';
import 'package:ams_garaihy/data/model/body/exam_body.dart';
import 'package:ams_garaihy/data/model/exam.dart';
import 'package:ams_garaihy/data/model/exam_details.dart';
import 'package:ams_garaihy/data/repository/quiz_repo.dart';
import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  final QuizRepo quizRepo;

  QuizProvider(this.quizRepo) {
    _isQuizAnimationEnabled = quizRepo.isQuizAnimationEnabled();
  }

  bool _isLoading = false;
  bool _isTimerStarted = false;
  int _degree = 0;
  List<Exam> _exams = [];
  int _questionIndex = 0;
  ExamDetails? _examDetails;
  bool _isQuizAnimationEnabled = false;

  /// is navigating to next question
  bool _isNavigating = false;

  bool get isLoading => _isLoading;

  bool get isTimerStarted => _isTimerStarted;

  List<Exam> get exams => _exams;

  int get questionIndex => _questionIndex;

  int get questionsLength => _examDetails?.questions.length ?? 0;

  int? get examDurationInMins => _examDetails?.duration;

  bool get canReview => _examDetails?.canReview ?? false;

  int get degree => _degree;

  bool get isQuizAnimationEnabled => _isQuizAnimationEnabled;

  int get totalDegree {
    int result = 0;

    for (var i in _examDetails?.questions ?? <Question>[]) {
      result += i.degree;
    }

    return result;
  }

  String? get examTitle => _examDetails?.title;

  ExamDetails? get examDetails => _examDetails;

  Question? get currentQuestion {
    try {
      return _examDetails?.questions[_questionIndex];
    } catch (e) {
      return null;
    }
  }

  bool get isLastQuestion => _questionIndex + 1 == (_examDetails?.questions.length ?? -1);

  bool get isFirstQuestion => _questionIndex == 0;

  bool get isAnswersSelected => currentQuestion?.selectedAnswers.isNotEmpty ?? false;

  bool get isNavigating => _isNavigating;

  Future<ResponseModel> getExams(ExamBody examBody) async {
    _isLoading = true;
    notifyListeners();

    final apiResponse = await quizRepo.getExams(examBody);

    late ResponseModel responseModel;
    _exams = [];

    if (apiResponse.isSuccess) {
      responseModel = ResponseModel.withSuccess();

      for (var data in apiResponse.response!.data['data']) {
        final exam = Exam.fromJson(data);
        _exams.add(exam);
        // if (exam.isEndingTimePassed != true) {
        // }
      }
    } else {
      responseModel = ResponseModel.withError(apiResponse.error?.message);
    }

    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> getExercises(ExamBody examBody) async {
    _isLoading = true;
    notifyListeners();

    final apiResponse = await quizRepo.getExercises(examBody);

    late ResponseModel responseModel;
    _exams = [];

    if (apiResponse.isSuccess) {
      responseModel = ResponseModel.withSuccess();

      for (var data in apiResponse.response!.data['data']) {
        final exam = Exam.fromJson(data);
        if (exam.isEndingTimePassed != true) {
          _exams.add(exam);
        }
      }
    } else {
      responseModel = ResponseModel.withError(apiResponse.error?.message);
    }

    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> getExamDetails(int examId, {bool shuffle = true}) async {
    _questionIndex = 0;
    _isTimerStarted = false;
    _examDetails = null;
    _degree = 0;
    _isLoading = true;
    notifyListeners();

    final apiResponse = await quizRepo.getExamDetails(examId);

    late ResponseModel responseModel;

    if (apiResponse.isSuccess) {
      responseModel = ResponseModel.withSuccess();

      _examDetails = ExamDetails.fromJson(apiResponse.response!.data['data']);

      // shuffle the questions
      if (shuffle) {
        _examDetails?.questions.shuffle();
      }
    } else {
      responseModel = ResponseModel.withError(apiResponse.error?.message);
    }

    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> updateExamStatus() async {
    // remove exam from exams
    _exams.removeWhere((exam) => exam.id == _examDetails!.id);

    final apiResponse = await quizRepo.updateExamStatus(degree: _degree, exam: _examDetails!);

    late ResponseModel responseModel;

    if (apiResponse.isSuccess) {
      responseModel = ResponseModel.withSuccess();
      debugPrint('exam status updated successfully');
    } else {
      responseModel = ResponseModel.withError(apiResponse.error?.message);
    }

    notifyListeners();
    return responseModel;
  }

  /// This function stores an exam status locally when user is not online,
  /// and when be online it'll be updated in the server.
  ///
  /// Use this function when [updateExamStatus] throws error.
  Future<bool> storeExamStatusLocally() async {
    return await quizRepo.storeExamStatusLocally(degree: _degree, exam: _examDetails!);
  }

  /// This function check if there a sored exam in local storage or not.
  ///
  /// If there is a stored exam it'll upload its status to server from cached and will return [TRUE],
  /// otherwise it does nothing and returns [FALSE].
  Future<bool> checkStoredExamLocalAndUpdate() async {
    try {
      final examId = quizRepo.checkStoredExamLocal();
      if (examId == null) {
        return false;
      }
      debugPrint('updateExamFromLocal [$examId]');

      final apiResponse = await quizRepo.updateExamFromLocal();
      final success = apiResponse.isSuccess;
      debugPrint('is updateExamFromLocal success: $success');

      if (success) {
        await quizRepo.clearSavedExam();
        debugPrint('clearing saved exam ..');
      }
      return apiResponse.isSuccess;
    } catch (e) {
      await quizRepo.clearSavedExam();
      return false;
    }
  }

  void timerHasStarted() {
    _isTimerStarted = true;
    notifyListeners();
  }

  void setChosenAnswers(Answer selectedAnswer) {
    var question = _examDetails!.questions[_questionIndex];

    if (question.isMultipleChoice) {
      question.selectedAnswers.contains(selectedAnswer)
          ? question.selectedAnswers.remove(selectedAnswer)
          : question.selectedAnswers.add(selectedAnswer);
    } else {
      question.selectedAnswers = [selectedAnswer];
    }

    notifyListeners();
  }

  bool isAnswerCorrect(Question question) {
    bool result;

    if (question.isMultipleChoice) {
      List<Answer> correctAnswers = [];

      for (var ans in question.answers) {
        if (ans.isCorrect) {
          correctAnswers.add(ans);
        }
      }

      result = compareTwoLists(question.selectedAnswers, correctAnswers);
    } else {
      if (question.selectedAnswers.isEmpty) {
        result = false;
      } else {
        result = question.selectedAnswers.first.isCorrect;
      }
    }
    return result;
  }

  bool isAnswerSelected(Answer answer) {
    return currentQuestion!.selectedAnswers.contains(answer);
  }

  Future<void> navigating({int delay = 800}) async {
    _isNavigating = true;
    notifyListeners();

    await Future.delayed(Duration(milliseconds: delay));

    _isNavigating = false;
    notifyListeners();
  }

  void switchToNextQuestion() {
    if (!isLastQuestion) {
      _questionIndex++;
      notifyListeners();
    }
  }

  void switchToPrevQuestion() {
    if (!isFirstQuestion) {
      _questionIndex--;
      notifyListeners();
    }
  }

  void _addMarkIfAnswerCorrect([Question? q]) {
    final question = q ?? _examDetails!.questions[_questionIndex];
    var message = 'calc "${question.title}" answer';

    if (isAnswerCorrect(question) && !question.corrected) {
      _degree += question.degree;
      question.isCorrect = true;
      message = '✔: $message';
    }
    debugPrint('----\n$message - degree: $_degree');
    question.corrected = true;
  }

  void _calcAllAnswers() {
    for (var question in _examDetails!.questions) {
      _addMarkIfAnswerCorrect(question);
    }
  }

  void calcDegree({required bool finishExam}) {
    if (_examDetails!.canReview && finishExam) {
      _calcAllAnswers();
    } else if (_examDetails!.canReview == false) {
      _addMarkIfAnswerCorrect();
    }
  }

  bool compareTwoLists(List<Answer> selectedAnswers, List<Answer> correctAnswers) {
    debugPrint('selectedAnswers length: ${selectedAnswers.length}');
    debugPrint('correctAnswers length: ${correctAnswers.length}');

    if (selectedAnswers.length != correctAnswers.length) {
      return false;
    }

    for (var x in selectedAnswers) {
      if (!correctAnswers.contains(x)) {
        debugPrint('"${x.title}" is not correct answer');
        return false;
      }
    }

    return true;
  }

  Future<void> setQuizAnimationEnabled(bool isEnabled) async {
    _isQuizAnimationEnabled = isEnabled;
    await quizRepo.setQuizAnimationEnabled(isEnabled);
    notifyListeners();
  }
}
