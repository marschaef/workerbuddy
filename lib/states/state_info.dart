// State info classes to manage state updates

abstract class StateInfo {
  const StateInfo();
}

// Initial state
class StateInitial extends StateInfo {}

// Loading state
class StateLoading extends StateInfo {}

// Succesfully state
class StateSuccessful extends StateInfo {}

// Error state
class StateError extends StateInfo {
  final String message;
  StateError({required this.message});
}