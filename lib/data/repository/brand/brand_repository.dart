import 'package:flutter_bump_app/data/model/brand_model.dart';
import 'package:flutter_bump_app/data/remote/brand_api.dart';
import 'package:flutter_bump_app/data/repository/brand/ibrand_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IBrandRepository)
class BrandRepository extends IBrandRepository {
  final BrandApi brandApi;

  BrandRepository(this.brandApi);

  @override
  Future<BrandModel> getBrandById(String id) async {
    final response = await brandApi.getBrandById(id);
    if (response.isSuccess) {
      return response.data!;
    }
    throw Exception(response.message);
  }

  @override
  Future<List<BrandModel>> getBrandList() async {
    final response = await brandApi.getBrandList();
    return response.data ?? <BrandModel>[];
  }
}
