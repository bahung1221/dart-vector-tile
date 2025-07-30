import 'package:vector_tile/util/geometry.dart';
import 'package:vector_tile/vector_tile_value.dart';

enum GeoJsonType { Feature, FeatureCollection }

class GeoJson<T extends Geometry> {
  final GeoJsonType type = GeoJsonType.Feature;
  Map<String, VectorTileValue>? properties;
  T? geometry;

  GeoJson({this.properties, this.geometry});
}

class GeoJsonPoint extends GeoJson<GeometryPoint> {
  GeoJsonPoint({super.properties, super.geometry});
}

class GeoJsonMultiPoint extends GeoJson<GeometryMultiPoint> {
  GeoJsonMultiPoint({super.properties, super.geometry});
}

class GeoJsonLineString extends GeoJson<GeometryLineString> {
  GeoJsonLineString({super.properties, super.geometry});
}

class GeoJsonMultiLineString extends GeoJson<GeometryMultiLineString> {
  GeoJsonMultiLineString({super.properties, super.geometry});
}

class GeoJsonPolygon extends GeoJson<GeometryPolygon> {
  GeoJsonPolygon({super.properties, super.geometry});
}

class GeoJsonMultiPolygon extends GeoJson<GeometryMultiPolygon> {
  GeoJsonMultiPolygon({super.properties, super.geometry});
}

class GeoJsonFeatureCollection extends GeoJson {
  @override
  final GeoJsonType type = GeoJsonType.FeatureCollection;
  List<GeoJson?> features;

  GeoJsonFeatureCollection({required this.features}) : super();
}
