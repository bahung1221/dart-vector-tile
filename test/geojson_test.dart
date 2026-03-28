import 'package:test/test.dart';
import 'package:vector_tile/util/geojson.dart';
import 'package:vector_tile/util/geometry.dart';
import 'package:vector_tile/vector_tile_value.dart';

void main() {
  group('GeoJson', () {
    test('has Feature type by default', () {
      final geojson = GeoJson();
      expect(geojson.type, GeoJsonType.Feature);
    });

    test('stores properties and geometry', () {
      final props = {'name': VectorTileValue(stringValue: 'test')};
      final geom = GeometryPoint(coordinates: [1.0, 2.0]);
      final geojson = GeoJson<GeometryPoint>(
        properties: props,
        geometry: geom,
      );
      expect(geojson.properties!['name']!.stringValue, 'test');
      expect(geojson.geometry!.coordinates, [1.0, 2.0]);
    });
  });

  group('GeoJson subclasses', () {
    test('GeoJsonPoint has correct generic type', () {
      final geojson = GeoJsonPoint(
        geometry: GeometryPoint(coordinates: [1.0, 2.0]),
      );
      expect(geojson, isA<GeoJson<GeometryPoint>>());
      expect(geojson.geometry!.coordinates, [1.0, 2.0]);
    });

    test('GeoJsonLineString has correct generic type', () {
      final geojson = GeoJsonLineString(
        geometry: GeometryLineString(coordinates: [
          [0.0, 0.0],
          [1.0, 1.0],
        ]),
      );
      expect(geojson, isA<GeoJson<GeometryLineString>>());
    });

    test('GeoJsonPolygon has correct generic type', () {
      final geojson = GeoJsonPolygon(
        geometry: GeometryPolygon(coordinates: [
          [
            [0.0, 0.0],
            [1.0, 0.0],
            [1.0, 1.0],
            [0.0, 0.0],
          ],
        ]),
      );
      expect(geojson, isA<GeoJson<GeometryPolygon>>());
    });
  });

  group('GeoJsonFeatureCollection', () {
    test('has FeatureCollection type', () {
      final fc = GeoJsonFeatureCollection(features: []);
      expect(fc.type, GeoJsonType.FeatureCollection);
    });

    test('stores features list', () {
      final point = GeoJsonPoint(
        geometry: GeometryPoint(coordinates: [1.0, 2.0]),
      );
      final fc = GeoJsonFeatureCollection(features: [point, null]);
      expect(fc.features.length, 2);
      expect(fc.features[0], isA<GeoJsonPoint>());
      expect(fc.features[1], isNull);
    });
  });
}
