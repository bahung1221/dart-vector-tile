import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';
import 'package:vector_tile/raw/raw_vector_tile.dart' as Raw;
import 'package:vector_tile/util/command.dart';
import 'package:vector_tile/util/geometry.dart';
import 'package:vector_tile/vector_tile_geom_type.dart';
import 'package:vector_tile/vector_tile_value.dart';

class VectorTileFeature {
  Int64 id;
  List<int> tags;
  VectorTileGeomType type;
  List<int> geometryList;

  // GeoJSON
  List<Map<String, VectorTileValue>> properties;
  GeometryType geometryType;
  GeometryPoint geometryPoint;
  GeometryMultiPoint geometryMultiPoint;
  GeometryLineString geometryLineString;
  GeometryMultiLineString geometryMultiLineString;
  GeometryPolygon geometryPolygon;
  GeometryMultiPolygon geometryMultiPolygon;

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

  void decode() {
    this.decodeGeometry();
  }

  void decodeGeometry() {
    switch (this.type) {
      case VectorTileGeomType.POINT:
        List<List<int>> coords = this.decodePoint();

        if (coords.length <= 1) {
          this.geometryPoint = Geometry.Point(
            coordinate: coords[0].map((intVal) => intVal.toDouble()).toList()
          );
          this.geometryType = GeometryType.Point;
          break;
        }

        this.geometryMultiPoint = Geometry.MultiPoint(
          coordinates: coords.map(
            (coord) => coord.map((intVal) => intVal.toDouble())
          )
        );
        this.geometryType = GeometryType.MultiPoint;
        break;
      case VectorTileGeomType.LINESTRING:
        List<List<List<int>>> coords = this.decodeLineString();

        if (coords.length <= 1) {
          this.geometryLineString = Geometry.LineString(
            coordinates: coords[0].map(
              (point) => point.map((intVal) => intVal.toDouble()),
            )
          );
          this.geometryType = GeometryType.LineString;
          break;
        }

        this.geometryMultiLineString = Geometry.MultiLineString(
          coordinates: coords.map(
            (line) =>
              line.map(
                (point) => point.map((intVal) => intVal.toDouble()),
              )
          )
        );
        this.geometryType = GeometryType.MultiLineString;
        break;
      case VectorTileGeomType.POLYGON:
        List<List<List<List<int>>>> coords = this.decodePolygon();

        if (coords.length <= 1) {
          this.geometryPolygon = Geometry.Polygon(
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

        this.geometryMultiPolygon = Geometry.MultiPolygon(
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
  }

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

  void toGeoJson(int x, int y, int z) {
    int size = this.extent * pow(2, z);
    int x0 = this.extent * x;
    int y0 = this.extent * y;

    int i;
    int j;

    switch (this.geometryType) {
      case GeometryType.Point:
        var coord = this.projectPoint(size, x0, y0, this.geometryPoint.coordinate);
        print(coord);
        break;
      default:
    }
  }

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

  List<double> projectPoint(size, x0, y0, List<double> point) {
    double y2 = 180 - (point[1] + y0) * 360 / size;

    return [
        (point[0] + x0) * 360 / size - 180,
        360 / pi * atan(exp(y2 * pi / 180)) - 90
    ];
  }

  /**
   * Implements https://en.wikipedia.org/wiki/Shoelace_formula
   */
  bool isCCW({@required List<List<int>> ring}) {
    int i = -1;
    int ccw = ring.sublist(1, ring.length - 1).fold(0, (sum, point) {
      i++;
      return sum + (point[0]-ring[i][0]) * (point[1]+ring[i][1]);
    });

    return ccw < 0;
  }
}
