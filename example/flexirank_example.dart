import 'package:flexirank/flexirank.dart';

void main(List<String> arguments) {
  switch (arguments[0]) {
    case 'encode':
      try {
        final parsedNum = num.parse(arguments[1]);
        int? bucketSize;
        if (arguments.length > 2) {
          bucketSize = int.parse(arguments[2]);
        }
        print('Encoded string: ${FlexiRank.encodedString(parsedNum, bucketSize: bucketSize)}');
      } catch (e) {
        print(e);
      }
    case 'decode':
      print('Decoded value: ${FlexiRank.decodeString(arguments[1])}');
    default:
      print('Invalid arguments.\n\nUsage:\nencode <number> <optional-bucket-size>\ndecode <number>');
  }
}
