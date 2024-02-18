import 'dart:math';

class FlexiRank {
  static num decodeString(String str, {int? bucketSize}) {
    String chars = str.toLowerCase();
    num decodedValue = 0;

    if (bucketSize != null && bucketSize > str.length) {
      chars = chars.padRight(bucketSize, 'a');
    }

    num digitValue = 1;
    while (chars.isNotEmpty) {
      final charVal = chars.codeUnitAt(chars.length - 1);

      if (charVal < 97 || charVal > 122) {
        throw Exception('Invalid character found: ${chars[chars.length - 1]}');
      }

      decodedValue += (digitValue * (charVal - 97));
      digitValue *= 26;
      chars = chars.substring(0, chars.length - 1);
    }

    return decodedValue;
  }

  static String encodedString(num rawValue, {int? bucketSize}) {
    String encodedResult = '';
    num roundedValue = rawValue.floor();

    while (roundedValue > 0) {
      final charValue = (roundedValue % 26).toInt();
      roundedValue = roundedValue ~/ 26;
      encodedResult = String.fromCharCode(charValue + 97) + encodedResult;
    }

    if (bucketSize != null && bucketSize > encodedResult.length) {
      encodedResult = encodedResult.padLeft(bucketSize, 'a');
    }

    return encodedResult;
  }

  static String newRank({int? bucketSize, String previousItemRank = 'a', String nextItemRank = 'z'}) {
    // Calculate bucket size to be length of longest rank (if bucketSize is null or invalid)
    int calculatedBucketSize = max(previousItemRank.length, nextItemRank.length);
    if (bucketSize != null && bucketSize > calculatedBucketSize) {
      calculatedBucketSize = bucketSize;
    }

    num prevValue = 0, nextValue = 0;
    String prev = previousItemRank, next = nextItemRank;

    // Repeat while difference < 3:
    while ((nextValue - prevValue).abs() < 4) {
      if (nextValue - prevValue != 0) {
        // pad prev & next with 'a'
        prev += 'a';
        next += 'a';
        // increment bucketSize
        calculatedBucketSize += 1;
      }
      // calculate prevValue & nextValue
      prevValue = decodeString(prev, bucketSize: calculatedBucketSize);
      nextValue = decodeString(next, bucketSize: calculatedBucketSize);
      // if difference is 0: throw exception
      if (nextValue - prevValue == 0) {
        throw Exception('Both previous and next ranks cannot be equal');
      }
    }

    // newValue is calculated as average of prevValue & nextValue
    num newValue = (prevValue + nextValue) / 2;

    // Return encodedString for newValue and calculatedBucketSize
    return encodedString(newValue, bucketSize: calculatedBucketSize);
  }
}
