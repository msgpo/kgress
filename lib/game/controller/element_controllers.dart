import 'dart:ui';

import 'package:kevin_gamify/game/elements/element.dart';
import 'package:kevin_gamify/game/imagesets/element_drawers.dart';

abstract class ElementController {

  Element _element;

  ElementDrawer _imageSetProvider;

  ElementController(Element element, {ElementDrawerRepository elementDrawersRepo}){
    _element = element;
    _imageSetProvider = elementDrawersRepo.getDrawer(_element);
  }

  /// Update the element.  Returns the [Rect] corresponding to the element's
  /// current position in the game world, NOT necessarily its current position
  /// on the screen.
  Rect update(double timePassedSeconds) {
    Rect ret = onUpdate(timePassedSeconds, _element);
    _imageSetProvider.update(_element.state, timePassedSeconds);
    return ret;
  }

  Rect onUpdate(double timePassedSeconds, Element element);

  /// Draw the element on the screen into the given rectangle
  void draw(Rect rect, Paint paint, Canvas canvas) {
    _imageSetProvider.drawNextFrame(rect, paint, canvas);
  }

}

class StationaryElementController extends ElementController {
  StationaryElementController(Element element, ElementDrawerRepository elementDrawersRepo) : super(element, elementDrawersRepo: elementDrawersRepo);

  @override
  Rect onUpdate(double timePassedSeconds, Element element) {
    //  Nothing to do here
  }

}

/// Access to appropriate element controllers
mixin ElementControllerRepository {

  ElementController getController(Element element);

}