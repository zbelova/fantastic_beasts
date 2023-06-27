// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'data/model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(2, 6206756745585525206),
      name: 'FantasticBeastEntity',
      lastPropertyId: const IdUid(4, 7241446619586361803),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1014911260775790697),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8447301714987169127),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2719976736483456651),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7241446619586361803),
            name: 'photo',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 6206756745585525206),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [4004239130023184414],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        5026648474596723539,
        9082763696746806527,
        8108398681810990192,
        3139781289194274852
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    FantasticBeastEntity: EntityDefinition<FantasticBeastEntity>(
        model: _entities[0],
        toOneRelations: (FantasticBeastEntity object) => [],
        toManyRelations: (FantasticBeastEntity object) => {},
        getId: (FantasticBeastEntity object) => object.id,
        setId: (FantasticBeastEntity object, int id) {
          object.id = id;
        },
        objectToFB: (FantasticBeastEntity object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final descriptionOffset = fbb.writeString(object.description);
          final photoOffset = fbb.writeString(object.photo);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, descriptionOffset);
          fbb.addOffset(3, photoOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = FantasticBeastEntity(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              description: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              photo: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [FantasticBeastEntity] entity fields to define ObjectBox queries.
class FantasticBeastEntity_ {
  /// see [FantasticBeastEntity.id]
  static final id =
      QueryIntegerProperty<FantasticBeastEntity>(_entities[0].properties[0]);

  /// see [FantasticBeastEntity.name]
  static final name =
      QueryStringProperty<FantasticBeastEntity>(_entities[0].properties[1]);

  /// see [FantasticBeastEntity.description]
  static final description =
      QueryStringProperty<FantasticBeastEntity>(_entities[0].properties[2]);

  /// see [FantasticBeastEntity.photo]
  static final photo =
      QueryStringProperty<FantasticBeastEntity>(_entities[0].properties[3]);
}