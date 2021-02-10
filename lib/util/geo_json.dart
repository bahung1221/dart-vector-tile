import 'package:meta/meta.dart';
import 'package:vector_tile/util/geometry.dart';
import 'package:vector_tile/vector_tile_value.dart';

class GeoJson {
  final String type = 'Feature';
  List<Map<String, VectorTileValue>> properties;

  GeoJson({@required this.properties});
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
