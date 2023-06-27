import 'package:hw15/data/model.dart';

import '../objectbox.g.dart';

class FantasticBeastsRepository {
  final Box<FantasticBeastEntity> box;

  FantasticBeastsRepository(this.box);

  Future<void> addBeast({
    required String name,
    required String description,
    required String photo,
  }) async {
    final entity = FantasticBeastEntity(name: name, description: description, photo: photo);
    await box.putAsync(entity);
  }

  Future<List<FantasticBeastEntity>> getBeasts() async {
    return await box.getAllAsync();
  }

  Future<void> removeBeast(int id) async {
    await box.removeAsync(id);
  }

  Future<void> updateBeast({
    required int id,
    required String name,
    required String description,
    required String photo,
  }) async {
    FantasticBeastEntity entity = FantasticBeastEntity(id: id, name: name, description: description, photo: photo);
    await box.putAsync(entity);
  }
}
