import 'package:dina_korean_real/features/home/data/model/result_model.dart';

import '../../model/dashboard_model.dart';
import '../../../../online_lesson/data/model/profile_model.dart';

abstract class HomeRemouteDataSource{
  Future<DashboardModel> getStatistics();
  Future<List<ResultModel>> getResult();

}