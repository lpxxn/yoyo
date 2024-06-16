import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

void sendTopicMsg() async {
  final dio = Dio();

  // Configure Dio to use mTLS with CA certificate, client certificate, and private key
  (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    SecurityContext context = SecurityContext(withTrustedRoots: false);

    // Set the trusted CA certificate
    context.setTrustedCertificates('path/to/AmazonRootCA1.pem');

    // Set the client certificate and private key
    context.useCertificateChain('path/to/certificate.pem.crt');
    context.usePrivateKey('path/to/private.pem.key');

    return HttpClient(context: context);
  };

  // The topic to publish to and the message
  const topic = 'testDeviceType/common';
  final message = {
    'message': 'Hello, world',
  };

  // The endpoint URL
  const endpoint =
      'https://a244sdkbxgj2hu.ats.iot.cn-north-1.amazonaws.com.cn:8443/topics/$topic?qos=1';

  try {
    // Send the POST request with the message
    final response = await dio.post(
      endpoint,
      data: jsonEncode(message),
    );

    // Handle the response
    print('Response status: ${response.statusCode}');
    print('Response data: ${response.data}');
  } catch (e) {
    print('Error: $e');
  }
}
