class UnsetEnvError extends Error {
  UnsetEnvError([this.message]);

  final String? message;
}
