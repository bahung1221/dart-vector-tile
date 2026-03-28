import 'package:test/test.dart';
import 'package:vector_tile/util/geometry.dart';

void main() {
  group('Geometry factory constructors', () {
    test('creates GeometryPoint', () {
      final geom = Geometry.Point(coordinates: [1.0, 2.0]);
      expect(geom, isA<GeometryPoint>());
      expect(geom.type, GeometryType.Point);
      expect((geom as GeometryPoint).coordinates, [1.0, 2.0]);
    });

    test('creates GeometryMultiPoint', () {
      final geom = Geometry.MultiPoint(coordinates: [
        [1.0, 2.0],
        [3.0, 4.0],
      ]);
      expect(geom, isA<GeometryMultiPoint>());
      expect(geom.type, GeometryType.MultiPoint);
      expect((geom as GeometryMultiPoint).coordinates.length, 2);
    });

    test('creates GeometryLineString', () {
      final geom = Geometry.LineString(coordinates: [
        [0.0, 0.0],
        [1.0, 1.0],
      ]);
      expect(geom, isA<GeometryLineString>());
      expect(geom.type, GeometryType.LineString);
    });

    test('creates GeometryMultiLineString', () {
      final geom = Geometry.MultiLineString(coordinates: [
        [
          [0.0, 0.0],
          [1.0, 1.0],
        ],
        [
          [2.0, 2.0],
          [3.0, 3.0],
        ],
      ]);
      expect(geom, isA<GeometryMultiLineString>());
      expect(geom.type, GeometryType.MultiLineString);
    });

    test('creates GeometryPolygon', () {
      final geom = Geometry.Polygon(coordinates: [
        [
          [0.0, 0.0],
          [1.0, 0.0],
          [1.0, 1.0],
          [0.0, 0.0],
        ],
      ]);
      expect(geom, isA<GeometryPolygon>());
      expect(geom.type, GeometryType.Polygon);
    });

    test('creates GeometryMultiPolygon', () {
      final geom = Geometry.MultiPolygon(coordinates: [
        [
          [
            [0.0, 0.0],
            [1.0, 0.0],
            [1.0, 1.0],
            [0.0, 0.0],
          ],
        ],
      ]);
      expect(geom, isA<GeometryMultiPolygon>());
      expect(geom.type, GeometryType.MultiPolygon);
    });
  });
}
