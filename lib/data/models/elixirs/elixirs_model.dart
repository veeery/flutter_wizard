import 'package:equatable/equatable.dart';

class ElixirsModel extends Equatable {
  final String id;
  final String name;

  const ElixirsModel({
    required this.id,
    required this.name,
  });

  factory ElixirsModel.fromJson(Map<String, dynamic> json) {
    return ElixirsModel(
      id: json['id'],
      name: json['name'],
    );
  }

  ElixirsModel toEntity() {
    return ElixirsModel(id: id, name: name);
  }

  @override
  List<Object> get props => [id, name];
}
