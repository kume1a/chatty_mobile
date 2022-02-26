abstract class DataChannel<T extends Object?> {
  Stream<T> get events;

  Future<void> startListening();

  Future<void> stopListening();
}
