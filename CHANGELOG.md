# Changelog

## v3.0.0 - 2025-05-11

- Migrate dependencies and increase the minimum version required of Dart SDK ([#18](https://github.com/bahung1221/dart-vector-tile/pull/20)). Thanks to @DanielBerrioB .

## v2.0.1 - 2025-05-11

- Fix zigZagDecode for JS targets ([#18](https://github.com/bahung1221/dart-vector-tile/pull/18)). Thanks to @mutagene .

## v2.0.0 - 2023-09-7

- Updated dependencies

## v1.0.0 - 2022-07-28

- Add web platform support ([#10](https://github.com/saigontek/dart-vector-tile/pull/10)).

**Breaking changes**:
- Remove `VectorTile.fromPath`, `encodeVectorTile`, `decodeVectorTile` methods. (Read the migrate guide below to update your code).

**Migrate guide**:
- `VectorTile.fromPath`:

```dart
// Old
final tile = await VectorTile.fromPath(path: '../data/sample-12-3262-1923.pbf');

// New
final tileData = await File('../data/sample-12-3262-1923.pbf').readAsBytes();
final tile = await VectorTile.fromBytes(bytes: tileData);
```

- `encodeVectorTile`:

```dart
// Old
await encodeVectorTile(path: './gen/tile.pbf', tile: tile);

// New
await File('./gen/tile.pbf').writeAsBytes(tile.writeToBuffer());
```

- `decodeVectorTile`:

```dart
// Old
final tile = decodeVectorTile(path: '../data/sample-12-3262-1923.pbf')

// New
final tileData = await File('../data/sample-12-3262-1923.pbf').readAsBytes();
final tile = await VectorTile.fromBuffer(tileData)
```

## v0.3.2 - 2022-01-21

- (Improvement memory usage) Use fixed size lists instead of growable lists. 
([#8](https://github.com/saigontek/dart-vector-tile/pull/8)).

## v0.3.1 - 2022-01-03

- (Improvement memory usage) Change data structure for VectorTileValue. 
([#7](https://github.com/saigontek/dart-vector-tile/pull/7)).

## v0.3.0 - 2022-01-01

- (Breaking change - Improvement memory usage) Change data type for feature's properties from List<Map> to Map 
([#6](https://github.com/saigontek/dart-vector-tile/pull/6)).

## v0.2.2 - 2021-05-29

- Avoid decoding geometry more than once ([#5](https://github.com/saigontek/dart-vector-tile/pull/5)).

## v0.2.1 - 2021-05-28

- Add support reading tiles from buffer ([#4](https://github.com/saigontek/dart-vector-tile/pull/4)).

## v0.2.0 - 2021-05-27

- Add support for null-safety ([#3](https://github.com/saigontek/dart-vector-tile/pull/3)).

## v0.1.6 - 2021-04-14

- Add check data type for `layer values` when converting data from raw layer.

## v0.1.5 - 2021-02-13

- Update linter rules.


## v0.1.4 - 2021-02-13

### Added
- Add generic type to `GeoJson` class. 


## v0.1.3 - 2021-02-12

### Added
- Add `toGeoJson` method on `VectorTile` class to allow decode raw VectorTile format to GeoJson FeatureCollection.

### Fixed
- Fix type issues when call `map` method on `List` that returned a Iterator instead of a new List.

## v0.1.2 - 2021-02-12

### Fixed
- Change namespace import from `PascalCase` to `snake_case`.


## v0.1.1 - 2021-02-12

### Added
- Add properties decode for feature GeoJson.


## v0.1.0 - 2021-02-11

### BREAKING CHANGE
- Split all to two type of classes: `raw vector tile` and `vector tile`.
- Add support for decode feature geometry.
- Add support for convert raw feature to GeoJson (only Feature type).


## v0.0.2 - 2021-02-10

### Added
- @required annotion to `createVectorTileFeature` and `createVectorTileLayer` based on specification


## v0.0.1 - 2021-02-09

### Added
- Generate VectorTile classes from protobuf spec.
- Encode functionality.
- Decode functionality.
