main(List<String> args) {
  const List<Person> a = const [Person('Edison', 25)];

  var b = [];
  b.add(a[0]);
  b[0].age = 23;
  print(b[0].age);
}

class Person {
  final String name;
  final int age;

  const Person(this.name, this.age);
}
