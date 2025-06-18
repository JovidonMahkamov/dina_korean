import 'package:dina_korean_real/features/result/data/datasource/remote/result_remote_data_source.dart';
import 'package:dina_korean_real/features/result/domain/repository/result_repo.dart';

import '../../domain/entities/result.dart';

class ResultRepoImpl implements ResultRepo {
  final ResultRemoteDataSource resultRemoteDataSource;

  ResultRepoImpl({required this.resultRemoteDataSource});

  @override
  Future<List<Result>> getResult() {
    return resultRemoteDataSource.getResult();
  }
}
