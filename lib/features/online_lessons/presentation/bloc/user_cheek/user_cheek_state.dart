abstract class CheckAnswerState {}
class CheckAnswerInitial extends CheckAnswerState {}
class CheckAnswerLoading extends CheckAnswerState {}
class CheckAnswerCorrect extends CheckAnswerState {}
class CheckAnswerIncorrect extends CheckAnswerState {}
class CheckAnswerError extends CheckAnswerState {}