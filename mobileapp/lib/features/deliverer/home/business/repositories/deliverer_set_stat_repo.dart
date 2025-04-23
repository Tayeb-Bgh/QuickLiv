abstract class DelivererSetStatRepo {
  /// Abstract method to change the status of a deliverer.
  /// Subclasses must implement this method.
  Future<void> changeDelivererStatus(bool status);
}
