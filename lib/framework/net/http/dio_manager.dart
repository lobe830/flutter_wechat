/*
 * @Description: 基于网络插件dio的封装,提供web请求服务接口
 * @Author: liuaobo
 * @Date: 2021-03-10 16:42:06
 * @LastEditTime: 2021-03-11 14:05:19
 * @LastEditors: liuaobo
 * @Reference: 
 */
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

import 'base_result.dart';

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

/// Http配置.
class HttpConfig {
  /// constructor.
  HttpConfig({
    this.code,
    this.status,
    this.msg,
    this.data,
    this.options,
    this.pem,
    this.pKCSPath,
    this.pKCSPwd,
  });

  /// BaseResult [int code]字段 key, 默认：errorCode.
  String code;

  /// BaseResult [String status]字段 key, 默认：status.
  String status;

  /// BaseResult [String msg]字段 key, 默认：errorMsg.
  String msg;

  /// BaseResult [T data]字段 key, 默认：data.
  String data;

  /// Options.
  BaseOptions options;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PEM证书内容.
  String pem;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书路径.
  String pKCSPath;

  /// 详细使用请查看dio官网 https://github.com/flutterchina/dio/blob/flutter/README-ZH.md#Https证书校验.
  /// PKCS12 证书密码.
  String pKCSPwd;
}

/// 使用factory构建的DioManager单例
/// debug模式下可以打印日志。DioManager.setDebugMode(true)
/// dio详细使用请查看dio官网(https://github.com/flutterchina/dio).
class DioManager {
  static final DioManager _instance = DioManager._init();
  static Dio _dio;

  static DioManager get instance => _instance;

  factory DioManager() {
    return _instance;
  }

  static BaseOptions getDioOptions() {
    BaseOptions options = BaseOptions();
    options.contentType = Headers.formUrlEncodedContentType;
    options.sendTimeout = 1000 * 30;
    options.receiveTimeout = 1000 * 30;
    return options;
  }

  /// BaseResult [int code]字段 key, 默认：errorCode.
  String _codeKey = "errorCode";

  /// BaseResult [String status]字段 key, 默认：status.
  String _statusKey = "status";

  /// BaseResult [String msg]字段 key, 默认：errorMsg.
  String _msgKey = "errorMsg";

  /// BaseResult [T data]字段 key, 默认：data.
  String _dataKey = "data";

  /// Options.
  BaseOptions _options;

  /// PEM证书内容.
  String _pem;

  /// PKCS12 证书路径.
  String _pKCSPath;

  /// PKCS12 证书密码.
  String _pKCSPwd;

  /// 是否是debug模式.
  bool _isDebug = false;

  DioManager._init() {
    _options = getDioOptions();
    _dio = createDio(_options);
  }

  Dio get dio => _dio;

  /// 创建一个dio实例, 默认情况下DioManager已经维护了一个dio instance，
  /// 如果需要使用http进行特殊处理，则可以调用createDio接口，返回一个新dio实例，进行后续操作
  Dio createDio([BaseOptions options]) {
    options = options ?? getDioOptions();
    Dio dio = new Dio(options);
    return dio;
  }

  /// 设置debug模式开关
  /// [debugMode] true-开启；false-关闭
  void setDebugMode(bool debugMode) {
    _isDebug = debugMode;
  }

  /// 设置cookie
  void setCookie(String cookie) {
    Map<String, dynamic> _headers = new Map<String, dynamic>();
    _headers["cookie"] = cookie;
    _dio.options.headers.addAll(_headers);
  }

