// ignore_for_file: avoid_print

import 'dart:math';

import 'package:ams_garaihy/data/model/base/api_response.dart';
import 'package:ams_garaihy/data/repository/quiz_repo.dart';
import 'package:ams_garaihy/providers/quiz_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestApiResponse {
  static ApiResponse withSuccess(Map<String, dynamic> data) {
    return ApiResponse.withSuccess(
      Response(
        data: data,
        requestOptions: RequestOptions(path: ''),
      ),
    );
  }
}

class MockQuizRepo extends Fake implements QuizRepo {
  @override
  Future<ApiResponse> getExamDetails(int id) async {
    return TestApiResponse.withSuccess({
      "status": true,
      "message": "exams retrieved successfully",
      "data": {
        "session": {"id": 1, "name": "السنه الدراسيه 2022"},
        "name": "القوي النوويه القويه",
        "subject": {"id": 6, "name": "مادة الكيمياء"},
        "exam category": {"id": 4, "name": "شيتات جزئية"},
        "id": 78,
        "duration": 20,
        "can_review": true,
        "is_done": false,
        "questions": [
          {
            "question": "لا توجد قوي تنافر كهروستاتيكيه في انويه كل مما يأتي عدا",
            "id": 428,
            "multiple_choice": false,
            "image": "",
            "degree": 1,
            "answers": [
              {"answer": "الماغنسيوم", "is_correct": true},
              {"answer": "البروتيوم", "is_correct": false},
              {"answer": "الديوتيريوم", "is_correct": false},
              {"answer": "التريتيوم", "is_correct": false}
            ]
          },
          {
            "question": "اي مما يلي يُعد صحيح بخصوص كتله النواه",
            "id": 429,
            "multiple_choice": false,
            "image": "",
            "degree": 1,
            "answers": [
              {"answer": "كتله المكونات الحره للنواه = كتله مكونات النواه بعد الترابط", "is_correct": false},
              {"answer": "كتله المكونات الحره للنواه > كتله مكونات النواه بعد الترابط", "is_correct": true},
              {"answer": "كتله المكونات الحره للنواه < كتله مكونات النواه بعد الترابط", "is_correct": false},
              {"answer": "الكتله الفعليه للنواه تساوي مجموع كتل البروتونات بداخلها", "is_correct": false}
            ]
          },
          {
            "question": "طاقه الترابط النووي تنتج من",
            "id": 430,
            "multiple_choice": false,
            "image": "",
            "degree": 1,
            "answers": [
              {"answer": "دوران الالكترون في مستويات طاقه اعلي", "is_correct": false},
              {"answer": "دوران الالكترون في مستويات طاقه اقل", "is_correct": false},
              {"answer": "تحول النيوكلونات الحره الي نيوكلونات مترابطه", "is_correct": true},
              {"answer": "تحول النيوكلونات الحره الي نيوكلونات حره", "is_correct": false}
            ]
          },
          {
            "question": "اختر الاجابه الصحيحه",
            "id": 431,
            "multiple_choice": false,
            "image": "1679847080.jpg",
            "degree": 1,
            "answers": [
              {"answer": "273.96  MeV", "is_correct": false},
              {"answer": "255.0567 MeV", "is_correct": true},
              {"answer": "301.65 MeV", "is_correct": false},
              {"answer": "525.65 MeV", "is_correct": false}
            ]
          },
          {
            "question": "اختر الاجابه الصحيحه",
            "id": 432,
            "multiple_choice": false,
            "image": "1679848861.jpg",
            "degree": 1,
            "answers": [
              {"answer": "143.113 MeV", "is_correct": true},
              {"answer": "19.15 MeV", "is_correct": false},
              {"answer": "134 MeV", "is_correct": false},
              {"answer": "141.8285 MeV", "is_correct": false}
            ]
          },
          {
            "question": "اي من الانويه التاليه تقع يسار حزام الاستقرار",
            "id": 433,
            "multiple_choice": false,
            "image": "1679848961.jpg",
            "degree": 1,
            "answers": [
              {"answer": "أ", "is_correct": false},
              {"answer": "ب", "is_correct": true},
              {"answer": "ج", "is_correct": false},
              {"answer": "د", "is_correct": false}
            ]
          },
          {
            "question": "اي من الانويه التاليه تقع يمين حزام الاستقرار",
            "id": 434,
            "multiple_choice": false,
            "image": "1679849109.jpg",
            "degree": 1,
            "answers": [
              {"answer": "أ", "is_correct": false},
              {"answer": "ب", "is_correct": false},
              {"answer": "ج", "is_correct": false},
              {"answer": "د", "is_correct": true}
            ]
          },
          {
            "question": "يقل عدد النيترونات في نواه العنصر X بعد مده زمنيه معينه نتيجه حدوث نشاط إشعاعي ، يؤدي الي",
            "id": 435,
            "multiple_choice": false,
            "image": "",
            "degree": 1,
            "answers": [
              {"answer": "تحول أحد النيوترونات الي بروتون ، و انبعاث بيتا", "is_correct": false},
              {"answer": "تحول أحد النيوترونات الي بروتون ، وانبعاث بوزيترون", "is_correct": true},
              {"answer": "تحول أحد النيوترونات الي نيوترون ، وانبعاث بيتا", "is_correct": false},
              {"answer": "تحول أحد النيوترونات الي نيوترون ، وانبعاث بوزيترون", "is_correct": false}
            ]
          }
        ]
      }
    });
  }

