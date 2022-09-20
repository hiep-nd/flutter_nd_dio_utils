import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void enableCurlLogger(
  Iterable<Dio> dios, {
  bool debugModeOnly = true,
  bool printOnSuccess = true,
  bool convertFormData = true,
}) =>
    enableInterceptor(
      dios,
      () => CurlLoggerDioInterceptor(
        printOnSuccess: printOnSuccess,
        convertFormData: convertFormData,
      ),
      debugModeOnly: debugModeOnly,
    );

void ndEnableCurlLogger(
  Iterable<Dio> dios, {
  bool debugModeOnly = true,
  bool printOnSuccess = true,
  bool convertFormData = true,
}) =>
    enableCurlLogger(dios,
        debugModeOnly: debugModeOnly,
        printOnSuccess: printOnSuccess,
        convertFormData: convertFormData);

void disableCurlLogger(Iterable<Dio> dios) =>
    disableInterceptor<CurlLoggerDioInterceptor>(dios);

void ndDisableCurlLogger(Iterable<Dio> dios) => disableCurlLogger(dios);

void enablePrettyLogger(
  Iterable<Dio> dios, {
  bool debugModeOnly = true,
  bool request = true,
  bool requestHeader = true,
  bool requestBody = true,
  bool responseHeader = true,
  bool responseBody = true,
  bool error = true,
  int maxWidth = 90,
  bool compact = true,
  void Function(Object object) logPrint = print,
}) =>
    enableInterceptor(
      dios,
      () => PrettyDioLogger(
        requestHeader: requestHeader,
        requestBody: requestBody,
        responseBody: responseBody,
        responseHeader: responseHeader,
        error: error,
        compact: compact,
        maxWidth: maxWidth,
        logPrint: logPrint,
      ),
      debugModeOnly: debugModeOnly,
    );

void ndEnablePrettyLogger(
  Iterable<Dio> dios, {
  bool debugModeOnly = true,
  bool request = true,
  bool requestHeader = true,
  bool requestBody = true,
  bool responseHeader = true,
  bool responseBody = true,
  bool error = true,
  int maxWidth = 90,
  bool compact = true,
  void Function(Object object) logPrint = print,
}) =>
    enablePrettyLogger(
      dios,
      debugModeOnly: debugModeOnly,
      request: request,
      requestHeader: requestHeader,
      requestBody: requestBody,
      responseHeader: responseHeader,
      responseBody: responseBody,
      error: error,
      maxWidth: maxWidth,
      compact: compact,
      logPrint: logPrint,
    );

void disablePrettyLogger(Iterable<Dio> dios) =>
    disableInterceptor<PrettyDioLogger>(dios);

void ndDisablePrettyLogger(Iterable<Dio> dios) => disablePrettyLogger(dios);

void enableInterceptor<I extends Interceptor>(
  Iterable<Dio> dios,
  I Function() maker, {
  bool debugModeOnly = true,
}) {
  if (!debugModeOnly || kDebugMode) {
    for (var element in dios) {
      if (element.interceptors.any((element) => element is I)) {
        continue;
      }

      element.interceptors.add(maker());
    }
  }
}

void ndEnableInterceptor<I extends Interceptor>(
  Iterable<Dio> dios,
  I Function() maker, {
  bool debugModeOnly = true,
}) =>
    enableInterceptor<I>(
      dios,
      maker,
      debugModeOnly: debugModeOnly,
    );

void disableInterceptor<I extends Interceptor>(Iterable<Dio> dios) {
  for (var element in dios) {
    element.interceptors.removeWhere(
      (element) => element is I,
    );
  }
}

void ndDisableInterceptor<I extends Interceptor>(Iterable<Dio> dios) =>
    disableInterceptor<I>(dios);
