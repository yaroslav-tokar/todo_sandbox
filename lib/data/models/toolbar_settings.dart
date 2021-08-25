class ToolbarSettings {
  String? title;
  final bool hasBackButton;
  final bool? hasLeftCloseButton;
  final Function? onLeftCloseButtonTapped;

  ToolbarSettings({
    this.hasLeftCloseButton = false,
    this.onLeftCloseButtonTapped,
    this.hasBackButton = false,
    this.title,
  });
}
