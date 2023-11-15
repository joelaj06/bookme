class Failure{
  Failure({required this.message});

  factory Failure.empty() => Failure(message: '');

  final String message;
  @override
  String toString() => message;

}