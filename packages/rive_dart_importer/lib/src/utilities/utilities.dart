import 'dart:typed_data';

export 'binary_buffer/binary_reader.dart';
export 'binary_buffer/binary_writer.dart';

/// Szudzik's function for hashing two ints together
int szudzik(int a, int b) {
  // a and b must be >= 0
  int x = a.abs();
  int y = b.abs();
  return x >= y ? x * x + x + y : x + y * y;
}

String byteToHex(int byte) {
  return byte.toRadixString(16).padLeft(2, '0');
}

/// Adapted from:
/// https://github.com/daegalus/dart-uuid/blob/main/lib/parsing.dart
///
/// Unparses a [buffer] of bytes and outputs a proper UUID string.
///
/// Throws a [RangeError] exception if the [buffer] is not large enough to
/// hold the bytes.
String formatUuid(Uint8List buffer) {
  if (buffer.length < 16) {
    throw RangeError('buffer too small: need 16: length=${buffer.length}');
  }
  var i = 0;
  return '${byteToHex(buffer[i++])}${byteToHex(buffer[i++])}'
      '${byteToHex(buffer[i++])}${byteToHex(buffer[i++])}'
      '-'
      '${byteToHex(buffer[i++])}${byteToHex(buffer[i++])}'
      '-'
      '${byteToHex(buffer[i++])}${byteToHex(buffer[i++])}'
      '-'
      '${byteToHex(buffer[i++])}${byteToHex(buffer[i++])}'
      '-'
      '${byteToHex(buffer[i++])}${byteToHex(buffer[i++])}'
      '${byteToHex(buffer[i++])}${byteToHex(buffer[i++])}'
      '${byteToHex(buffer[i++])}${byteToHex(buffer[i++])}';
}

Uint8List uuidVariant2(Uint8List uuidBuffer) {
  return Uint8List.fromList([
    uuidBuffer[3],
    uuidBuffer[2],
    uuidBuffer[1],
    uuidBuffer[0],
    // -
    uuidBuffer[5],
    uuidBuffer[4],
    // -
    uuidBuffer[7],
    uuidBuffer[6],
    // -
    uuidBuffer[9],
    uuidBuffer[8],
    // -
    uuidBuffer[15],
    uuidBuffer[14],
    uuidBuffer[13],
    uuidBuffer[12],
    uuidBuffer[11],
    uuidBuffer[10],
  ]);
}

bool listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) {
    return b == null;
  }
  if (b == null || a.length != b.length) {
    return false;
  }
  if (identical(a, b)) {
    return true;
  }
  for (int index = 0; index < a.length; index += 1) {
    if (a[index] != b[index]) {
      return false;
    }
  }
  return true;
}

/// Location of an integer within a bitfield.
/// https://en.wikipedia.org/wiki/C_syntax#Bit_fields
class BitFieldLoc {
  final int start;
  final int count;
  final int mask;

  const BitFieldLoc(this.start, int end)
      : assert(end >= start),
        // Rive runtime only supports 32 bits per field. Pack multiple bitfields
        // if you need more.
        assert(end < 32),
        count = end - start + 1,
        mask = ((1 << (end - start + 1)) - 1) << start;

  int read(int bits) => (bits & mask) >> start;
  int write(int bits, int value) => (bits & ~mask) | ((value << start) & mask);
}
