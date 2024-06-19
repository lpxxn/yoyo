import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

const endpoint =
    'https://a244sdkbxgj2hu.ats.iot.cn-north-1.amazonaws.com.cn:8443';
// The scanBleTopic to publish to and the message
const scanBleTopic = 'testDeviceType/msg/scanBle';
const unlockScreenTopic = 'testDeviceType/msg/unlockScreen';

enum IotTopic { scanBleTopic, unlockScreenTopic }

String getEndpoint(String endpoint, IotTopic topic) {
  var selectedTopic = scanBleTopic;
  if (topic == IotTopic.unlockScreenTopic) {
    selectedTopic = unlockScreenTopic;
  }
  return '$endpoint/topics/${selectedTopic}?qos=1';
}

void sendMsg(String endpoint, IotTopic topic, Map<String, String> message) async {
  final dio = Dio();

  dio.httpClientAdapter = IOHttpClientAdapter()
    ..createHttpClient = () {
      SecurityContext context = SecurityContext(withTrustedRoots: false);

      // Set the trusted CA certificate
      context.setTrustedCertificates('path/to/AmazonRootCA1.pem');

      // Set the client certificate and private key
      context.useCertificateChain('path/to/certificate.pem.crt');
      context.usePrivateKey('path/to/private.pem.key');

      return HttpClient(context: context);
    };

  // final message = {
  //   'message': 'Hello, world',
  // };

  // The endpoint URL

  // const endpoint =
  //     'https://a244sdkbxgj2hu.ats.iot.cn-north-1.amazonaws.com.cn:8443/topics/$scanBleTopic?qos=1';

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
