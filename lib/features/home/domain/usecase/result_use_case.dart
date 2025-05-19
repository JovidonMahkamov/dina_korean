import 'package:dina_korean_real/features/home/domain/entities/result.dart';
import 'package:dina_korean_real/features/home/domain/repository/home_repo.dart';

class ResultUseCase {
  final HomeRepo homeRepo;

  ResultUseCase(this.homeRepo);

  Future<List<Result>> call() async {
    return await homeRepo.getResult();
  }
}
