class Player {
  final String name;
  bool state;

  Player(this.name, this.state);
  void toggleCheck() {
    // print("inside");
    state = !state;
  }
}
