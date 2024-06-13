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

/// Check if an iterable is equal to another iterable. Iterables are considered
/// equal if they have the same number of values and each of those values are
/// equal. A custom [equalityCheck] can be provided for objects that don't
/// override their equality operator or need to be deemed equal based on varying
/// application logic.
bool iterableEquals<T>(Iterable<T>? list1, Iterable<T>? list2,
    {bool Function(T a, T b)? equalityCheck}) {
  if (list1 == null || list2 == null) {
    return false;
  }
  if (identical(list1, list2)) return true;
  int length = list1.length;
  if (length != list2.length) return false;

  var a = list1.iterator;
  var b = list2.iterator;
  // A little more verbose to wrap the loop with the conditional but more
  // efficient at runtime.
  if (equalityCheck != null) {
    // Iterator starts at null current value, must be moved to first value.
    while (a.moveNext() && b.moveNext()) {
      if (!equalityCheck(a.current, b.current)) {
        return false;
      }
    }
  } else {
    // Iterator starts at null current value, must be moved to first value.
    while (a.moveNext() && b.moveNext()) {
      if (a.current != b.current) {
        return false;
      }
    }
  }

  return true;
}

/// Checks that all the retrieved values for an item are the same. If they're
/// the same, it returns the equal value, otherwise it'll return null.  A custom
/// [equalityCheck] can be provided for objects that don't override their
/// equality operator or need more sophisticated rules of equality (for example
/// if your [K] is a collection). TODO: have two functions; one to check is all
/// are equal, another to get the value?
K? equalValue<T, K>(Iterable<T> items, K? Function(T a) getValue,
    {bool Function(K? a, K? b)? equalityCheck}) {
  if (items.isEmpty) {
    return null;
  }

  var iterator = items.iterator;
  // Move to first value.
  iterator.moveNext();
  K? value = getValue(iterator.current);

  // A little more verbose to wrap the loop with the conditional but more
  // efficient at runtime.
  if (equalityCheck != null) {
    while (iterator.moveNext()) {
      if (!equalityCheck(value, getValue(iterator.current))) {
        return null;
      }
    }
  } else {
    while (iterator.moveNext()) {
      if (value != getValue(iterator.current)) {
        return null;
      }
    }
  }
  return value;
}

/// Returns true if all the elemnts in iterable1 are contained in iterable2.
/// Assumes there are no dupes in either iterable.
bool setEquals<T>(Iterable<T>? it1, Iterable<T>? it2) {
  if (it1 == null || it2 == null) {
    return false;
  }
  if (it1.length != it2.length) {
    return false;
  }
  for (final a in it1) {
    if (!it2.contains(a)) {
      return false;
    }
  }
  return true;
}
