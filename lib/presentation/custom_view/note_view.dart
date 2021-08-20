import 'package:flutter/material.dart';
import 'package:todo_sandbox/core/constants/colors.dart';
import 'package:todo_sandbox/core/manager/vibration_manager.dart';
import 'package:todo_sandbox/data/models/note_model.dart';

class NoteView extends StatefulWidget {
  final NoteModel model;
  final Function onClicked;
  final VoidCallback? onLongPressed;
  final bool isSelected;

  const NoteView({
    Key? key,
    required this.model,
    required this.onClicked,
    this.onLongPressed,
    this.isSelected = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView>
    with SingleTickerProviderStateMixin {
  bool isSelected = false;

  late AnimationController _animationController;
  late Animatable<Color> _animation;

  final Color _selectedColorBg = Colors.grey.withOpacity(0.5);

  @override
  void initState() {
    super.initState();

    initAnimationComponents();

    isSelected = widget.isSelected;
  }

  void initAnimationComponents() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = TweenSequence<Color>(<TweenSequenceItem<Color>>[
      TweenSequenceItem<Color>(
        tween: Tween<Color>(
          begin: Colors.white,
          end: _selectedColorBg,
        ),
        weight: 2.0,
      )
    ]);

    _animation.animate(_animationController);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              border: Border.all(color: Colors.grey.withOpacity(0.5))),
          child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              color: isSelected ? _selectedColorBg : Colors.white,
              child: InkWell(
                splashColor: primaryColor,
                onTap: () => widget.onClicked.call(),
                onLongPress: _onSelectedStateChanged,
                child: Column(
                  children: <Widget>[
                    if (widget.model.hasFilledTitle) buildTitleView(),
                    if (widget.model.hasFilledContent) buildContentView()
                  ],
                ),
              )),
        ),
      );

  ListTile buildContentView() => ListTile(
        title: Text(widget.model.content,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            )),
      );

  ListTile buildTitleView() => ListTile(
      title: Text(widget.model.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          )));

  Future<void> _onSelectedStateChanged() async {
    isSelected = !isSelected;

    widget.onLongPressed?.call();

    if (isSelected) {
      VibrationManager.vibrateIfCan();
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
