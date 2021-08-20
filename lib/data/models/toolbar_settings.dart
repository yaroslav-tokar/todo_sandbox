class ToolbarSettings {
  final bool hasLeftCloseButton;
  final Function? onLeftCloseButtonTapped;
  final bool hasTitle;

  ToolbarSettings({
    this.hasLeftCloseButton = false,
    this.hasTitle = false,
    this.onLeftCloseButtonTapped,
  });
}
