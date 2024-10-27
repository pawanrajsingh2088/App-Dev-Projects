import 'questions.dart';

class QuizBrain {
  int _questionNumber = 0;

  // List of questions for the quiz
  final List<Question> _questionBank = [
    Question('Some cats are actually allergic to humans', true),
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was "Moon".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('Google was originally called "Backrub".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  // Move to the next question if it exists
  void nextQuestion() {
    if (!isFinished()) {
      _questionNumber++;
    }
  }

  // Get the current question text
  String getQuestionText() {
    // Ensure we don't access out of bounds
    if (_questionNumber < _questionBank.length) {
      return _questionBank[_questionNumber].questionText;
    }
    return 'No more questions available'; // Fallback message
  }

  // Get the answer for the current question
  bool getCorrectAnswer() {
    // Ensure we don't access out of bounds
    if (_questionNumber < _questionBank.length) {
      return _questionBank[_questionNumber].questionAnswer;
    }
    throw Exception(
        "No more questions available"); // Throw error if accessed out of bounds
  }

  // Check if the quiz is finished
  bool isFinished() {
    return _questionNumber >= _questionBank.length - 1;
  }

  // Reset the quiz to the first question
  void reset() {
    _questionNumber = 0;
  }

  // Method to get the total number of questions
  int getTotalQuestions() {
    return _questionBank.length;
  }

  // Method to get the current question index
  int getCurrentQuestionIndex() {
    return _questionNumber;
  }
}
