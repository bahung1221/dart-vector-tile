import 'package:meta/meta.dart';

enum GeometryType {
  Point, LineString, Polygon, MultiPoint, MultiLineString, MultiPolygon
}

class Geometry {
  final GeometryType type = null;

  factory Geometry.Point({List<double> coordinates}) = GeometryPoint;
  factory Geometry.MultiPoint({List<List<double>> coordinates}) = GeometryMultiPoint;
  factory Geometry.LineString({List<List<double>> coordinates}) = GeometryLineString;
  factory Geometry.MultiLineString({List<List<List<double>>> coordinates}) = GeometryMultiLineString;
  factory Geometry.Polygon({List<List<List<double>>> coordinates}) = GeometryPolygon;
  factory Geometry.MultiPolygon({List<List<List<List<double>>>> coordinates}) = GeometryMultiPolygon;

  Geometry._();
}

class GeometryPoint extends Geometry {
  final type = GeometryType.Point;
  List<double> coordinates;

  GeometryPoint({
    @required this.coordinates,
  }) : super._();
}

class GeometryMultiPoint extends Geometry {
  final type = GeometryType.MultiPoint;
  List<List<double>> coordinates;

  GeometryMultiPoint({
    @required this.coordinates,
  }) : super._();
}

class GeometryLineString extends Geometry {
  final type = GeometryType.LineString;
  List<List<double>> coordinates;

  GeometryLineString({
    @required this.coordinates,
  }) : super._();
}

class GeometryMultiLineString extends Geometry {
  final type = GeometryType.MultiLineString;
  List<List<List<double>>> coordinates;

  GeometryMultiLineString({
    @required this.coordinates,
  }) : super._();
}

class GeometryPolygon extends Geometry {
  final type = GeometryType.Polygon;
  List<List<List<double>>> coordinates;

  GeometryPolygon({
    @required this.coordinates,
  }) : super._();
}

class GeometryMultiPolygon extends Geometry {
  final type = GeometryType.MultiPolygon;
  List<List<List<List<double>>>> coordinates;

  GeometryMultiPolygon({
    @required this.coordinates,
  }) : super._();
}
