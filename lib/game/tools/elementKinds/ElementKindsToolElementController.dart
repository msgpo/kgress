import 'dart:ui';

import 'package:kevin_gamify/game/controller/area_context.dart';
import 'package:kevin_gamify/game/controller/element_controllers.dart';
import 'package:kevin_gamify/game/elements/element.dart';
import 'package:kevin_gamify/game/imagesets/element_drawers.dart';
import 'package:kevin_gamify/game/states/states.dart';

class ElementKindsToolElementController extends ElementController {

  /// State that the user wants to try simulating
  State _state = stationary;

  ElementKindsToolElementController(Element element, ElementDrawerRepository elementDrawersRepo) : super(element, elementDrawersRepo: elementDrawersRepo);

  void setState(State state) {
    _state = state;
  }

  @override
  Rect onUpdate(double timePassedSeconds, Element element,
      AreaContext context) {
    element.state = _state;
  }


}

class ElementKindsToolElementControllersRepository with ElementControllerRepository {

  ElementDrawerRepository _elementDrawerRepository;

  Function(ElementController) elementControlCreatedCallbackToSeparateSystem;

  ElementKindsToolElementControllersRepository(this._elementDrawerRepository, {Function(ElementController) createCallback = null}) {
    this.elementControlCreatedCallbackToSeparateSystem = createCallback;
  }

  @override
  ElementController getController(Element element) {
    ElementController ret = ElementKindsToolElementController(element, _elementDrawerRepository);
    if(elementControlCreatedCallbackToSeparateSystem != null) {
      elementControlCreatedCallbackToSeparateSystem(ret);
    }
    return ret;
  }
}