import 'package:flutter/foundation.dart';
import 'package:flutter_app/core/base/CoreVo.dart';
import 'package:flutter_app/entity_factory.dart';

_parseObj(Param param) {
  if (param.clazz == "CoreVo") {
    return param.data;
  }
  return EntityFactoryParse.generateObj(param.data, param.clazz);
}

_parseArray(Param param) {
  final parsed = param.data.cast<Map<String, dynamic>>();
  return parsed
      .map((json) => EntityFactoryParse.generateObj(json, param.clazz))
      .toList();
}

// Must be top-level function
_parseData(Param param) {
  var data = param.data;
  try {
    if (data is Map) {
      return _parseObj(param);
    } else if (data is List) {
      return _parseArray(param);
    } else {
      return data;
    }
  } catch (e) {
    return data;
  }
}

// Must be top-level function
T _parseObjDataN<T>(var data) {
  return EntityFactory.generateOBJ<T>(data);
}

// Must be top-level function
List<T> _parseArrDataN<T>(var data) {
  final parsed = data.cast<Map<String, dynamic>>();
  print("==========${T.toString()}"); //problem T is dynamic, not my Class type
  List<T> list =
      parsed.map((json) => EntityFactory.generateOBJ<T>(json)).toList();
  return list;
}

Future parseData(Param data) async {
  return await compute(_parseData, data);
}

Future<T> parseObjN<T>(var data) async {
  return await compute<dynamic, T>(_parseObjDataN, data);
}

Future<List<T>> parseArrN<T>(var data) async {
  print("=======${T.toString()}"); // this is right, but _parseArrDataN is wrong
  return await compute<dynamic, List<T>>(_parseArrDataN, data);
}

///// T 不指定其实就是返回原数据
//Future parse<T extends CoreVo>(var data) async {
//  try {
//    if (data is Map) {
//      return parseObjN<T>(data);
//    } else if (data is List) {
//      return parseArrN<T>(data);
//    } else {
//      return data;
//    }
//  } catch (e) {
//    return data;
//  }
//
////  return await parseData(Param(data, T.toString()));
//}
/// T 不指定其实就是返回原数据
Future parse<T extends CoreVo>(var data) async {
  return await parseData(Param(data, T.toString()));
}

class Param<T extends CoreVo> {
  var data;
  String clazz;
  Param(this.data, this.clazz);
}
