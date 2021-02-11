import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as Raw;
import 'package:vector_tile/util/command.dart';
import 'package:vector_tile/util/geo_json.dart';
import 'package:vector_tile/util/geometry.dart';
import 'package:vector_tile/vector_tile_geom_type.dart';
import 'package:vector_tile/vector_tile_value.dart';

class VectorTileFeature {
  Int64 id;
  List<int> tags;
  VectorTileGeomType type;
  List<int> geometryList;

  // Decoded properties
  GeometryType geometryType;
  Geometry geometry;
  List<Map<String, VectorTileValue>> properties;

  // Additional
  int extent;

  VectorTileFeature({
    @required this.id,
    @required this.tags,
    this.type,
    this.geometryList,
    
    this.extent,
  });

  Raw.VectorTile_Feature toRaw() {
    return Raw.VectorTile_Feature(
      id: this.id,
      tags: this.tags,
      type: this.type.toRaw(),
      geometry: this.geometryList,
    );
  }

  /// Decode feature geometry data
  /// 
  /// By default geometry doesn't decoded
  /// So you must call this method on-demand if you need it!
  /// 
  /// Properties that was decoded through this method:
  /// - feature.geometryType
  /// - feature.geometry
  /// 
  /// Return generic Geometry type, there are two ways to to read data returned from this method:
  /// - Explicit given a generic type:
  ///    ```
  ///     var geometry = feature.decodeGeometry<GeometryPoint>();
  ///     var coordinates = geometry.coordinates;
  ///    ```
  /// - Cast to specific GeoJson type after got returned data:
  ///    ```
  ///     var geometry = feature.decodeGeometry();
  ///     var coordinates = (geometry as GeometryPoint).coordinates;
  ///    ```
  T decodeGeometry<T extends Geometry>() {
    switch (this.type) {
      case VectorTileGeomType.POINT:
        List<List<int>> coords = this.decodePoint();

        if (coords.length <= 1) {
          this.geometry = Geometry.Point(
            coordinates: coords[0].map((intVal) => intVal.toDouble()).toList()
          );
          this.geometryType = GeometryType.Point;
          break;
        }

        this.geometry = Geometry.MultiPoint(
          coordinates: coords.map(
            (coord) => coord.map((intVal) => intVal.toDouble())
          )
        );
        this.geometryType = GeometryType.MultiPoint;
        break;
      case VectorTileGeomType.LINESTRING:
        List<List<List<int>>> coords = this.decodeLineString();

        if (coords.length <= 1) {
          this.geometry = Geometry.LineString(
            coordinates: coords[0].map(
              (point) => point.map((intVal) => intVal.toDouble()).toList(),
            ).toList()
          );
          this.geometryType = GeometryType.LineString;
          break;
        }

        this.geometry = Geometry.MultiLineString(
          coordinates: coords.map(
            (line) =>
              line.map(
                (point) => point.map((intVal) => intVal.toDouble()).toList(),
              ).toList()
          ).toList()
        );
        this.geometryType = GeometryType.MultiLineString;
        break;
      case VectorTileGeomType.POLYGON:
        List<List<List<List<int>>>> coords = this.decodePolygon();

        if (coords.length <= 1) {
          this.geometry = Geometry.Polygon(
            coordinates: coords[0].map(
              (ring) =>
                ring.map(
                  (point) => point.map((intVal) => intVal.toDouble()),
                )
            )
          );
          this.geometryType = GeometryType.Polygon;
          break;
        }

        this.geometry = Geometry.MultiPolygon(
          coordinates: coords.map(
            (polygon) =>
              polygon.map(
                (ring) =>
                  ring.map(
                    (point) => point.map((intVal) => intVal.toDouble()),
                  )
              )
          )
        );
        this.geometryType = GeometryType.MultiPolygon;
        break;
      default:
        print('only implement point type');
    }

    return this.geometry as T;
  }

