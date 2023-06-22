typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String message);

class LoadingScreenController {
  final CloseLoadingScreen closeLoadingScreen;
  final UpdateLoadingScreen updateLoadingScreen;

  LoadingScreenController(
      {required this.closeLoadingScreen, required this.updateLoadingScreen});
}
