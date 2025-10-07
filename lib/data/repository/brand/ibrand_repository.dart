import 'package:flutter_bump_app/data/model/brand_model.dart';
import 'package:flutter_bump_app/data/repository/ibase_repository.dart';

abstract class IBrandRepository extends IBaseRepository {
  Future<List<BrandModel>> getBrandList();
  Future<BrandModel> getBrandById(String id);
}
