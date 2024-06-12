enum RiveFileSource {
  asset,
  network,
  file,
}

class RiveWidget {
  final String name;
  final RiveFileSource source;

  const RiveWidget.asset(this.name) : source = RiveFileSource.asset;
  // const RiveWidget.network(this.name);
  // const RiveWidget.file(this.name);
}
