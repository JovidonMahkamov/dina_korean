import 'package:dina_korean_real/features/result/data/datasource/remote/result_remote_data_source.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../core/untils/logger.dart';
import '../../model/result_model.dart';

class ResultRemoteDataSourceImpl implements ResultRemoteDataSource{
  final DioClient dioClient = DioClient();


  @override
  Future<List<ResultModel>> getResult() async {
    try {
      final response = await dioClient.get(ApiUrls.result);
      if (response.statusCode == 200 || response.statusCode == 201) {
        LoggerService.info('result successful: ${response.data}');
        return (response.data as List)
            .map((e) => ResultModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        LoggerService.warning("result failed:${response.statusCode}");
        throw Exception('result failed: ${response.statusCode}');
      }
    } catch (e) {
      LoggerService.error('Error during user result: $e');
      rethrow;
    }
  }

}