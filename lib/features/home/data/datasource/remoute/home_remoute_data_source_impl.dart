import 'package:dina_korean_real/features/home/data/datasource/remoute/home_remoute_data_source.dart';
import 'package:dina_korean_real/features/home/data/model/dashboard_model.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/untils/logger.dart';
import '../../../../auth/data/datasource/local/auth_local_data_source.dart';

class HomeRemouteDataSourceImpl implements HomeRemouteDataSource {
  final DioClient dioClient = DioClient();
  final Dio dio = Dio();
  final AuthLocalDataSource authLocalDataSource;
  HomeRemouteDataSourceImpl(this.authLocalDataSource);

  @override
  Future<DashboardModel> getStatistics() async {
    try {
      final response = await dioClient.get(ApiUrls.statistics);
      if (response.statusCode == 200 || response.statusCode == 201) {
        LoggerService.info('statistics successful: ${response.data}');
        return DashboardModel.fromJson(response.data);
      } else {
        LoggerService.warning("statistics failed:${response.statusCode}");
        throw Exception('statistics failed: ${response.statusCode}');
      }
    } catch (e) {
      LoggerService.error('Error during user statistics: $e');
      rethrow;
    }
  }


}
