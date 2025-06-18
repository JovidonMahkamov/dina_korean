import '../../model/result_model.dart';

abstract class ResultRemoteDataSource{
  Future<List<ResultModel>> getResult();

}