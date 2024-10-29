import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:percent_indicator/percent_indicator.dart'; // For progress bar
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.quiz_outlined, color: Colors.white),
              Text(
                '  Quiz App',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.blueGrey[800],
        ),
        backgroundColor: Colors.blueGrey[900],
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int totalQuestions = quizBrain.getTotalQuestions();
  int correctAnswers = 0;

  @override
  Widget build(BuildContext context) {
    double progress = quizBrain.getCurrentQuestionIndex() / totalQuestions;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Progress Bar
        LinearPercentIndicator(
          lineHeight: 8.0,
          percent: progress,
          backgroundColor: Colors.grey[700],
          progressColor: Colors.green,
          animation: true,
          animationDuration: 500,
        ),
        const SizedBox(height: 10),

        // Question Counter
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Question ${quizBrain.getCurrentQuestionIndex() + 1}/$totalQuestions',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),

        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        Text(
          'Options:',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),

        // True Button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 5,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        const SizedBox(height: 20),

        // False Button
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 5,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: scoreKeeper,
          ),
        ),

        // Score Display
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Correct Answers: $correctAnswers/$totalQuestions',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished()) {
        // End of quiz alert
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.\nYour Score: $correctAnswers/$totalQuestions',
        ).show();
        quizBrain.reset();
        scoreKeeper = [];
        correctAnswers = 0; // Reset score
      } else {
        // Show feedback after each answer
        if (userPickedAnswer == correctAnswer) {
          correctAnswers++;
          scoreKeeper.add(const Icon(
            Icons.check,
            color: Colors.green,
            size: 30.0,
          ));
          Alert(
            context: context,
            title: "Correct!",
            desc: "Good job!",
            type: AlertType.success,
          ).show();
        } else {
          scoreKeeper.add(const Icon(
            Icons.close,
            color: Colors.red,
            size: 30.0,
          ));
          Alert(
            context: context,
            title: "Wrong!",
            desc: "Better luck next time.",
            type: AlertType.error,
          ).show();
        }
        quizBrain.nextQuestion();
      }
    });
  }
}
