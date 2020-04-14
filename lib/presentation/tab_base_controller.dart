
abstract class TabBaseController {
  Future<void> previous();
  Future<void> next();
  Future<void> getOfDay(DateTime date);
}