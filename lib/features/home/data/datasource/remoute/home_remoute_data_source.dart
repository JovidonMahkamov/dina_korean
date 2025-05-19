import 'package:dina_korean_real/features/home/data/model/result_model.dart';

import '../../model/dashboard_model.dart';
import '../../model/profile_model.dart';

abstract class HomeRemouteDataSource{
  Future<DashboardModel> getStatistics();
  Future<ProfileModel> getProfile();
  Future<List<ResultModel>> getResult();
  Future<void> putProfileEdit(ProfileModel profile);

}