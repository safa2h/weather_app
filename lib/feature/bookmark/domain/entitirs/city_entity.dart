import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity()
class City extends Equatable {
  @PrimaryKey(autoGenerate: true)
  int? id;
  double lat;
  double lon;

  final String name;

  City(this.name,this.lat,this.lon);

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
