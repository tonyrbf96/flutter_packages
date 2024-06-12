<h1 align="center">
  EducUp Clients
</h1>

<p align="center">
  <img src="https://user-images.githubusercontent.com/36774373/167951672-c8bf5ddb-bcea-4b3a-b4d3-cdb036d75f2f.png" width="350"/>
</p>

<p align="center">
  A mono repository with the <a href="https://dart.dev">Dart</a> and <a href="https://flutter.dev">Flutter</a> projects of the <a href="https://educup.io">EducUp</a> platform.
</p>

<hr>

## Getting Started

- [Install Flutter](https://docs.flutter.dev/get-started/install)
- Run the command `flutter doctor` and check that all be fine
- Clone this [repo](https://github.com/educup/educup-clients) running the command `git clone https://github.com/educup/educup-clients.git`
- Enter to the repo folder running the command `cd educup-clients`
- [Install Melos](https://melos.invertase.dev) running the command `dart pub global activate melos`
- [Install Mason CLI](https://pub.dev/packages/mason_cli) running the command `dart pub global activate mason_cli`
- [Install Lockpick](https://pub.dev/packages/lockpick) running the command `dart pub global activate lockpick`
- Download and auto-reference the necessary dependencies running the command `melos bs`
- Download the necessary bricks running the command `mason get`
- Generate the Dart files running the command `melos gen:dart:all --no-select`
- Generate the Flutter files running the command `melos gen:flutter:all --no-select`
