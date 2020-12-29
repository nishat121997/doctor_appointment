class User {
  String SerialNo;
  String Name;
  String gender;
  String age;

  User({this.SerialNo, this.Name, this.gender, this.age});

  static List<User> getUsers() {
    return <User>[
      User(SerialNo: "1", Name: "Shah", gender: "Male", age: "30"),
      User(SerialNo: "2", Name: "John", gender: "Female", age: "40"),
      User(SerialNo: "3", Name: "Brown", gender: "Male", age: "56"),
      User(SerialNo: "4", Name: "Sen", gender: "Male", age: "53"),
      User(SerialNo: "5", Name: "Jane", gender: "Male", age: "23"),
    ];
  }
}
