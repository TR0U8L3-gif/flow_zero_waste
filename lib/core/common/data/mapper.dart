/// Mapper class to map data from one object to another
abstract class Mapper<model, entity> {
  /// map model to entity
  entity from(model object);

  /// map entity to model
  model to(entity object);
}