  /// Decode LineString geometry
  /// 
  /// @docs: https://github.com/mapbox/vector-tile-spec/tree/master/2.1#4342-point-geometry-type
  List<List<int>> decodePoint() {
    int length = 0;
    int commandId = 0;
    int x = 0;
    int y = 0;
    bool isX = true;
    List<List<int>> coords = [];
    List<int> point = [];

    this.geometryList.forEach((commandInt) {
      if (length <= 0) {
        Command command = Command.CommandInteger(command: commandInt);

        commandId = command.id;
        length = command.count;
      } else if (commandId != CommandID.ClosePath) {
        if (isX) {
          x += Command.zigZagDecode(commandInt);
          point.add(x);
          isX = false;
        } else {
          y += Command.zigZagDecode(commandInt);
          point.add(y);
          length -= 1;
          isX = true;
        }
      }

      if (length <= 0) {
        coords.add(point);
        point = [];
      }
    });

    return coords;
  }

  /// Decode LineString geometry
  /// 
  /// @docs: https://github.com/mapbox/vector-tile-spec/tree/master/2.1#4343-linestring-geometry-type
  List<List<List<int>>> decodeLineString() {
    int length = 0;
    int commandId = 0;
    int x = 0;
    int y = 0;
    bool isX = true;
    List<List<List<int>>> coords = [];
    List<List<int>> ring = [];

    this.geometryList.forEach((commandInt) {
      if (length <= 0) {
        Command command = Command.CommandInteger(command: commandInt);

        commandId = command.id;
        length = command.count;
      } else if (commandId != CommandID.ClosePath) {
        if (isX) {
          x += Command.zigZagDecode(commandInt);
          isX = false;
        } else {
          y += Command.zigZagDecode(commandInt);
          ring.add([x, y]);
          length -= 1;
          isX = true;
        }
      }

      if (length <= 0 && commandId == CommandID.LineTo) {
        coords.add(ring);
        ring = [];
      }
    });

    return coords;
  }

  /// Decode polygon geometry
  /// 
  /// @docs: https://github.com/mapbox/vector-tile-spec/tree/master/2.1#4344-polygon-geometry-type
  List<List<List<List<int>>>> decodePolygon() {
    int length = 0;
    int commandId = 0;
    int x = 0;
    int y = 0;
    bool isX = true;
    List<List<List<List<int>>>> polygons = [];
    List<List<List<int>>> coords = [];
    List<List<int>> ring = [];

    this.geometryList.forEach((commandInt) {
      if (length <= 0 || commandId == CommandID.ClosePath) {
        Command command = Command.CommandInteger(command: commandInt);

        commandId = command.id;
        length = command.count;

        if (commandId == CommandID.ClosePath) {
          coords.add(ring.reversed);
          ring = [];
        }
      } else if (commandId != CommandID.ClosePath) {
        if (isX) {
          x += Command.zigZagDecode(commandInt);
          isX = false;
        } else {
          y += Command.zigZagDecode(commandInt);
          ring.add([x, y]);
          length -= 1;
          isX = true;
        }
      }

      if (length <= 0 && commandId == CommandID.LineTo) {
        if (coords.isNotEmpty && this.isCCW(ring: ring)) {
          polygons.add(coords);
          coords = [];
        }
      }
    });

    polygons.add(coords);
    return polygons;
  }

