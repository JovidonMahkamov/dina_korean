import 'package:dina_korean_real/features/home/domain/entities/dashboard_entity.dart';
import 'package:dina_korean_real/features/home/domain/repository/home_repo.dart';

class DashboardUseCase {
  final HomeRepo homeRepo;

  DashboardUseCase(this.homeRepo);

  Future<DashboardEntity> call() async {
    return await homeRepo.getStatistics();
  }
}
