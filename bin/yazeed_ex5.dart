import 'dart:convert';
import 'dart:io';
import 'package:web_socket_channel/io.dart';

void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((message) {
    final decodedMessage = jsonDecode(message);
    final name = decodedMessage['history'];
    final list = decodedMessage['active_symbols'];
    channel.sink.close();
  });

  print('Please Enter Symbol Name : ');
  final userInput = stdin.readLineSync();
  channel.sink.add(
      '{"ticks_history":"$userInput","adjust_start_time":1,"count":10,"end":"latest","start":1,"style":"ticks"}');
}
