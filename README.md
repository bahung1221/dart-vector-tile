## Dart Vector Tile
Simple package to `encode & decode` vector tiles. based on [Mapbox Vector Tile specification 2.1](https://github.com/mapbox/vector-tile-spec).

### Decode
Decode an vector tile file, either `.pbf` or `.mvt` should work:

```dart
import 'vector_tile/vector_tile.dart';

main() async {
    VectorTile tile = await decodeVectorTile(path: './data/14-13050-7695.pbf');
}
```
[Sample VectorTile fields](#sample-vectortile-fields-as-json)

### Encode
Create VectorTile and then encode it into protobuf file:

```dart
import 'vector_tile/vector_tile.dart';

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

### Sample VectorTile fields (As JSON):
```json
{
    "layers": {
        "name": "building",
        "features": [{
            "id": 31162829580,
            "tags": [0, 96, 1, 348],
            "type": "POINT",
            "geometry": [9, 8058, 1562]
        }],
        "keys": ["render_height", "render_min_height"],
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
}
```
