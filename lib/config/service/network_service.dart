import 'package:injectable/injectable.dart';
import 'package:flutter_bump_app/config/service/provider/dio_provider.dart';
import 'package:flutter_bump_app/data/remote/authentication_api.dart';

@module
abstract class NetworkService {
  @lazySingleton
  AuthenticationAPI authenticationApiProvider(DioProvider provider) =>
      AuthenticationAPI(provider.dio);
}
