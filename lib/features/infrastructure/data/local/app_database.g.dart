// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PointsTable extends Points with TableInfo<$PointsTable, PointEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    description,
    latitude,
    longitude,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'points';
  @override
  VerificationContext validateIntegrity(
    Insertable<PointEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    } else if (isInserting) {
      context.missing(_metadataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PointEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PointEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      )!,
    );
  }

  @override
  $PointsTable createAlias(String alias) {
    return $PointsTable(attachedDatabase, alias);
  }
}

class PointEntity extends DataClass implements Insertable<PointEntity> {
  final String id;
  final String name;
  final String type;
  final String? description;
  final double latitude;
  final double longitude;

  /// Stores variable properties in JSON format.
  /// Examples: {"material_type": "concrete", "height": 12.5, "diameter": 0.3}
  /// Allows extensibility without modifying the relational schema.
  final String metadata;
  const PointEntity({
    required this.id,
    required this.name,
    required this.type,
    this.description,
    required this.latitude,
    required this.longitude,
    required this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['metadata'] = Variable<String>(metadata);
    return map;
  }

  PointsCompanion toCompanion(bool nullToAbsent) {
    return PointsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      latitude: Value(latitude),
      longitude: Value(longitude),
      metadata: Value(metadata),
    );
  }

  factory PointEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PointEntity(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      description: serializer.fromJson<String?>(json['description']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      metadata: serializer.fromJson<String>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'description': serializer.toJson<String?>(description),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'metadata': serializer.toJson<String>(metadata),
    };
  }

  PointEntity copyWith({
    String? id,
    String? name,
    String? type,
    Value<String?> description = const Value.absent(),
    double? latitude,
    double? longitude,
    String? metadata,
  }) => PointEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    description: description.present ? description.value : this.description,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    metadata: metadata ?? this.metadata,
  );
  PointEntity copyWithCompanion(PointsCompanion data) {
    return PointEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      description: data.description.present
          ? data.description.value
          : this.description,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PointEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, description, latitude, longitude, metadata);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PointEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.description == this.description &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.metadata == this.metadata);
}

class PointsCompanion extends UpdateCompanion<PointEntity> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String?> description;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> metadata;
  final Value<int> rowid;
  const PointsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PointsCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.description = const Value.absent(),
    required double latitude,
    required double longitude,
    required String metadata,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       latitude = Value(latitude),
       longitude = Value(longitude),
       metadata = Value(metadata);
  static Insertable<PointEntity> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? description,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PointsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<String?>? description,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? metadata,
    Value<int>? rowid,
  }) {
    return PointsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PointsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LinesTable extends Lines with TableInfo<$LinesTable, LineEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorHexMeta = const VerificationMeta(
    'colorHex',
  );
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
    'color_hex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    description,
    colorHex,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<LineEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('color_hex')) {
      context.handle(
        _colorHexMeta,
        colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta),
      );
    } else if (isInserting) {
      context.missing(_colorHexMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    } else if (isInserting) {
      context.missing(_metadataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LineEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LineEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      colorHex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_hex'],
      )!,
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      )!,
    );
  }

  @override
  $LinesTable createAlias(String alias) {
    return $LinesTable(attachedDatabase, alias);
  }
}

class LineEntity extends DataClass implements Insertable<LineEntity> {
  final String id;
  final String name;
  final String type;
  final String? description;

  /// Hexadecimal color format (e.g., "#FF5733") for MapLibre rendering.
  final String colorHex;

  /// Stores variable properties in JSON format.
  /// Examples: {"fiber_count": "48_fiber", "capacity_gbps": 100}
  /// Allows extensibility without modifying the relational schema.
  final String metadata;
  const LineEntity({
    required this.id,
    required this.name,
    required this.type,
    this.description,
    required this.colorHex,
    required this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['color_hex'] = Variable<String>(colorHex);
    map['metadata'] = Variable<String>(metadata);
    return map;
  }

  LinesCompanion toCompanion(bool nullToAbsent) {
    return LinesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      colorHex: Value(colorHex),
      metadata: Value(metadata),
    );
  }

  factory LineEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LineEntity(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      description: serializer.fromJson<String?>(json['description']),
      colorHex: serializer.fromJson<String>(json['colorHex']),
      metadata: serializer.fromJson<String>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'description': serializer.toJson<String?>(description),
      'colorHex': serializer.toJson<String>(colorHex),
      'metadata': serializer.toJson<String>(metadata),
    };
  }

  LineEntity copyWith({
    String? id,
    String? name,
    String? type,
    Value<String?> description = const Value.absent(),
    String? colorHex,
    String? metadata,
  }) => LineEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    description: description.present ? description.value : this.description,
    colorHex: colorHex ?? this.colorHex,
    metadata: metadata ?? this.metadata,
  );
  LineEntity copyWithCompanion(LinesCompanion data) {
    return LineEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      description: data.description.present
          ? data.description.value
          : this.description,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LineEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('colorHex: $colorHex, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, type, description, colorHex, metadata);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LineEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.description == this.description &&
          other.colorHex == this.colorHex &&
          other.metadata == this.metadata);
}

