class Photo{
  int? id;
  String? name;
  String? path;

  Photo({this.id, this.name,this.path});

  Photo.fromMap(Map<String, dynamic> map){
    id = map["id"];
    name = map["name"];
    path = map ["path"];
  }

  Map<String, dynamic> toMap() => {'name': name, 'path': path,};
}