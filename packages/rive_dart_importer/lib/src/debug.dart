/// Print a message only when running in debug.
void printDebugMessage(String message) {
  assert(() {
    print(message);
    return true;
  }());
}
