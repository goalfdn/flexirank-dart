import 'package:flexirank/flexirank.dart';
import 'package:test/test.dart';

void main() {
  group('Testing decodeString function', () {
    test('A', () {
      expect(FlexiRank.decodeString('A'), 0);
    });

    test('a', () {
      expect(FlexiRank.decodeString('a'), 0);
    });

    test('M', () {
      expect(FlexiRank.decodeString('M'), 12);
    });

    test('m', () {
      expect(FlexiRank.decodeString('m'), 12);
    });

    test('Z', () {
      expect(FlexiRank.decodeString('Z'), 25);
    });

    test('z', () {
      expect(FlexiRank.decodeString('z'), 25);
    });

    test('4', () {
      expect(() => FlexiRank.decodeString('4'), throwsException);
    });

    test('sj', () {
      expect(FlexiRank.decodeString('sj'), 477);
    });

    test('bn', () {
      expect(FlexiRank.decodeString('bn'), 39);
    });

    test('dtx', () {
      expect(FlexiRank.decodeString('dtx'), 2545);
    });

    test('mke', () {
      expect(FlexiRank.decodeString('mke'), 8376);
    });

    test('cyli', () {
      expect(FlexiRank.decodeString('cyli'), 51670);
    });

    test('fqva', () {
      expect(FlexiRank.decodeString('fqv', bucketSize: 4), 99242);
    });

    test('awpoh', () {
      expect(FlexiRank.decodeString('awpoh'), 397183);
    });

    test('grauz', () {
      expect(FlexiRank.decodeString('grauz'), 3041193);
    });

    test('zaaaaa', () {
      expect(FlexiRank.decodeString('z', bucketSize: 6), 297034400);
    });

    test('aaaaaz', () {
      expect(FlexiRank.decodeString('aaaaaz'), 25);
    });

    test('nuroverse', () {
      expect(FlexiRank.decodeString('nuroverse'), 2880815629228);
    });
  });

  group('Testing encodedString function', () {
    test('0', () {
      expect(FlexiRank.encodedString(0, bucketSize: 1), 'a');
    });

    test('12', () {
      expect(FlexiRank.encodedString(12), 'm');
    });

    test('25', () {
      expect(FlexiRank.encodedString(25), 'z');
    });

    test('13.5', () {
      expect(FlexiRank.encodedString(13.5), 'n');
    });

    test('477', () {
      expect(FlexiRank.encodedString(477), 'sj');
    });

    test('39', () {
      expect(FlexiRank.encodedString(39), 'bn');
    });

    test('2545', () {
      expect(FlexiRank.encodedString(2545), 'dtx');
    });

    test('8376', () {
      expect(FlexiRank.encodedString(8376), 'mke');
    });

    test('51670', () {
      expect(FlexiRank.encodedString(51670), 'cyli');
    });

    test('99242', () {
      expect(FlexiRank.encodedString(99242), 'fqva');
    });

    test('397183', () {
      expect(FlexiRank.encodedString(397183, bucketSize: 5), 'awpoh');
    });

    test('3041193', () {
      expect(FlexiRank.encodedString(3041193), 'grauz');
    });

    test('297034400', () {
      expect(FlexiRank.encodedString(297034400), 'zaaaaa');
    });

    test('aaaaaz', () {
      expect(FlexiRank.encodedString(25, bucketSize: 6), 'aaaaaz');
    });

    test('nuroverse', () {
      expect(FlexiRank.decodeString('nuroverse'), 2880815629228);
    });
  });

  group('Testing newRank function', () {
    test('Between a & z', () {
      expect(FlexiRank.newRank(), 'm');
    });

    test('Between m & z', () {
      expect(FlexiRank.newRank(previousItemRank: 'm'), 's');
    });

    test('Between s & z', () {
      expect(FlexiRank.newRank(previousItemRank: 's'), 'v');
    });

    test('Between v & z', () {
      expect(FlexiRank.newRank(previousItemRank: 'v'), 'x');
    });

    test('Between x & z', () {
      expect(FlexiRank.newRank(previousItemRank: 'x'), 'ya');
    });

    test('Between ya & z', () {
      expect(FlexiRank.newRank(previousItemRank: 'ya'), 'yn');
    });

    test('Between a & m', () {
      expect(FlexiRank.newRank(nextItemRank: 'm'), 'g');
    });

    test('Between a & g', () {
      expect(FlexiRank.newRank(nextItemRank: 'g'), 'd');
    });

    test('Between a & d', () {
      expect(FlexiRank.newRank(nextItemRank: 'd'), 'bn');
    });

    test('Between a & bn', () {
      expect(FlexiRank.newRank(nextItemRank: 'bn'), 'at');
    });

    test('Between at & bn', () {
      expect(FlexiRank.newRank(previousItemRank: 'at', nextItemRank: 'bn'), 'bd');
    });

    test('Between bd & bn', () {
      expect(FlexiRank.newRank(previousItemRank: 'bd', nextItemRank: 'bn'), 'bi');
    });

    test('Between bi & bn', () {
      expect(FlexiRank.newRank(previousItemRank: 'bi', nextItemRank: 'bn'), 'bk');
    });

    test('Between bk & bn', () {
      expect(FlexiRank.newRank(previousItemRank: 'bk', nextItemRank: 'bn'), 'bln');
    });

    test('Between e & fkeo', () {
      expect(FlexiRank.newRank(previousItemRank: 'e', nextItemRank: 'fkeo'), 'esch');
    });

    test('Between e & x, with bucket size 3', () {
      expect(FlexiRank.newRank(previousItemRank: 'e', nextItemRank: 'x', bucketSize: 3), 'nna');
    });
  });
}
