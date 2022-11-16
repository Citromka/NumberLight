abstract class DetailsEvent {}

class DetailsCreated extends DetailsEvent {
  final String selectedItemId;

  DetailsCreated(this.selectedItemId);
}