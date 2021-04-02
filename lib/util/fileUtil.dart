import 'dart:io';
import 'dart:convert' as convert;
import 'package:path_provider/path_provider.dart';
import 'package:pdt/conf/index.dart' as conf;

class OperateFile {
  // 获取应用安装路径 对应Android的AppDate目录和iOS的NSDocumentDirectory目录；
  Future<String> _getLocalPath([dir]) async {
    Directory _appDocPath = await getApplicationDocumentsDirectory();
    String _path = _appDocPath.path;
    if (dir != null) {
      Directory directory = new Directory('$_path/$dir');
      _path = directory.path;
    }
    return _path;
  }

  // 创建文件夹
  Future<Map> createDir(String dirName, [dirPath]) async {
    try {
      String _dirPath = dirPath != null
          ? await _getLocalPath(dirPath)
          : await _getLocalPath();
      Directory _directory = new Directory('$_dirPath/$dirName');
      if (!_directory.existsSync()) {
        _directory.createSync();
        return {'code': conf.SUCCESS};
      } else {
        return {'code': conf.DIR_EXISTED};
      }
    } catch (err) {
      return {'code': conf.FAILED, 'msg': err};
    }
  }

  // 创建文件
  Future<Map> createFile(String fileName, [filePath]) async {
    try {
      String _filePath = filePath != null
          ? await _getLocalPath(filePath)
          : await _getLocalPath();
      File _file = new File('$_filePath/$fileName');
      if (!_file.existsSync()) {
        _file.createSync();
        return {'code': conf.SUCCESS};
      } else {
        return {'code': conf.FILE_EXISTED};
      }
    } catch (err) {
      return {'code': conf.FAILED, 'msg': err};
    }
  }

  // 删除文件/文件夹
  Future<Map> deleteFileOrDir(String path) async {
    try {
      String _path = await _getLocalPath(path);
      if (path.contains('.')) {
        File _file = new File('$_path');
        if (!_file.existsSync())
          return {'code': conf.FILE_NOT_EXISTED, 'msg': conf.FILE_NOT_EXISTED};
        _file.deleteSync();
        return {'code': conf.SUCCESS};
      } else {
        Directory _directory = new Directory('$_path');
        if (!_directory.existsSync()) {
          return {'code': conf.DIR_NOT_EXISTED, 'msg': conf.DIR_NOT_EXISTED};
        } else {
          List<FileSystemEntity> _files = _directory.listSync();
          if (_files.length > 0) {
            _files.forEach((element) {
              element.deleteSync();
            });
          }
          _directory.deleteSync();
          return {'code': conf.SUCCESS};
        }
      }
    } catch (err) {
      return {'code': conf.FAILED, 'msg': err};
    }
  }

  // 写入文件
  Future<Map> writeFile(String filePath, data) async {
    try {
      Map _result;
      String _filePath = await _getLocalPath(filePath);
      File _file = new File('$_filePath');
      if (filePath.endsWith('.txt')) {
        _result = await _writeTextFile(_file, data);
      } else if (filePath.endsWith('.json')) {
        _result = await _writeJsonFile(_file, data);
      } else {
        return {'code': conf.FILE_TYPE_FAILED, 'msg': conf.FILE_TYPE_FAILED};
      }
      return {'code': _result['code'], 'msg': _result['msg']};
    } catch (err) {
      return {'code': conf.FAILED, 'msg': err};
    }
  }

  // 读取文件
  Future<Map> readFile(String dirOrFilePath) async {
    try {
      String _dirOrFilePath = await _getLocalPath(dirOrFilePath);
      if (dirOrFilePath.contains('.')) {
        var _result;
        File _file = new File('$_dirOrFilePath');
        if (!_file.existsSync())
          return {'code': conf.FILE_NOT_EXISTED, 'msg': conf.FILE_NOT_EXISTED};
        _result = _file.readAsStringSync();
        if (dirOrFilePath.endsWith('.json'))
          _result = convert.jsonDecode(_result);
        return {'code': conf.SUCCESS, 'payload': _result};
      } else {
        Directory _directory = new Directory('$_dirOrFilePath');
        if (!_directory.existsSync())
          return {'code': conf.DIR_NOT_EXISTED, 'msg': conf.DIR_NOT_EXISTED};
        var _result = Map<String, String>();
        List _dirList = _directory.listSync();
        for (var i = 0; i < _dirList.length; i++) {
          String _itemPath = _dirList[i].path;
          int _startNum = _itemPath.lastIndexOf('/') + 1;
          int _endNum = _itemPath.lastIndexOf('.');
          String _fileName = _itemPath.substring(_startNum, _endNum);
          File _itemFile = new File(_itemPath);
          _result[_fileName] = _itemFile.readAsStringSync();
        }
        return {'code': conf.SUCCESS, 'payload': _result};
      }
    } catch (err) {
      return {'code': conf.FAILED, 'msg': err};
    }
  }

  // 写入txt
  Future<Map> _writeTextFile(File file, String data) async {
    try {
      file.writeAsStringSync(data);
      return {'code': conf.SUCCESS};
    } catch (err) {
      return {'code': conf.FAILED, 'msg': err};
    }
  }

  // 写入json
  Future<Map> _writeJsonFile(File file, Map data) async {
    try {
      file.writeAsStringSync(convert.jsonEncode(data));
      return {'code': conf.SUCCESS};
    } catch (err) {
      return {'code': conf.FAILED, 'msg': err};
    }
  }
}
