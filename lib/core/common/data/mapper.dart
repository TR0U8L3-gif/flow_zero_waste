/// Mapper class to map data from one object to another
abstract class Mapper<Obj1, Obj2> {
  /// map Obj2 to Obj1
  Obj1 from(Obj2 object);

  /// map Obj1 to Obj2
  Obj2 to(Obj1 object);
}
