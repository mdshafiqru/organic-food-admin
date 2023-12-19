import '../../../common/api.dart';
import '../../../constants/api_endpoints.dart';
import '../../../models/data_result.dart';
import '../../../models/admin.dart';

class AuthRepo {
  AuthRepo._();

  static Future<DataResult> signIn(String body) async {
    final DataResult dataResult = DataResult();

    final result = await Api.post(ApiEndPoints.login, body);

    if (result.error == null) {
      final json = result.json != null ? result.json as Map<String, dynamic> : <String, dynamic>{};

      final user = Admin.fromJson(json);

      dataResult.data = user;
    } else {
      dataResult.error = result.error;
    }

    return dataResult;
  }
}
