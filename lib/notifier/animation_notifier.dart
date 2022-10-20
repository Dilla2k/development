import 'package:flutter/widgets.dart';

class AnimateNotifier with ChangeNotifier {
  bool _animate = false;
  AnimationController _animationController;

  bool get animate => _animate;

  AnimationController get animationController => _animationController;

  void setAnimationController(AnimationController animationController) {
    if (_animationController != animationController) {
      _animationController = animationController;
      notifyListeners();
    }
  }

  void setAnimate(bool animate) {
    if (_animate != animate) {
      _animate = animate;
      notifyListeners();
    }
  }
}
