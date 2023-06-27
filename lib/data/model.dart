import 'package:objectbox/objectbox.dart';

//terminal: flutter pub run build_runner build

@Entity()
class FantasticBeastEntity {
  @Id()
  int id;
  String name;
  String description;
  String photo;

  FantasticBeastEntity({
    this.id =0,
    required this.name,
    required this.description,
    required this.photo,
  });
}
