import 'package:meta/meta.dart';
import 'package:vector_tile/util/geometry.dart';
import 'package:vector_tile/vector_tile_value.dart';

enum GeoJsonType {
  Feature, FeatureCollection  
}

class GeoJson {
  final GeoJsonType type = GeoJsonType.Feature;
  List<Map<String, VectorTileValue>> properties;

  GeoJson({this.properties});
}

class GeoJsonPoint extends GeoJson {
  GeometryPoint geometry; 

  GeoJsonPoint({
    @required properties,
    @required this.geometry
  }) : super(properties: properties);
}

class GeoJsonMultiPoint extends GeoJson {
  GeometryMultiPoint geometry; 

  GeoJsonMultiPoint({
    @required properties,
    @required this.geometry
  }) : super(properties: properties);
}

class GeoJsonLineString extends GeoJson {
  GeometryLineString geometry; 

  GeoJsonLineString({
    @required properties,
    @required this.geometry
  }) : super(properties: properties);
}

class GeoJsonMultiLineString extends GeoJson {
  GeometryMultiLineString geometry; 

  GeoJsonMultiLineString({
    @required properties,
    @required this.geometry
  }) : super(properties: properties);
}

class GeoJsonPolygon extends GeoJson {
  GeometryPolygon geometry; 

  GeoJsonPolygon({
    @required properties,
    @required this.geometry
  }) : super(properties: properties);
}

class GeoJsonMultiPolygon extends GeoJson {
  GeometryMultiPolygon geometry; 

  GeoJsonMultiPolygon({
    @required properties,
    @required this.geometry
  }) : super(properties: properties);
}

class GeoJsonFeatureCollection extends GeoJson {
  final GeoJsonType type = GeoJsonType.FeatureCollection;
  List<GeoJson> features;

  GeoJsonFeatureCollection({
    @required this.features
  }) : super();
}
