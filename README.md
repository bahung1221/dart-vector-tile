## Dart Vector Tile
Package to `encode & decode` vector tiles. A implementation of [Mapbox Vector Tile specification 2.1](https://github.com/mapbox/vector-tile-spec).

Features:
- [x] Parse `.mvt`/`.pbf` file to raw vector tile format.
- [x] Decode vector tile feature to GeoJson format (only GeoJson Feature type).
- [x] Encode & create vector tile file from raw format data.
- [ ] Encode & create vector tile file from GeoJson format data. (TODO)

### Decode
Decode an vector tile file, either `.pbf` or `.mvt` should work:

```dart
import 'vector_tile/vector_tile.dart';

main() async {
    VectorTile tile = await VectorTile.fromPath(path: '../data/sample-12-3262-1923.pbf');
    VectorTileLayer layer = tile.layers.firstWhere((layer) => layer.name == 'transportation');

    layer.features.forEach((feature) {
      // Geometry will be decode on-demand to avoid redundant calculating
      feature.decodeGeometry();

      // Each GeometryType will have different geometry data format
      // So we must explicit check GeometryType and specific generic type here
      if (feature.geometryType == GeometryType.Point) {
        var geojson = feature.toGeoJson<GeoJsonPoint>(3262, 1923, 12);

        print(geojson.properties);
        print(geojson.geometry.coordinates);
      }
    }
}
```
[Sample VectorTile fields](#sample-vectortile-fields-as-json)

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
    await encodeVectorTile(path: './gen/tile.pbf', tile: tile);
}
```

### API
**Class VectorTile**:
- (TODO) `toGeoJson`: Convert VectorTile to a FeatureCollection GeoJson. Not implemented yet.

**class VectorTileFeature**:

- `decodeGeometry()`: Decode geometry data from raw data, this data also will be used later when we call `getGeoJson` method.
- `T toGeoJson<T extends GeoJson>(int x, int y, int z)`: Convert to GeoJson format include **lon/lat** coordinates calculating, this method will return generic type of [GeoJson class](lib/util/geo_json.dart) 
because each geometry type will have different coordinates format. So you must given explicit GeoJson type or do a type cast here (See decode example above).

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
    "render_height": 65,
    "name": "basketball"
  }
}
```