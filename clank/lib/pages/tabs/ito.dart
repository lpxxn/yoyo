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

void sendMsg(String endpoint, IotTopic topic, Map<String, String> message,
    String certification, String certChain, String privateKey) async {
  final dio = Dio();
  final iotEndPoint = getEndpoint(endpoint, topic);
  dio.httpClientAdapter = IOHttpClientAdapter()
    ..createHttpClient = () {
      SecurityContext context = SecurityContext(withTrustedRoots: false);

      // Set the trusted CA certificate
      // context.setTrustedCertificates('/Users/li/go/src/github.com/lpxxn/yoyo/clank/build/AmazonRootCA1.pem');
      context.setTrustedCertificatesBytes(utf8.encode(certification));
      // Set the client certificate and private key
      // context.useCertificateChain('/Users/li/go/src/github.com/lpxxn/yoyo/clank/build/certificate.pem.crt');
      context.useCertificateChainBytes(utf8.encode(certChain));
      // context.usePrivateKey('/Users/li/go/src/github.com/lpxxn/yoyo/clank/build/private.pem.key');
      context.usePrivateKeyBytes(utf8.encode(privateKey));
      return HttpClient(context: context);
    };

  // final message = {
  //   'message': 'Hello, world',
  // };

  // The endpoint URL

  // const endpoint =
  //     'https://a244sdkbxgj2hu.ats.iot.cn-north-1.amazonaws.com.cn:8443/topics/$scanBleTopic?qos=1';
  print('endpoint: $iotEndPoint');
  try {
    // Send the POST request with the message
    final response = await dio.post(
      iotEndPoint,
      data: jsonEncode(message),
    );

    // Handle the response
    print('Response status: ${response.statusCode}');
    print('Response data: ${response.data}');
  } catch (e) {
    print('Error: $e');
  }
}
