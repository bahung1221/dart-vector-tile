import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as raw;
import 'package:vector_tile/util/command.dart';
import 'package:vector_tile/util/geojson.dart';
import 'package:vector_tile/util/geometry.dart';
import 'package:vector_tile/vector_tile_geom_type.dart';
import 'package:vector_tile/vector_tile_value.dart';

class VectorTileFeature {
  Int64 id;
  List<int> tags;
  VectorTileGeomType? type;
  List<int>? geometryList;

  // Decoded properties
  GeometryType? geometryType;
  Geometry? geometry;
  Map<String, VectorTileValue>? properties;

  // Additional
  int? extent;
  List<String>? keys;
  List<VectorTileValue>? values;

  VectorTileFeature({
    required this.id,
    required this.tags,
    this.type,
    this.geometryList,
    this.extent,
    this.keys,
    this.values,
  });

  raw.VectorTile_Feature toRaw() {
    return raw.VectorTile_Feature(
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
  /// You must explicit cast Geometry type after got returned data:
  ///    ```
  ///     var geometry = feature.decodeGeometry();
  ///     var coordinates = (geometry as GeometryPoint).coordinates;
  ///    ```
  T? decodeGeometry<T extends Geometry?>() {
    if (this.geometry != null) {
      return this.geometry as T?;
    }
    this.decodeProperties();

    switch (this.type) {
      case VectorTileGeomType.POINT:
        List<List<int>> coords = this.decodePoint();

        if (coords.length <= 1) {
          this.geometry = Geometry.Point(
              coordinates: coords[0]
                  .map((intVal) => intVal.toDouble())
                  .toList(growable: false));
          this.geometryType = GeometryType.Point;
          break;
        }

        this.geometry = Geometry.MultiPoint(
            coordinates:
                coords.map((coord) => coord.map((intVal) => intVal.toDouble()))
                    as List<List<double>>);
        this.geometryType = GeometryType.MultiPoint;
        break;
      case VectorTileGeomType.LINESTRING:
        List<List<List<int>>> coords = this.decodeLineString();

        if (coords.length <= 1) {
          this.geometry = Geometry.LineString(
              coordinates: coords[0]
                  .map(
                    (point) => point
                        .map((intVal) => intVal.toDouble())
                        .toList(growable: false),
                  )
                  .toList(growable: false));
          this.geometryType = GeometryType.LineString;
          break;
        }

        this.geometry = Geometry.MultiLineString(
            coordinates: coords
                .map((line) => line
                    .map(
                      (point) => point
                          .map((intVal) => intVal.toDouble())
                          .toList(growable: false),
                    )
                    .toList(growable: false))
                .toList(growable: false));
        this.geometryType = GeometryType.MultiLineString;
        break;
      case VectorTileGeomType.POLYGON:
        List<List<List<List<int>>>> coords = this.decodePolygon();

        if (coords.length <= 1) {
          this.geometry = Geometry.Polygon(
              coordinates: coords[0]
                  .map((ring) => ring
                      .map(
                        (point) => point
                            .map((intVal) => intVal.toDouble())
                            .toList(growable: false),
                      )
                      .toList(growable: false))
                  .toList(growable: false));
          this.geometryType = GeometryType.Polygon;
          break;
        }

        this.geometry = Geometry.MultiPolygon(
            coordinates: coords
                .map((polygon) => polygon
                    .map((ring) => ring
                        .map(
                          (point) => point
                              .map((intVal) => intVal.toDouble())
                              .toList(growable: false),
                        )
                        .toList(growable: false))
                    .toList(growable: false))
                .toList(growable: false));
        this.geometryType = GeometryType.MultiPolygon;
        break;
      default:
        print('only implement point type');
    }

    return this.geometry as T?;
  }

  /// Decode properties from feature tags and key/value pairs got from parent layer
  ///
  /// Return key/value pairs
  Map<String, VectorTileValue> decodeProperties() {
    if (this.properties != null) {
      return this.properties!;
    }
    int length = this.tags.length;
    Map<String, VectorTileValue> properties = {};

    for (int i = 0; i < length; i += 2) {
      int keyIndex = this.tags[i];
      int valueIndex = this.tags[i + 1];

      properties[this.keys![keyIndex]] = this.values![valueIndex];
    }

    this.properties = properties;
    return properties;
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

    for (final commandInt in this.geometryList ?? []) {
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
    }

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

    for (final commandInt in this.geometryList ?? []) {
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
    }

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

    for (final commandInt in this.geometryList ?? []) {
      if (length <= 0 || commandId == CommandID.ClosePath) {
        Command command = Command.CommandInteger(command: commandInt);

        commandId = command.id;
        length = command.count;

        if (commandId == CommandID.ClosePath) {
          coords.add(ring.reversed.toList(growable: false));
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
        if (coords.isNotEmpty && this._isCCW(ring: ring)) {
          polygons.add(coords);
          coords = [];
        }
      }
    }

    polygons.add(coords);
    return polygons;
  }

  /// Get GeoJson data from this feature
  ///
  /// x, y, z: is tile numbers and tile zoom
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
  T? toGeoJson<T extends GeoJson>(
      {required int x, required int y, required int z}) {
    if (this.geometry == null) {
      this.decodeGeometry();
    }

    int size = this.extent! * (pow(2, z) as int);
    int x0 = this.extent! * x;
    int y0 = this.extent! * y;

    return this.toGeoJsonWithExtentCalculated<T>(x0: x0, y0: y0, size: size);
  }

  /// Get GeoJson data from this feature
  ///
  /// x0, y0, size: is tile numbers and tile zoom that already calculated with layer extent
  /// x0, y0, size was used to calculate lon/lat pairs
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
  T? toGeoJsonWithExtentCalculated<T extends GeoJson>(
      {required int x0, required int y0, required int size}) {
    if (this.geometry == null) {
      this.decodeGeometry();
    }

    switch (this.geometryType) {
      case GeometryType.Point:
        final geometryPoint = this.geometry as GeometryPoint;

        geometryPoint.coordinates =
            this._projectPoint(size, x0, y0, geometryPoint.coordinates);

        return GeoJsonPoint(
          geometry: geometryPoint,
          properties: this.properties,
        ) as T;
      case GeometryType.MultiPoint:
        final geometryMultiPoint = this.geometry as GeometryMultiPoint;

        geometryMultiPoint.coordinates =
            this._project(size, x0, y0, geometryMultiPoint.coordinates);

        return GeoJsonMultiPoint(
          geometry: geometryMultiPoint,
          properties: this.properties,
        ) as T;
      case GeometryType.LineString:
        final geometryLineString = this.geometry as GeometryLineString;

        geometryLineString.coordinates =
            this._project(size, x0, y0, geometryLineString.coordinates);

        return GeoJsonLineString(
          geometry: geometryLineString,
          properties: this.properties,
        ) as T;

      case GeometryType.MultiLineString:
        final geometryLineString = this.geometry as GeometryMultiLineString;

        geometryLineString.coordinates = geometryLineString.coordinates
            .map((line) => this._project(size, x0, y0, line))
            .toList(growable: false);

        return GeoJsonMultiLineString(
          geometry: geometryLineString,
          properties: this.properties,
        ) as T;
      case GeometryType.Polygon:
        final geometryPolygon = this.geometry as GeometryPolygon;

        geometryPolygon.coordinates = geometryPolygon.coordinates
            .map((line) => this._project(size, x0, y0, line))
            .toList(growable: false);

        return GeoJsonPolygon(
          geometry: geometryPolygon,
          properties: this.properties,
        ) as T;
      case GeometryType.MultiPolygon:
        final geometryMultiPolygon = this.geometry as GeometryMultiPolygon;

        geometryMultiPolygon.coordinates = geometryMultiPolygon.coordinates
            ?.map((polygon) => polygon
                .map((ring) => this._project(size, x0, y0, ring))
                .toList(growable: false))
            .toList(growable: false);

        return GeoJsonMultiPolygon(
          geometry: geometryMultiPolygon,
          properties: this.properties,
        ) as T;
      default:
    }

    return null;
  }

  /// Convert list of point into lon/lat points
  List<List<double>> _project(num size, num x0, num y0, List<List<double>> line) {
    // Deep clone
    List<List<double>> result = line
        .map((point) => point.map((val) => val).toList(growable: false))
        .toList(growable: false);

    for (var i = 0; i < line.length; i++) {
      List<double> point = line[i];
      result[i] = this._projectPoint(size, x0, y0, point);
    }

    return result;
  }

  /// Convert given point into lon/lat point
  ///
  /// See `Tile numbers to lon./lat.` section in documentation link below
  /// @docs: https://wiki.openstreetmap.org/wiki/Slippy_map_tilenames
  List<double> _projectPoint(num size, num x0, num y0, List<double> point) {
    double y2 = 180 - (point[1] + y0) * 360 / size;

    return [
      (point[0] + x0) * 360 / size - 180,
      360 / pi * atan(exp(y2 * pi / 180)) - 90
    ];
  }

  /// Implements https://en.wikipedia.org/wiki/Shoelace_formula
  bool _isCCW({required List<List<int>> ring}) {
    final ringLength = ring.length;
    var sum = 0;
    for (var i = 0, j = ringLength - 1; i < ringLength; j = i++) {
      sum += (ring[i][0] - ring[j][0]) * (ring[i][1] + ring[j][1]);
    }
    return sum < 0;
  }
}
