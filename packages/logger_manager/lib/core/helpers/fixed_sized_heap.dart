/// A fixed-size heap that keeps the top N values.
class FixedSizeHeap<Type> {
  /// Creates a new fixed-size heap with the given [maxSize].
  FixedSizeHeap({required this.maxSize, this.stringifyObject});

  /// The maximum number of values to keep in the heap.
  final int maxSize;
  /// The heap that keeps the top N values.
  final List<Type> _heap = [];
  /// A function that converts the object to a string.
  final String Function(Type object)? stringifyObject;

  /// Pushes a new value into the heap.
  void push(Type value) {
    if (_heap.length >= maxSize) {
      // Remove the last value to make space for the new value
      _heap.removeLast();
    }
    // Insert the new value at the start
    _heap.insert(0, value);
  }

  /// Clears all values from the heap.
  void clearAll() {
    _heap.clear();
  }

  /// Returns the values in the heap.
  List<Type> get heap => List.unmodifiable(_heap);

  /// Returns `true` if the heap is full.
  bool get isFull => _heap.length == maxSize;

  @override
  String toString() => '(${_heap.length}) [${_heap.map(
        (e) => stringifyObject?.call(e) ?? e.toString(),
      ).join(', ')}]';
}