class LinesCompanion extends UpdateCompanion<LineEntity> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<String?> description;
  final Value<String> colorHex;
  final Value<String> metadata;
  final Value<int> rowid;
  const LinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.description = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LinesCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.description = const Value.absent(),
    required String colorHex,
    required String metadata,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       colorHex = Value(colorHex),
       metadata = Value(metadata);
  static Insertable<LineEntity> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? description,
    Expression<String>? colorHex,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (description != null) 'description': description,
      if (colorHex != null) 'color_hex': colorHex,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LinesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<String?>? description,
    Value<String>? colorHex,
    Value<String>? metadata,
    Value<int>? rowid,
  }) {
    return LinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      colorHex: colorHex ?? this.colorHex,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('description: $description, ')
          ..write('colorHex: $colorHex, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ComplementsTable extends Complements
    with TableInfo<$ComplementsTable, ComplementEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComplementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'complements';
  @override
  VerificationContext validateIntegrity(
    Insertable<ComplementEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ComplementEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ComplementEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ComplementsTable createAlias(String alias) {
    return $ComplementsTable(attachedDatabase, alias);
  }
}

class ComplementEntity extends DataClass
    implements Insertable<ComplementEntity> {
  final String id;
  final String name;
  const ComplementEntity({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ComplementsCompanion toCompanion(bool nullToAbsent) {
    return ComplementsCompanion(id: Value(id), name: Value(name));
  }

  factory ComplementEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ComplementEntity(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  ComplementEntity copyWith({String? id, String? name}) =>
      ComplementEntity(id: id ?? this.id, name: name ?? this.name);
  ComplementEntity copyWithCompanion(ComplementsCompanion data) {
    return ComplementEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ComplementEntity(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComplementEntity &&
          other.id == this.id &&
          other.name == this.name);
}

class ComplementsCompanion extends UpdateCompanion<ComplementEntity> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const ComplementsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ComplementsCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<ComplementEntity> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ComplementsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return ComplementsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComplementsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PointComplementsTable extends PointComplements
    with TableInfo<$PointComplementsTable, PointComplementEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PointComplementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pointIdMeta = const VerificationMeta(
    'pointId',
  );
  @override
  late final GeneratedColumn<String> pointId = GeneratedColumn<String>(
    'point_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES points (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _complementIdMeta = const VerificationMeta(
    'complementId',
  );
  @override
  late final GeneratedColumn<String> complementId = GeneratedColumn<String>(
    'complement_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES complements (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [pointId, complementId, quantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'point_complements';
  @override
  VerificationContext validateIntegrity(
    Insertable<PointComplementEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('point_id')) {
      context.handle(
        _pointIdMeta,
        pointId.isAcceptableOrUnknown(data['point_id']!, _pointIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pointIdMeta);
    }
    if (data.containsKey('complement_id')) {
      context.handle(
        _complementIdMeta,
        complementId.isAcceptableOrUnknown(
          data['complement_id']!,
          _complementIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_complementIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pointId, complementId};
  @override
  PointComplementEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PointComplementEntity(
      pointId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}point_id'],
      )!,
      complementId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}complement_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
    );
  }

  @override
  $PointComplementsTable createAlias(String alias) {
    return $PointComplementsTable(attachedDatabase, alias);
  }
}

class PointComplementEntity extends DataClass
    implements Insertable<PointComplementEntity> {
  final String pointId;
  final String complementId;
  final int quantity;
  const PointComplementEntity({
    required this.pointId,
    required this.complementId,
    required this.quantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['point_id'] = Variable<String>(pointId);
    map['complement_id'] = Variable<String>(complementId);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  PointComplementsCompanion toCompanion(bool nullToAbsent) {
    return PointComplementsCompanion(
      pointId: Value(pointId),
      complementId: Value(complementId),
      quantity: Value(quantity),
    );
  }

  factory PointComplementEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PointComplementEntity(
      pointId: serializer.fromJson<String>(json['pointId']),
      complementId: serializer.fromJson<String>(json['complementId']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pointId': serializer.toJson<String>(pointId),
      'complementId': serializer.toJson<String>(complementId),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  PointComplementEntity copyWith({
    String? pointId,
    String? complementId,
    int? quantity,
  }) => PointComplementEntity(
    pointId: pointId ?? this.pointId,
    complementId: complementId ?? this.complementId,
    quantity: quantity ?? this.quantity,
  );
  PointComplementEntity copyWithCompanion(PointComplementsCompanion data) {
    return PointComplementEntity(
      pointId: data.pointId.present ? data.pointId.value : this.pointId,
      complementId: data.complementId.present
          ? data.complementId.value
          : this.complementId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PointComplementEntity(')
          ..write('pointId: $pointId, ')
          ..write('complementId: $complementId, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pointId, complementId, quantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PointComplementEntity &&
          other.pointId == this.pointId &&
          other.complementId == this.complementId &&
          other.quantity == this.quantity);
}

class PointComplementsCompanion extends UpdateCompanion<PointComplementEntity> {
  final Value<String> pointId;
  final Value<String> complementId;
  final Value<int> quantity;
  final Value<int> rowid;
  const PointComplementsCompanion({
    this.pointId = const Value.absent(),
    this.complementId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PointComplementsCompanion.insert({
    required String pointId,
    required String complementId,
    this.quantity = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : pointId = Value(pointId),
       complementId = Value(complementId);
  static Insertable<PointComplementEntity> custom({
    Expression<String>? pointId,
    Expression<String>? complementId,
    Expression<int>? quantity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pointId != null) 'point_id': pointId,
      if (complementId != null) 'complement_id': complementId,
      if (quantity != null) 'quantity': quantity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PointComplementsCompanion copyWith({
    Value<String>? pointId,
    Value<String>? complementId,
    Value<int>? quantity,
    Value<int>? rowid,
  }) {
    return PointComplementsCompanion(
      pointId: pointId ?? this.pointId,
      complementId: complementId ?? this.complementId,
      quantity: quantity ?? this.quantity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pointId.present) {
      map['point_id'] = Variable<String>(pointId.value);
    }
    if (complementId.present) {
      map['complement_id'] = Variable<String>(complementId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PointComplementsCompanion(')
          ..write('pointId: $pointId, ')
          ..write('complementId: $complementId, ')
          ..write('quantity: $quantity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LineRoutesTable extends LineRoutes
    with TableInfo<$LineRoutesTable, LineRouteEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LineRoutesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _lineIdMeta = const VerificationMeta('lineId');
  @override
  late final GeneratedColumn<String> lineId = GeneratedColumn<String>(
    'line_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lines (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pointIdMeta = const VerificationMeta(
    'pointId',
  );
  @override
  late final GeneratedColumn<String> pointId = GeneratedColumn<String>(
    'point_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES points (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [lineId, pointId, order];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'line_routes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LineRouteEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('line_id')) {
      context.handle(
        _lineIdMeta,
        lineId.isAcceptableOrUnknown(data['line_id']!, _lineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lineIdMeta);
    }
    if (data.containsKey('point_id')) {
      context.handle(
        _pointIdMeta,
        pointId.isAcceptableOrUnknown(data['point_id']!, _pointIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pointIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {lineId, pointId};
  @override
  LineRouteEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LineRouteEntity(
      lineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}line_id'],
      )!,
      pointId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}point_id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
    );
  }

  @override
  $LineRoutesTable createAlias(String alias) {
    return $LineRoutesTable(attachedDatabase, alias);
  }
}

class LineRouteEntity extends DataClass implements Insertable<LineRouteEntity> {
  final String lineId;
  final String pointId;

  /// Sequential order of the point in the cable route (1, 2, 3, ...).
  /// CRITICAL: This value determines the LineString geometry in GeoJSON.
  final int order;
  const LineRouteEntity({
    required this.lineId,
    required this.pointId,
    required this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['line_id'] = Variable<String>(lineId);
    map['point_id'] = Variable<String>(pointId);
    map['order'] = Variable<int>(order);
    return map;
  }

  LineRoutesCompanion toCompanion(bool nullToAbsent) {
    return LineRoutesCompanion(
      lineId: Value(lineId),
      pointId: Value(pointId),
      order: Value(order),
    );
  }

  factory LineRouteEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LineRouteEntity(
      lineId: serializer.fromJson<String>(json['lineId']),
      pointId: serializer.fromJson<String>(json['pointId']),
      order: serializer.fromJson<int>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lineId': serializer.toJson<String>(lineId),
      'pointId': serializer.toJson<String>(pointId),
      'order': serializer.toJson<int>(order),
    };
  }

  LineRouteEntity copyWith({String? lineId, String? pointId, int? order}) =>
      LineRouteEntity(
        lineId: lineId ?? this.lineId,
        pointId: pointId ?? this.pointId,
        order: order ?? this.order,
      );
  LineRouteEntity copyWithCompanion(LineRoutesCompanion data) {
    return LineRouteEntity(
      lineId: data.lineId.present ? data.lineId.value : this.lineId,
      pointId: data.pointId.present ? data.pointId.value : this.pointId,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LineRouteEntity(')
          ..write('lineId: $lineId, ')
          ..write('pointId: $pointId, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(lineId, pointId, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LineRouteEntity &&
          other.lineId == this.lineId &&
          other.pointId == this.pointId &&
          other.order == this.order);
}

class LineRoutesCompanion extends UpdateCompanion<LineRouteEntity> {
  final Value<String> lineId;
  final Value<String> pointId;
  final Value<int> order;
  final Value<int> rowid;
  const LineRoutesCompanion({
    this.lineId = const Value.absent(),
    this.pointId = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LineRoutesCompanion.insert({
    required String lineId,
    required String pointId,
    required int order,
    this.rowid = const Value.absent(),
  }) : lineId = Value(lineId),
       pointId = Value(pointId),
       order = Value(order);
  static Insertable<LineRouteEntity> custom({
    Expression<String>? lineId,
    Expression<String>? pointId,
    Expression<int>? order,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (lineId != null) 'line_id': lineId,
      if (pointId != null) 'point_id': pointId,
      if (order != null) 'order': order,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LineRoutesCompanion copyWith({
    Value<String>? lineId,
    Value<String>? pointId,
    Value<int>? order,
    Value<int>? rowid,
  }) {
    return LineRoutesCompanion(
      lineId: lineId ?? this.lineId,
      pointId: pointId ?? this.pointId,
      order: order ?? this.order,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lineId.present) {
      map['line_id'] = Variable<String>(lineId.value);
    }
    if (pointId.present) {
      map['point_id'] = Variable<String>(pointId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LineRoutesCompanion(')
          ..write('lineId: $lineId, ')
          ..write('pointId: $pointId, ')
          ..write('order: $order, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PointsTable points = $PointsTable(this);
  late final $LinesTable lines = $LinesTable(this);
  late final $ComplementsTable complements = $ComplementsTable(this);
  late final $PointComplementsTable pointComplements = $PointComplementsTable(
    this,
  );
  late final $LineRoutesTable lineRoutes = $LineRoutesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    points,
    lines,
    complements,
    pointComplements,
    lineRoutes,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'complements',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('point_complements', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'lines',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('line_routes', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PointsTableCreateCompanionBuilder =
    PointsCompanion Function({
      required String id,
      required String name,
      required String type,
      Value<String?> description,
      required double latitude,
      required double longitude,
      required String metadata,
      Value<int> rowid,
    });
typedef $$PointsTableUpdateCompanionBuilder =
    PointsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<String?> description,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> metadata,
      Value<int> rowid,
    });

final class $$PointsTableReferences
    extends BaseReferences<_$AppDatabase, $PointsTable, PointEntity> {
  $$PointsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $PointComplementsTable,
    List<PointComplementEntity>
  >
  _pointComplementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pointComplements,
    aliasName: $_aliasNameGenerator(db.points.id, db.pointComplements.pointId),
  );

  $$PointComplementsTableProcessedTableManager get pointComplementsRefs {
    final manager = $$PointComplementsTableTableManager(
      $_db,
      $_db.pointComplements,
    ).filter((f) => f.pointId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pointComplementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LineRoutesTable, List<LineRouteEntity>>
  _lineRoutesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.lineRoutes,
    aliasName: $_aliasNameGenerator(db.points.id, db.lineRoutes.pointId),
  );

  $$LineRoutesTableProcessedTableManager get lineRoutesRefs {
    final manager = $$LineRoutesTableTableManager(
      $_db,
      $_db.lineRoutes,
    ).filter((f) => f.pointId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_lineRoutesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PointsTableFilterComposer
    extends Composer<_$AppDatabase, $PointsTable> {
  $$PointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pointComplementsRefs(
    Expression<bool> Function($$PointComplementsTableFilterComposer f) f,
  ) {
    final $$PointComplementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pointComplements,
      getReferencedColumn: (t) => t.pointId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointComplementsTableFilterComposer(
            $db: $db,
            $table: $db.pointComplements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> lineRoutesRefs(
    Expression<bool> Function($$LineRoutesTableFilterComposer f) f,
  ) {
    final $$LineRoutesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lineRoutes,
      getReferencedColumn: (t) => t.pointId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LineRoutesTableFilterComposer(
            $db: $db,
            $table: $db.lineRoutes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PointsTableOrderingComposer
    extends Composer<_$AppDatabase, $PointsTable> {
  $$PointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PointsTable> {
  $$PointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  Expression<T> pointComplementsRefs<T extends Object>(
    Expression<T> Function($$PointComplementsTableAnnotationComposer a) f,
  ) {
    final $$PointComplementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pointComplements,
      getReferencedColumn: (t) => t.pointId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointComplementsTableAnnotationComposer(
            $db: $db,
            $table: $db.pointComplements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> lineRoutesRefs<T extends Object>(
    Expression<T> Function($$LineRoutesTableAnnotationComposer a) f,
  ) {
    final $$LineRoutesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lineRoutes,
      getReferencedColumn: (t) => t.pointId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LineRoutesTableAnnotationComposer(
            $db: $db,
            $table: $db.lineRoutes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PointsTable,
          PointEntity,
          $$PointsTableFilterComposer,
          $$PointsTableOrderingComposer,
          $$PointsTableAnnotationComposer,
          $$PointsTableCreateCompanionBuilder,
          $$PointsTableUpdateCompanionBuilder,
          (PointEntity, $$PointsTableReferences),
          PointEntity,
          PrefetchHooks Function({
            bool pointComplementsRefs,
            bool lineRoutesRefs,
          })
        > {
  $$PointsTableTableManager(_$AppDatabase db, $PointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PointsCompanion(
                id: id,
                name: name,
                type: type,
                description: description,
                latitude: latitude,
                longitude: longitude,
                metadata: metadata,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                Value<String?> description = const Value.absent(),
                required double latitude,
                required double longitude,
                required String metadata,
                Value<int> rowid = const Value.absent(),
              }) => PointsCompanion.insert(
                id: id,
                name: name,
                type: type,
                description: description,
                latitude: latitude,
                longitude: longitude,
                metadata: metadata,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PointsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({pointComplementsRefs = false, lineRoutesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pointComplementsRefs) db.pointComplements,
                    if (lineRoutesRefs) db.lineRoutes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pointComplementsRefs)
                        await $_getPrefetchedData<
                          PointEntity,
                          $PointsTable,
                          PointComplementEntity
                        >(
                          currentTable: table,
                          referencedTable: $$PointsTableReferences
                              ._pointComplementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PointsTableReferences(
                                db,
                                table,
                                p0,
                              ).pointComplementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pointId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (lineRoutesRefs)
                        await $_getPrefetchedData<
                          PointEntity,
                          $PointsTable,
                          LineRouteEntity
                        >(
                          currentTable: table,
                          referencedTable: $$PointsTableReferences
                              ._lineRoutesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PointsTableReferences(
                                db,
                                table,
                                p0,
                              ).lineRoutesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pointId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PointsTable,
      PointEntity,
      $$PointsTableFilterComposer,
      $$PointsTableOrderingComposer,
      $$PointsTableAnnotationComposer,
      $$PointsTableCreateCompanionBuilder,
      $$PointsTableUpdateCompanionBuilder,
      (PointEntity, $$PointsTableReferences),
      PointEntity,
      PrefetchHooks Function({bool pointComplementsRefs, bool lineRoutesRefs})
    >;
typedef $$LinesTableCreateCompanionBuilder =
    LinesCompanion Function({
      required String id,
      required String name,
      required String type,
      Value<String?> description,
      required String colorHex,
      required String metadata,
      Value<int> rowid,
    });
typedef $$LinesTableUpdateCompanionBuilder =
    LinesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<String?> description,
      Value<String> colorHex,
      Value<String> metadata,
      Value<int> rowid,
    });

final class $$LinesTableReferences
    extends BaseReferences<_$AppDatabase, $LinesTable, LineEntity> {
  $$LinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LineRoutesTable, List<LineRouteEntity>>
  _lineRoutesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.lineRoutes,
    aliasName: $_aliasNameGenerator(db.lines.id, db.lineRoutes.lineId),
  );

  $$LineRoutesTableProcessedTableManager get lineRoutesRefs {
    final manager = $$LineRoutesTableTableManager(
      $_db,
      $_db.lineRoutes,
    ).filter((f) => f.lineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_lineRoutesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LinesTableFilterComposer extends Composer<_$AppDatabase, $LinesTable> {
  $$LinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> lineRoutesRefs(
    Expression<bool> Function($$LineRoutesTableFilterComposer f) f,
  ) {
    final $$LineRoutesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lineRoutes,
      getReferencedColumn: (t) => t.lineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LineRoutesTableFilterComposer(
            $db: $db,
            $table: $db.lineRoutes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LinesTableOrderingComposer
    extends Composer<_$AppDatabase, $LinesTable> {
  $$LinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorHex => $composableBuilder(
    column: $table.colorHex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LinesTable> {
  $$LinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get colorHex =>
      $composableBuilder(column: $table.colorHex, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  Expression<T> lineRoutesRefs<T extends Object>(
    Expression<T> Function($$LineRoutesTableAnnotationComposer a) f,
  ) {
    final $$LineRoutesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lineRoutes,
      getReferencedColumn: (t) => t.lineId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LineRoutesTableAnnotationComposer(
            $db: $db,
            $table: $db.lineRoutes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LinesTable,
          LineEntity,
          $$LinesTableFilterComposer,
          $$LinesTableOrderingComposer,
          $$LinesTableAnnotationComposer,
          $$LinesTableCreateCompanionBuilder,
          $$LinesTableUpdateCompanionBuilder,
          (LineEntity, $$LinesTableReferences),
          LineEntity,
          PrefetchHooks Function({bool lineRoutesRefs})
        > {
  $$LinesTableTableManager(_$AppDatabase db, $LinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> colorHex = const Value.absent(),
                Value<String> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LinesCompanion(
                id: id,
                name: name,
                type: type,
                description: description,
                colorHex: colorHex,
                metadata: metadata,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                Value<String?> description = const Value.absent(),
                required String colorHex,
                required String metadata,
                Value<int> rowid = const Value.absent(),
              }) => LinesCompanion.insert(
                id: id,
                name: name,
                type: type,
                description: description,
                colorHex: colorHex,
                metadata: metadata,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$LinesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({lineRoutesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (lineRoutesRefs) db.lineRoutes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (lineRoutesRefs)
                    await $_getPrefetchedData<
                      LineEntity,
                      $LinesTable,
                      LineRouteEntity
                    >(
                      currentTable: table,
                      referencedTable: $$LinesTableReferences
                          ._lineRoutesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$LinesTableReferences(db, table, p0).lineRoutesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.lineId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$LinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LinesTable,
      LineEntity,
      $$LinesTableFilterComposer,
      $$LinesTableOrderingComposer,
      $$LinesTableAnnotationComposer,
      $$LinesTableCreateCompanionBuilder,
      $$LinesTableUpdateCompanionBuilder,
      (LineEntity, $$LinesTableReferences),
      LineEntity,
      PrefetchHooks Function({bool lineRoutesRefs})
    >;
typedef $$ComplementsTableCreateCompanionBuilder =
    ComplementsCompanion Function({
      required String id,
      required String name,
      Value<int> rowid,
    });
typedef $$ComplementsTableUpdateCompanionBuilder =
    ComplementsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> rowid,
    });

final class $$ComplementsTableReferences
    extends BaseReferences<_$AppDatabase, $ComplementsTable, ComplementEntity> {
  $$ComplementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $PointComplementsTable,
    List<PointComplementEntity>
  >
  _pointComplementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pointComplements,
    aliasName: $_aliasNameGenerator(
      db.complements.id,
      db.pointComplements.complementId,
    ),
  );

  $$PointComplementsTableProcessedTableManager get pointComplementsRefs {
    final manager = $$PointComplementsTableTableManager(
      $_db,
      $_db.pointComplements,
    ).filter((f) => f.complementId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pointComplementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ComplementsTableFilterComposer
    extends Composer<_$AppDatabase, $ComplementsTable> {
  $$ComplementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pointComplementsRefs(
    Expression<bool> Function($$PointComplementsTableFilterComposer f) f,
  ) {
    final $$PointComplementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pointComplements,
      getReferencedColumn: (t) => t.complementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointComplementsTableFilterComposer(
            $db: $db,
            $table: $db.pointComplements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ComplementsTableOrderingComposer
    extends Composer<_$AppDatabase, $ComplementsTable> {
  $$ComplementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ComplementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ComplementsTable> {
  $$ComplementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> pointComplementsRefs<T extends Object>(
    Expression<T> Function($$PointComplementsTableAnnotationComposer a) f,
  ) {
    final $$PointComplementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pointComplements,
      getReferencedColumn: (t) => t.complementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointComplementsTableAnnotationComposer(
            $db: $db,
            $table: $db.pointComplements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ComplementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ComplementsTable,
          ComplementEntity,
          $$ComplementsTableFilterComposer,
          $$ComplementsTableOrderingComposer,
          $$ComplementsTableAnnotationComposer,
          $$ComplementsTableCreateCompanionBuilder,
          $$ComplementsTableUpdateCompanionBuilder,
          (ComplementEntity, $$ComplementsTableReferences),
          ComplementEntity,
          PrefetchHooks Function({bool pointComplementsRefs})
        > {
  $$ComplementsTableTableManager(_$AppDatabase db, $ComplementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ComplementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ComplementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ComplementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ComplementsCompanion(id: id, name: name, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) =>
                  ComplementsCompanion.insert(id: id, name: name, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ComplementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pointComplementsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (pointComplementsRefs) db.pointComplements,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (pointComplementsRefs)
                    await $_getPrefetchedData<
                      ComplementEntity,
                      $ComplementsTable,
                      PointComplementEntity
                    >(
                      currentTable: table,
                      referencedTable: $$ComplementsTableReferences
                          ._pointComplementsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ComplementsTableReferences(
                            db,
                            table,
                            p0,
                          ).pointComplementsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.complementId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ComplementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ComplementsTable,
      ComplementEntity,
      $$ComplementsTableFilterComposer,
      $$ComplementsTableOrderingComposer,
      $$ComplementsTableAnnotationComposer,
      $$ComplementsTableCreateCompanionBuilder,
      $$ComplementsTableUpdateCompanionBuilder,
      (ComplementEntity, $$ComplementsTableReferences),
      ComplementEntity,
      PrefetchHooks Function({bool pointComplementsRefs})
    >;
typedef $$PointComplementsTableCreateCompanionBuilder =
    PointComplementsCompanion Function({
      required String pointId,
      required String complementId,
      Value<int> quantity,
      Value<int> rowid,
    });
typedef $$PointComplementsTableUpdateCompanionBuilder =
    PointComplementsCompanion Function({
      Value<String> pointId,
      Value<String> complementId,
      Value<int> quantity,
      Value<int> rowid,
    });

final class $$PointComplementsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PointComplementsTable,
          PointComplementEntity
        > {
  $$PointComplementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PointsTable _pointIdTable(_$AppDatabase db) => db.points.createAlias(
    $_aliasNameGenerator(db.pointComplements.pointId, db.points.id),
  );

  $$PointsTableProcessedTableManager get pointId {
    final $_column = $_itemColumn<String>('point_id')!;

    final manager = $$PointsTableTableManager(
      $_db,
      $_db.points,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pointIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ComplementsTable _complementIdTable(_$AppDatabase db) =>
      db.complements.createAlias(
        $_aliasNameGenerator(
          db.pointComplements.complementId,
          db.complements.id,
        ),
      );

  $$ComplementsTableProcessedTableManager get complementId {
    final $_column = $_itemColumn<String>('complement_id')!;

    final manager = $$ComplementsTableTableManager(
      $_db,
      $_db.complements,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_complementIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PointComplementsTableFilterComposer
    extends Composer<_$AppDatabase, $PointComplementsTable> {
  $$PointComplementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  $$PointsTableFilterComposer get pointId {
    final $$PointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.points,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointsTableFilterComposer(
            $db: $db,
            $table: $db.points,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ComplementsTableFilterComposer get complementId {
    final $$ComplementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.complementId,
      referencedTable: $db.complements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComplementsTableFilterComposer(
            $db: $db,
            $table: $db.complements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PointComplementsTableOrderingComposer
    extends Composer<_$AppDatabase, $PointComplementsTable> {
  $$PointComplementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  $$PointsTableOrderingComposer get pointId {
    final $$PointsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.points,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointsTableOrderingComposer(
            $db: $db,
            $table: $db.points,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ComplementsTableOrderingComposer get complementId {
    final $$ComplementsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.complementId,
      referencedTable: $db.complements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComplementsTableOrderingComposer(
            $db: $db,
            $table: $db.complements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PointComplementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PointComplementsTable> {
  $$PointComplementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  $$PointsTableAnnotationComposer get pointId {
    final $$PointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.points,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointsTableAnnotationComposer(
            $db: $db,
            $table: $db.points,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ComplementsTableAnnotationComposer get complementId {
    final $$ComplementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.complementId,
      referencedTable: $db.complements,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComplementsTableAnnotationComposer(
            $db: $db,
            $table: $db.complements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PointComplementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PointComplementsTable,
          PointComplementEntity,
          $$PointComplementsTableFilterComposer,
          $$PointComplementsTableOrderingComposer,
          $$PointComplementsTableAnnotationComposer,
          $$PointComplementsTableCreateCompanionBuilder,
          $$PointComplementsTableUpdateCompanionBuilder,
          (PointComplementEntity, $$PointComplementsTableReferences),
          PointComplementEntity,
          PrefetchHooks Function({bool pointId, bool complementId})
        > {
  $$PointComplementsTableTableManager(
    _$AppDatabase db,
    $PointComplementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PointComplementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PointComplementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PointComplementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> pointId = const Value.absent(),
                Value<String> complementId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PointComplementsCompanion(
                pointId: pointId,
                complementId: complementId,
                quantity: quantity,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String pointId,
                required String complementId,
                Value<int> quantity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PointComplementsCompanion.insert(
                pointId: pointId,
                complementId: complementId,
                quantity: quantity,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PointComplementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pointId = false, complementId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pointId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pointId,
                                referencedTable:
                                    $$PointComplementsTableReferences
                                        ._pointIdTable(db),
                                referencedColumn:
                                    $$PointComplementsTableReferences
                                        ._pointIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (complementId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.complementId,
                                referencedTable:
                                    $$PointComplementsTableReferences
                                        ._complementIdTable(db),
                                referencedColumn:
                                    $$PointComplementsTableReferences
                                        ._complementIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PointComplementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PointComplementsTable,
      PointComplementEntity,
      $$PointComplementsTableFilterComposer,
      $$PointComplementsTableOrderingComposer,
      $$PointComplementsTableAnnotationComposer,
      $$PointComplementsTableCreateCompanionBuilder,
      $$PointComplementsTableUpdateCompanionBuilder,
      (PointComplementEntity, $$PointComplementsTableReferences),
      PointComplementEntity,
      PrefetchHooks Function({bool pointId, bool complementId})
    >;
typedef $$LineRoutesTableCreateCompanionBuilder =
    LineRoutesCompanion Function({
      required String lineId,
      required String pointId,
      required int order,
      Value<int> rowid,
    });
typedef $$LineRoutesTableUpdateCompanionBuilder =
    LineRoutesCompanion Function({
      Value<String> lineId,
      Value<String> pointId,
      Value<int> order,
      Value<int> rowid,
    });

final class $$LineRoutesTableReferences
    extends BaseReferences<_$AppDatabase, $LineRoutesTable, LineRouteEntity> {
  $$LineRoutesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LinesTable _lineIdTable(_$AppDatabase db) => db.lines.createAlias(
    $_aliasNameGenerator(db.lineRoutes.lineId, db.lines.id),
  );

  $$LinesTableProcessedTableManager get lineId {
    final $_column = $_itemColumn<String>('line_id')!;

    final manager = $$LinesTableTableManager(
      $_db,
      $_db.lines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PointsTable _pointIdTable(_$AppDatabase db) => db.points.createAlias(
    $_aliasNameGenerator(db.lineRoutes.pointId, db.points.id),
  );

  $$PointsTableProcessedTableManager get pointId {
    final $_column = $_itemColumn<String>('point_id')!;

    final manager = $$PointsTableTableManager(
      $_db,
      $_db.points,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pointIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LineRoutesTableFilterComposer
    extends Composer<_$AppDatabase, $LineRoutesTable> {
  $$LineRoutesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$LinesTableFilterComposer get lineId {
    final $$LinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lineId,
      referencedTable: $db.lines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LinesTableFilterComposer(
            $db: $db,
            $table: $db.lines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PointsTableFilterComposer get pointId {
    final $$PointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.points,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointsTableFilterComposer(
            $db: $db,
            $table: $db.points,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LineRoutesTableOrderingComposer
    extends Composer<_$AppDatabase, $LineRoutesTable> {
  $$LineRoutesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$LinesTableOrderingComposer get lineId {
    final $$LinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lineId,
      referencedTable: $db.lines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LinesTableOrderingComposer(
            $db: $db,
            $table: $db.lines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PointsTableOrderingComposer get pointId {
    final $$PointsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.points,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointsTableOrderingComposer(
            $db: $db,
            $table: $db.points,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LineRoutesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LineRoutesTable> {
  $$LineRoutesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$LinesTableAnnotationComposer get lineId {
    final $$LinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lineId,
      referencedTable: $db.lines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LinesTableAnnotationComposer(
            $db: $db,
            $table: $db.lines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PointsTableAnnotationComposer get pointId {
    final $$PointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.points,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointsTableAnnotationComposer(
            $db: $db,
            $table: $db.points,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LineRoutesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LineRoutesTable,
          LineRouteEntity,
          $$LineRoutesTableFilterComposer,
          $$LineRoutesTableOrderingComposer,
          $$LineRoutesTableAnnotationComposer,
          $$LineRoutesTableCreateCompanionBuilder,
          $$LineRoutesTableUpdateCompanionBuilder,
          (LineRouteEntity, $$LineRoutesTableReferences),
          LineRouteEntity,
          PrefetchHooks Function({bool lineId, bool pointId})
        > {
  $$LineRoutesTableTableManager(_$AppDatabase db, $LineRoutesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LineRoutesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LineRoutesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LineRoutesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> lineId = const Value.absent(),
                Value<String> pointId = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LineRoutesCompanion(
                lineId: lineId,
                pointId: pointId,
                order: order,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String lineId,
                required String pointId,
                required int order,
                Value<int> rowid = const Value.absent(),
              }) => LineRoutesCompanion.insert(
                lineId: lineId,
                pointId: pointId,
                order: order,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LineRoutesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lineId = false, pointId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (lineId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lineId,
                                referencedTable: $$LineRoutesTableReferences
                                    ._lineIdTable(db),
                                referencedColumn: $$LineRoutesTableReferences
                                    ._lineIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (pointId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pointId,
                                referencedTable: $$LineRoutesTableReferences
                                    ._pointIdTable(db),
                                referencedColumn: $$LineRoutesTableReferences
                                    ._pointIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LineRoutesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LineRoutesTable,
      LineRouteEntity,
      $$LineRoutesTableFilterComposer,
      $$LineRoutesTableOrderingComposer,
      $$LineRoutesTableAnnotationComposer,
      $$LineRoutesTableCreateCompanionBuilder,
      $$LineRoutesTableUpdateCompanionBuilder,
      (LineRouteEntity, $$LineRoutesTableReferences),
      LineRouteEntity,
      PrefetchHooks Function({bool lineId, bool pointId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PointsTableTableManager get points =>
      $$PointsTableTableManager(_db, _db.points);
  $$LinesTableTableManager get lines =>
      $$LinesTableTableManager(_db, _db.lines);
  $$ComplementsTableTableManager get complements =>
      $$ComplementsTableTableManager(_db, _db.complements);
  $$PointComplementsTableTableManager get pointComplements =>
      $$PointComplementsTableTableManager(_db, _db.pointComplements);
  $$LineRoutesTableTableManager get lineRoutes =>
      $$LineRoutesTableTableManager(_db, _db.lineRoutes);
}