  void setConfig(HttpConfig config) {
    _codeKey = config.code ?? _codeKey;
    _statusKey = config.status ?? _statusKey;
    _msgKey = config.msg ?? _msgKey;
    _dataKey = config.data ?? _dataKey;
    _mergeOption(config.options);
    _pem = config.pem ?? _pem;
    if (_dio != null) {
      _dio.options = _options;
      if (_pem != null) {
        (_dio.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (client) {
          // 设置代理 HttpClient.findProxyFromEnvironment(url, environment: {"http_proxy": 'http://192.168.1.199:8088',});
          // client.findProxy = (uri) {
          //   return "PROXY 192.168.1.199:8088";
          // };

          // 校验证书
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) {
            if (cert.pem == _pem) {
              return true; // 证书一致，则允许发送数据
            }
            return false;
          };
        };
      }
      if (_pKCSPath != null) {
        (_dio.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (client) {
          SecurityContext sc = new SecurityContext();
          //file为证书路径
          sc.setTrustedCertificates(_pKCSPath, password: _pKCSPwd);
          HttpClient httpClient = new HttpClient(context: sc);
          return httpClient;
        };
      }
    }
  }

  /// 向服务器请求数据
  /// [method]  请求的api操作
  /// [path] 请求的服务器地址
  /// [data] 请求的数据
  /// [options] 请求的配置信息
  /// [cancelToken] 取消请求操纵的指令token
  /// <BaseResult<T>> 返回请求结果
  Future<BaseResult<T>> request<T>(String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    Response response = await _dio.request(path,
        data: data,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    _printLog(response);
    String _status, _msg;
    int _code;
    T _data;

    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      try {
        Map<String, dynamic> _dataMap;
        if (response.data is Map) // 键值对
        {
          _dataMap = response.data;
        } else {
          _dataMap = _decodeData(response);
        }
        // 解析http返回结果
        _status = _dataMap[_statusKey].toString();
        dynamic codeValue = _dataMap[_codeKey];
        _code = (codeValue is String)
            ? int.tryParse(_dataMap[_codeKey])
            : codeValue;
        _msg = _dataMap[_msgKey];
        _data = _dataMap[_dataKey];
        return new BaseResult(_code, _status, _msg, _data, response);
      } catch (e) {
        return new Future.error(new DioError(
          type: DioErrorType.RESPONSE,
          response: response,
          error: "data parse exception!",
        ));
      }
    }

    return new Future.error(new DioError(
      type: DioErrorType.RESPONSE,
      response: response,
      error: "statusCode: $response.statusCode, service error!",
    ));
  }

  /// 下载文件
  Future<Response> download(
      String urlPath,
      savePath,
      ProgressCallback onProgress,
      Map<String, dynamic> queryParams,
      CancelToken cancelToken,
      data,
      Options options) {
    return _dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onProgress,
      queryParameters: queryParams,
      cancelToken: cancelToken,
      data: data,
      options: options,
    );
  }

  /// decode response data.
  Map<String, dynamic> _decodeData(Response response) {
    if (response == null ||
        response.data == null ||
        response.data.toString().isEmpty) {
      return new Map();
    }
    return json.decode(response.data.toString());
  }

  /// check Options.
  Options _checkOptions(String method, Options options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  /// merge Option.
  void _mergeOption(BaseOptions opt) {
    _options.method = opt.method ?? _options.method;
    _options.headers = (new Map.from(_options.headers))..addAll(opt.headers);
    _options.baseUrl = opt.baseUrl ?? _options.baseUrl;
    _options.connectTimeout = opt.connectTimeout ?? _options.connectTimeout;
    _options.receiveTimeout = opt.receiveTimeout ?? _options.receiveTimeout;
    _options.responseType = opt.responseType ?? _options.responseType;
    _options.extra = (new Map.from(_options.extra))..addAll(opt.extra);
    _options.contentType = opt.contentType ?? _options.contentType;
    _options.validateStatus = opt.validateStatus ?? _options.validateStatus;
    _options.followRedirects = opt.followRedirects ?? _options.followRedirects;
  }

  /// print Http Log.
  void _printLog(Response response) {
    if (!_isDebug) {
      return;
    }
    try {
      print("----------------Http Log----------------" +
          "\n[statusCode]:   " +
          response.statusCode.toString() +
          "\n[request   ]:   " +
          _getOptionsStr(response.request));
      _printData("reqest data ", response.request.data);
      _printData("response data", response.data);
    } catch (ex) {
      print("Http Log" + " error......");
    }
  }

  /// get Options Str.
  String _getOptionsStr(RequestOptions request) {
    return "method: " +
        request.method +
        "  baseUrl: " +
        request.baseUrl +
        "  path: " +
        request.path;
  }

  /// print Data Str.
  void _printData(String tag, Object value) {
    String da = value.toString();
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("[$tag  ]:   " + da.substring(0, 512));
        da = da.substring(512, da.length);
      } else {
        print("[$tag  ]:   " + da);
        da = "";
      }
    }
  }
}
