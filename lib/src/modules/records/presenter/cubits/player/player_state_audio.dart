sealed class PlayerStateAudio {}

final class PlayerInitial extends PlayerStateAudio {}

final class PlayerInitialized extends PlayerStateAudio {}

final class PlayerStopped extends PlayerStateAudio {}

final class PlayerCompleted extends PlayerStateAudio {}
