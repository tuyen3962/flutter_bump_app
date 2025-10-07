import 'package:dio/dio.dart';
import 'package:flutter_bump_app/data/model/brand_model.dart';
import 'package:flutter_bump_app/data/remote/response/base_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'brand_api.g.dart';

@RestApi()
abstract class BrandApi {
  factory BrandApi(Dio dio, {String? baseUrl}) = _BrandApi;

  @GET('/api/brands')
  Future<PaginatedResponse<BrandModel>> getBrandList();

  @GET('/api/brands/{id}')
  Future<BaseResponse<BrandModel>> getBrandById(@Path('id') String id);
}
