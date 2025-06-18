import 'package:dina_korean_real/features/result/domain/entities/result.dart';
import 'package:dina_korean_real/features/result/domain/repository/result_repo.dart';

class ResultUseCase {
  final ResultRepo resultRepo;

  ResultUseCase(this.resultRepo);

  Future<List<Result>> call() async {
    return await resultRepo.getResult();
  }
}
