class Task {
  int? _id;
  int? _done;
  String? _name;
  String? _numberDays;

  Task(dynamic obj) {
    _id = obj['id'];
    _done = obj['done'];
    _name = obj['name'];
    _numberDays = obj['numberDays'];
  }

  //Method that converts the Task object to a Map
  toMap() {
    var map = {
      'id': _id,
      'done': _done,
      'name': _name,
      'numberDays': _numberDays,
    };
    return map;
  }

  //Named constructor that takes a Map as an argument.
  //it initializes the private variables _id, _done, _name, and _numberDays with values from the map.
  Task.fromMap(Map map) {
    _id = map['id'];
    _done = map['done'];
    _name = map['name'];
    _numberDays = map['numberDays'];
  }

  get id => _id;
  get done => _done;
  get name => _name;
  get numberDays => _numberDays;
}