  @override
  bool isQuizAnimationEnabled() {
    return false;
  }
}

void main() {
  group('[QuizProvider]', () {
    late QuizProvider provider;
    late MockQuizRepo mockQuizRepo;

    setUp(() {
      mockQuizRepo = MockQuizRepo();
      provider = QuizProvider(mockQuizRepo);
    });

    // when(mockQuizRepo.getExamDetails(examDetails.id)).thenAnswer((_) async => TestApiResponse.withSuccess(examDetails.toJson()));

    test('Answer correct then calc degree', () async {
      // Set the exam to the provider
      await provider.getExamDetails(1);

      for (int i = 0;; i++) {
        final ques = provider.examDetails!.questions[i];
        final correctAns = ques.answers.singleWhere((element) => element.isCorrect);

        // Answer the correct answer
        provider.setChosenAnswers(correctAns);
        // Verify if answer is already selected
        expect(ques.selectedAnswers, [correctAns]);
        // Verify if answer is correct
        expect(provider.isAnswerCorrect(ques), true);
        provider.calcDegree(finishExam: provider.isLastQuestion);
        // Verify isLastQuestion is calculated correct
        expect(provider.isLastQuestion, i == provider.examDetails!.questions.length - 1);
        if (provider.isLastQuestion) {
          break;
        }
        provider.switchToNextQuestion();
      }

      // Verify that the provider exam is corrected successfully
      expect(provider.degree, provider.totalDegree);
      debugPrint('=========');
    });

    test('Answer randomly then calc degree', () async {
      // Init degree counter
      int degreeCounter = 0;

      // Set the exam to the provider
      await provider.getExamDetails(1);

      // Verify the degree equals to 0
      expect(provider.degree, 0);

      for (int i = 0;; i++) {
        final ques = provider.examDetails!.questions[i];
        // shuffle answers
        ques.answers.shuffle();
        final randomAns = ques.answers.first;

        // Answer the correct answer
        provider.setChosenAnswers(randomAns);
        // Verify if answer is already selected
        expect(ques.selectedAnswers, [randomAns]);
        // Verify if answer is correct
        expect(provider.isAnswerCorrect(ques), randomAns.isCorrect);
        if (randomAns.isCorrect) {
          degreeCounter += ques.degree;
        }
        provider.calcDegree(finishExam: provider.isLastQuestion);
        // Verify isLastQuestion is calculated correct
        expect(provider.isLastQuestion, i == provider.examDetails!.questions.length - 1);
        if (provider.isLastQuestion) {
          break;
        }
        provider.switchToNextQuestion();
      }

      // Verify that the provider exam is corrected successfully
      expect(provider.degree, degreeCounter);
      debugPrint('=========');
    });

    test('Answer wrong then calc degree', () async {
      // Init degree counter
      int degreeCounter = 0;

      // Set the exam to the provider
      await provider.getExamDetails(1);

      // Verify the degree equals to 0
      expect(provider.degree, 0);

      for (int i = 0;; i++) {
        final ques = provider.examDetails!.questions[i];
        // shuffle answers
        ques.answers.shuffle();
        final randomWrongAns = ques.answers.firstWhere((element) => !element.isCorrect);

        // Answer the correct answer
        provider.setChosenAnswers(randomWrongAns);
        // Verify if answer is already selected
        expect(ques.selectedAnswers, [randomWrongAns]);
        // Verify if answer is not correct
        expect(provider.isAnswerCorrect(ques), false);
        if (provider.isAnswerCorrect(ques)) {
          degreeCounter += ques.degree;
        }
        provider.calcDegree(finishExam: provider.isLastQuestion);
        // Verify isLastQuestion is calculated correct
        expect(provider.isLastQuestion, i == provider.examDetails!.questions.length - 1);
        if (provider.isLastQuestion) {
          break;
        }
        provider.switchToNextQuestion();
      }

      // Verify that the provider exam is corrected successfully
      expect(provider.degree, 0);
      expect(degreeCounter, 0);
      debugPrint('=========');
    });

    test('Answer randomly with ordered navigating questions then calc degree', () async {
      // Set the exam to the provider
      await provider.getExamDetails(1);

      // Verify the degree equals to 0
      expect(provider.degree, 0);

      print('# Answering randomly');
      // Answer randomly
      for (int i = 0; i < provider.questionsLength; i++) {
        final ques = provider.examDetails!.questions[i];
        // Verify that the ques equals the current question
        expect(ques == provider.currentQuestion, true);
        // shuffle answers
        ques.answers.shuffle();
        final randomAns = ques.answers.first;

        provider.setChosenAnswers(randomAns);
        print('- question ${ques.id}: "${ques.title}" | random selected ans: "${randomAns.title}" - [${randomAns.isCorrect ? 'CORRECT ✔' : 'WRONG! ❌'}]');
        // Verify if answer is already selected
        expect(ques.selectedAnswers, [randomAns]);
        // Verify if answer is correct
        expect(provider.isAnswerCorrect(ques), randomAns.isCorrect);
        provider.switchToNextQuestion();
      }
      print('####');
      print('- selected answers = ');
      for (var element in provider.examDetails!.questions) {
        print(element.selectedAnswers.map((e) => '${e.isCorrect ? '✔' : '❌'}: ${e.title}'));
      }
      print('####');

      print('# Re-Answering and navigating to prev question');
      // re-answer and navigate to prev question
      for (int i = 0; i < provider.questionsLength; i++) {
        final ques = provider.currentQuestion!;
        // shuffle answers
        ques.answers.shuffle();
        final randomAns = ques.answers.first;

        print('- question ${ques.id}: prev: "${ques.selectedAnswers.map((e) => e.title).toString()}" - new: "${randomAns.title}" - (${randomAns.isCorrect ? '✔' : '❌'})');

        // Answer the correct answer
        provider.setChosenAnswers(randomAns);
        // Verify if answer is already selected
        expect(ques.selectedAnswers, [randomAns]);
        // Verify if answer is correct
        expect(provider.isAnswerCorrect(ques), randomAns.isCorrect);
        provider.switchToPrevQuestion();
      }
      print('####');
      print('# Correct answers: ${provider.examDetails!.questions.map((q) => q.selectedAnswers.first.isCorrect ? q.selectedAnswers.first.title : '').toSet()}');
      // Calc degree
      provider.calcDegree(finishExam: true);

      int calc() {
        int degree = 0;
        for (var q in provider.examDetails!.questions) {
          if (q.selectedAnswers.first.isCorrect) {
            degree += q.degree;
          }
        }

        return degree;
      }

      // Verify that the provider exam is corrected successfully
      final expectedDegree = calc();
      print('####');
      print('Expected degree = $expectedDegree');
      print('DEGREE = ${provider.degree}');
      expect(provider.degree, expectedDegree);
      debugPrint('=========');
    });

    test('Answer randomly number of questions with randomly navigating questions then calc degree', () async {
      // Set the exam to the provider
      await provider.getExamDetails(1);

      int getRandomInt({int min = 0, required int max}){
        return Random().nextInt(max-min) + min;
      }

      bool getRandomBool(){
        return Random().nextBool();
      }

      // Verify the degree equals to 0
      expect(provider.degree, 0);

      print('# Answering randomly question numbers');
      // Answer randomly
      for (int i = 0; i < getRandomInt(min: 2, max: provider.questionsLength); i++) {
        final ques = provider.currentQuestion!;
        // shuffle answers
        ques.answers.shuffle();
        final randomAns = ques.answers.first;

        provider.setChosenAnswers(randomAns);
        print(
            '- question ${ques.id}: "${ques.title}" | random selected ans: "${randomAns.title}" - [${randomAns.isCorrect ? 'CORRECT ✔' : 'WRONG! ❌'}]');
        // Verify if answer is already selected
        expect(ques.selectedAnswers, [randomAns]);
        // Verify if answer is correct
        expect(provider.isAnswerCorrect(ques), randomAns.isCorrect);
        final switchNext = getRandomBool();
        print(switchNext?'Switch NEXT': 'Switch PREV');

        switchNext ? provider.switchToNextQuestion() : provider.switchToPrevQuestion();
      }
      print('####');
      print('- selected answers = ');
      for (var element in provider.examDetails!.questions) {
        print(element.selectedAnswers.map((e) => '${e.isCorrect ? '✔' : '❌'}: ${e.title}'));
      }
      // Calc degree
      provider.calcDegree(finishExam: true);

      int calc() {
        int degree = 0;
        for (var q in provider.examDetails!.questions) {
          if (q.selectedAnswers.isNotEmpty && q.selectedAnswers.first.isCorrect) {
            degree += q.degree;
          }
        }

        return degree;
      }

      // Verify that the provider exam is corrected successfully
      final expectedDegree = calc();
      print('####');
      print('Expected degree = $expectedDegree');
      print('DEGREE = ${provider.degree}');
      expect(provider.degree, expectedDegree);
      debugPrint('=========');
    });

    test('Calculate the same question more than once, After answer randomly number of questions with randomly navigating questions', () async {
      // Set the exam to the provider
      await provider.getExamDetails(1);

      int getRandomInt({int min = 0, required int max}){
        return Random().nextInt(max-min) + min;
      }

      bool getRandomBool(){
        return Random().nextBool();
      }

      // Verify the degree equals to 0
      expect(provider.degree, 0);

      print('# Answering randomly question numbers');
      // Answer randomly
      for (int i = 0; i < getRandomInt(min: 5, max: provider.questionsLength); i++) {
        final ques = provider.currentQuestion!;
        // shuffle answers
        ques.answers.shuffle();
        final randomAns = ques.answers.first;

        provider.setChosenAnswers(randomAns);
        print(
            '- question ${ques.id}: "${ques.title}" | random selected ans: "${randomAns.title}" - [${randomAns.isCorrect ? 'CORRECT ✔' : 'WRONG! ❌'}]');
        // Verify if answer is already selected
        expect(ques.selectedAnswers, [randomAns]);
        // Verify if answer is correct
        expect(provider.isAnswerCorrect(ques), randomAns.isCorrect);
        final switchNext = getRandomBool();
        print(switchNext?'Switch NEXT': 'Switch PREV');

        switchNext ? provider.switchToNextQuestion() : provider.switchToPrevQuestion();
      }
      print('####');
      print('- selected answers = ');
      for (var element in provider.examDetails!.questions) {
        print(element.selectedAnswers.map((e) => '${e.isCorrect ? '✔' : '❌'}: ${e.title}'));
      }
      // Calc degree
      provider.calcDegree(finishExam: true);
      provider.calcDegree(finishExam: true);
      provider.calcDegree(finishExam: true);
      provider.calcDegree(finishExam: true);
      provider.calcDegree(finishExam: true);
      provider.calcDegree(finishExam: true);

      int calc() {
        int degree = 0;
        for (var q in provider.examDetails!.questions) {
          if (q.selectedAnswers.isNotEmpty && q.selectedAnswers.first.isCorrect) {
            degree += q.degree;
          }
        }

        return degree;
      }

      // Verify that the provider exam is corrected successfully
      final expectedDegree = calc();
      print('####');
      print('Expected degree = $expectedDegree');
      print('DEGREE = ${provider.degree}');
      expect(provider.degree, expectedDegree);
      debugPrint('=========');
    });
  });
}
