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

Future parseData(Param data) async {
  return await compute(_parseData, data);
}

/// T 不指定其实就是返回原数据
Future parse<T extends CoreVo>(var data) async {
  return await parseData(Param(data, T.toString()));
}

class Param<T extends CoreVo> {
  var data;
  String clazz;
  Param(this.data, this.clazz);
}
