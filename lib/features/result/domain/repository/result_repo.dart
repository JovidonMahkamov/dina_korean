import '../entities/result.dart';

abstract class ResultRepo{
  Future<List<Result>> getResult();
}