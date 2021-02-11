# Changelog

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
