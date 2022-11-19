import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class VoiceService {
  Future<VoiceResult> analyzeDogVoice(File audioFile) async {
    final response = await http.get(
      Uri.parse(
        'https://raw.githubusercontent.com/MarrMika/petty_app/main/app_config.json',
      ),
    );

    final body = json.decode(response.body);

    final audioUri = body['audioFileProcessingServiceUrl'];

    print('audioUri: $audioUri');

    final audioRequest =
        await http.MultipartRequest('POST', Uri.parse(audioUri))
          ..files.add(
            await http.MultipartFile.fromPath(
              'audio',
              audioFile.path,
              contentType: MediaType('audio', 'aac'),
            ),
          );

    final audioResult = await audioRequest.send();

    if (audioResult.statusCode < 200 || audioResult.statusCode >= 300) {
      throw new Exception('API is not working: ${audioResult.statusCode}');
    }

    final respObject = json.decode(await audioResult.stream.bytesToString());

    print('respObject: $respObject');

    return VoiceResult.fromJson(respObject);
  }
}

class VoiceItem {
  String name;
  double value;

  VoiceItem({
    required this.name,
    required this.value,
  }) {}
}

class VoiceResult {
  final double sad;
  final double angry;
  final double happy;
  final double arrogant;
  final double aggressive;

  VoiceResult.fromJson(Map<String, dynamic> json)
      : sad = json['result']['sad'] ?? 0.0,
        angry = json['result']['angry'] ?? 0.0,
        happy = json['result']['happy'] ?? 0.0,
        arrogant = json['result']['arrogant'] ?? 0.0,
        aggressive = json['result']['aggressive'] ?? 0.0;

  List<VoiceItem> getList() {
    List<VoiceItem> list = [];

    list.add(VoiceItem(name: 'sad', value: sad));
    list.add(VoiceItem(name: 'angry', value: angry));
    list.add(VoiceItem(name: 'happy', value: happy));
    list.add(VoiceItem(name: 'arrogant', value: arrogant));
    list.add(VoiceItem(name: 'aggressive', value: aggressive));

    return list;
  }
}



//Mocked response for audio processiong
// {
//   "result": {
//     "happy": 0.69,
//     "angry": 0.39,
//     "aggressive": 0.49,
//     "arrogant": 0.98,
//     "sad": 0.70
//   }
// }