  /// Get GeoJson data from this feature
  /// 
  /// x, y, z: is tile numbers and tile zoom
  /// Normally, you already know that info when you want to parse vector tile files
  /// x, y, z was used to calculate lon/lat pairs
  /// 
  /// Return generic GeoJson type, there are two ways to to read data returned from this method:
  /// - Explicit given a generic type:
  ///    ```
  ///     var geojson = feature.toGeoJson<GeoJsonPoint>(3262, 1923, 12);
  ///     var coordinates = geojson.geometry.coordinates;
  ///    ```
  /// - Cast to specific GeoJson type after got returned data:
  ///    ```
  ///     var geojson = feature.toGeoJson(3262, 1923, 12);
  ///     var coordinates = (geojson as GeoJsonPoint).geometry.coordinates;
  ///    ```
  T toGeoJson<T extends GeoJson>(int x, int y, int z) {
    if (this.geometry == null) {
      this.decodeGeometry();
    }

    int size = this.extent * pow(2, z);
    int x0 = this.extent * x;
    int y0 = this.extent * y;

    switch (this.geometryType) {
      case GeometryType.Point:
        (this.geometry as GeometryPoint).coordinates =
          this.projectPoint(
            size,
            x0,
            y0,
            (this.geometry as GeometryPoint).coordinates
          );

        return GeoJsonPoint(
          geometry: this.geometry,
          properties: <Map<String, VectorTileValue>>[],
        ) as T;
      case GeometryType.MultiPoint:
        (this.geometry as GeometryMultiPoint).coordinates = 
          this.project(
            size, 
            x0, 
            y0, 
            (this.geometry as GeometryMultiPoint).coordinates
          );

        return GeoJsonMultiPoint(
          geometry: this.geometry,
          properties: <Map<String, VectorTileValue>>[],
        ) as T;
      case GeometryType.LineString:
        (this.geometry as GeometryLineString).coordinates = 
          this.project(size, x0, y0, (this.geometry as GeometryLineString).coordinates);

        return GeoJsonLineString(
          geometry: this.geometry,
          properties: <Map<String, VectorTileValue>>[],
        ) as T;

      case GeometryType.MultiLineString:
        (this.geometry as GeometryMultiLineString).coordinates = 
          (this.geometry as GeometryMultiLineString).coordinates.map(
            (line) => 
              this.project(size, x0, y0, line)
          ).toList();

        return GeoJsonMultiLineString(
          geometry: this.geometry,
          properties: <Map<String, VectorTileValue>>[],
        ) as T;
      case GeometryType.Polygon:
        (this.geometry as GeometryPolygon).coordinates = 
          (this.geometry as GeometryPolygon).coordinates.map(
            (line) => 
              this.project(size, x0, y0, line)
          ).toList();

        return GeoJsonPolygon(
          geometry: this.geometry,
          properties: <Map<String, VectorTileValue>>[],
        ) as T;
      case GeometryType.MultiPolygon:
        (this.geometry as GeometryMultiPolygon).coordinates = 
          (this.geometry as GeometryMultiPolygon).coordinates.map(
            (polygon) => 
              polygon.map(
                (ring) => this.project(size, x0, y0, ring)
              ).toList()
          ).toList();

        return GeoJsonMultiPolygon(
          geometry: this.geometry,
          properties: <Map<String, VectorTileValue>>[],
        ) as T;
      default:
    }

    return null;
  }

  /// Convert list of point into lon/lat points
  List<List<double>> project(size, x0, y0, List<List<double>> line) {
    // Deep clone
    List<List<double>> result = line.map(
      (point) => 
        point.map((val) => val).toList()
    ).toList();

    for (var i = 0; i < line.length; i++) {
      List<double> point = line[i];
      result[i] = this.projectPoint(size, x0, y0, point);
    }

    return result;
  }

  /// Convert given point into lon/lat point
  /// 
  /// See `Tile numbers to lon./lat.` section in documentation link below
  /// @docs: https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames
  List<double> projectPoint(size, x0, y0, List<double> point) {
    double y2 = 180 - (point[1] + y0) * 360 / size;

    return [
        (point[0] + x0) * 360 / size - 180,
        360 / pi * atan(exp(y2 * pi / 180)) - 90
    ];
  }

  /// Implements https://en.wikipedia.org/wiki/Shoelace_formula
  bool isCCW({@required List<List<int>> ring}) {
    int i = -1;
    int ccw = ring.sublist(1, ring.length - 1).fold(0, (sum, point) {
      i++;
      return sum + (point[0]-ring[i][0]) * (point[1]+ring[i][1]);
    });

    return ccw < 0;
  }
}
