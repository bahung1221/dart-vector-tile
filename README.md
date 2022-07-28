## Dart Vector Tile
Package to `encode & decode` vector tiles. A implementation of [Mapbox Vector Tile specification 2.1](https://github.com/mapbox/vector-tile-spec).

Features:
- [x] Parse `.mvt`/`.pbf` file to raw vector tile format.
- [x] Decode raw vector tile feature to GeoJson format (only GeoJson Feature type).
- [x] Decode raw vector tile to GeoJson FeatureCollection format.
- [x] Encode & create vector tile file from raw format data.
- [ ] Encode & create vector tile file from GeoJson format data. (TODO)

### Parse & Decode
Parse and then decode each feature to GeoJson from a vector tile file, 
either `.pbf` or `.mvt` should work:

```dart
import 'vector_tile/vector_tile.dart';

main() async {
  final tileData = await File('../data/sample-12-3262-1923.pbf').readAsBytes();
  final tile = await VectorTile.fromBytes(bytes: tileData);
  final layer = tile.layers.firstWhere((layer) => layer.name == 'transportation');

  layer.features.forEach((feature) {
    // Geometry will be decode on-demand to avoid redundant calculating
    feature.decodeGeometry();

    // Each GeometryType will have different geometry data format
    // So we must explicit check GeometryType and specific generic type here
    if (feature.geometryType == GeometryType.Point) {
      var geojson = feature.toGeoJson<GeoJsonPoint>(x: 3262, y: 1923, z: 12);

      print(geojson?.properties);
      print(geojson?.geometry?.coordinates);
    }
  })
}
```

We also can decode feature to GeoJson data first and explicit cast the type later, there are more examples code in [example folder](example/lib/main.dart).

[Sample VectorTile fields](#sample-vectortile-raw-decoded-as-json)

### Encode
Create VectorTile from raw data and then encode it into protobuf file:

```dart
import 'package:vector_tile/raw/raw_vector_tile.dart';

main() async {
  var values = [
    createVectorTileValue(intValue: Int64(65)),
    createVectorTileValue(stringValue: 'basketball'),
  ];

  var features = [
      createVectorTileFeature(
        id: Int64(31162829580),
        tags: [0, 96, 1, 348],
        type: VectorTile_GeomType.POINT,
        geometry: [9, 8058, 1562],
      ),
  ];

  var layers = [
    createVectorTileLayer(
      name: 'building',
      extent: 4096,
      version: 2,
      keys: ['render_height', 'render_min_height'],
      values: values,
      features: features,
    ),
  ];

  var tile = createVectorTile(layers: layers);

  // Save to disk
  await File('./gen/tile.pbf').writeAsBytes(tile.writeToBuffer());
}
```

### API
**Class VectorTile**:

- `T toGeoJson<T extends GeoJson>({int x, int y, int z})`: Convert `VectorTile` to a `GeoJson FeatureCollection`. each Feature inside will include **lon/lat** coordinates calculating and will have generic type of [GeoJson class](lib/util/geo_json.dart) 
because each geometry type will have different coordinates format. So you must given an explicit GeoJson type or do a type cast here (See decode example above).


**Class VectorTileFeature**:

- `decodeGeometry()`: Decode geometry data from raw data, this data also will be used later when we call `getGeoJson` method.
- `T toGeoJson<T extends GeoJson>({int x, int y, int z})`: Convert `VectorTile Feature` to `GeoJson Feature` format include **lon/lat** coordinates calculating, this method will return generic type of [GeoJson class](lib/util/geo_json.dart) 
because each geometry type will have different coordinates format. So you must given an explicit GeoJson type or do a type cast here (See decode example above).

### Sample VectorTile (raw) decoded (as JSON)
```json
{
  "layers": [
    {
      "name": "poi",
      "features": {
        "id": 31162829580,
        "tags": [
          0,
          0,
          1,
          1
        ],
        "type": "POINT",
        "geometry": [
          9,
          8058,
          1562
        ]
      },
      "keys": [
        "render_height",
        "name"
      ],
      "values": [
        {
          "intValue": 65
        },
        {
          "stringValue": "basketball"
        }
      ],
      "extent": 4096,
      "version": 2
    }
  ]
}
```

### Sample VectorTileFeature as GeoJson decoded
```json
{ 
  "type": "Feature",
  "geometry": {"type": "Point", "coordinates": [102.0, 0.5]},
  "properties": {
    "render_height": {
      "stringValue": null,
      "floatValue": null,
      "doubleValue": null,
      "intValue": 65,
      "uintValue": null,
      "sintValue": null,
      "boolValue": null
    },
    "name": {
      "stringValue": "basketball",
      "floatValue": null,
      "doubleValue": null,
      "intValue": null,
      "uintValue": null,
      "sintValue": null,
      "boolValue": null
    }
  }
}
```
