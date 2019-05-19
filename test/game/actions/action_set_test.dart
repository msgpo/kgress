import 'package:kevin_gamify/game/actions/action.dart';
import 'package:kevin_gamify/game/actions/action_set.dart';
import 'package:kevin_gamify/game/actions/builtin/element_actions/action_move.dart';
import 'package:kevin_gamify/game/actions/builtin/element_actions/element_action.dart';
import 'package:kevin_gamify/game/actions/element_action_set.dart';
import 'package:kevin_gamify/game/components/Direction.dart';
import 'package:kevin_gamify/game/elements/element.dart';
import 'package:kevin_gamify/game/elements/element_kinds.dart';
import 'package:test/test.dart';

import '../element/mock_element.dart';
import '../element/mock_element_kind.dart';

void main() {

  group("Action type Validation", () {

    test("Cannot add element-specific action to a non-element-action set", () {

      expect(() =>
        ActionSet([
          Move(Direction.right, 100)
        ]), throwsA(TypeMatcher<ArgumentError>()));

    });

    test("Can add element actions to element action set", () {
      expect(() =>
          ElementActionSet(MockElement(), [
            Move(Direction.right, 100)
          ]), returnsNormally);
    });

  });

  group("Element Action Set", () {

    test("Next action properly sets element", () {

      Element element = MockElement();
      ElementActionSet set = new ElementActionSet(element, [Move(Direction.down, 100)]);
      Action next = set.nextAction();

      expect(next, isA<ElementAction>());

      ElementAction elementAction = next as ElementAction;
      expect(elementAction.element, equals(element));

    });

    test("Next action resets previous action", () {

      ElementKind kind = MockElementKind();
      Element element = Element(kind);

      ElementAction moveDown = Move(Direction.down, 1);
      ElementAction moveUp = Move(Direction.up, 1);

      ElementActionSet set = new ElementActionSet(element, [moveDown, moveUp]);
      Action next = set.nextAction();
      expect(next, equals(moveDown));
      for(int i=0; i<20; i++){
        next.act();
      }

      next = set.nextAction();
      expect(next, equals(moveUp));

      expect(moveDown.element, isNull);

    });

  });

}