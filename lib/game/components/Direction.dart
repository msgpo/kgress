import 'dart:ui';
import 'dart:core';

enum Direction {
  up,
  down,
  left,
  right,
  stationary
}

class Directions {

  static Direction of({from: Rect, to: Rect}) {

    double deltaX = (from.left - to.left).abs();
    double deltaY = (from.top - to.top).abs();

    if(deltaX - deltaY > 0) {         //  The x-component is larger than the y-component of the difference between points
      if(from.left > to.left) {
        return Direction.left;
      }
      return Direction.right;
    } else if (deltaX - deltaY < 0) { //  The y-component is larger than the x-component of the differences between points
      if(from.top < to.top) {
        return Direction.up;
      }
      return Direction.down;
    }

    return Direction.stationary;
  }

  static Direction forOffset(Offset to) {

    if(to.dx.abs() > to.dy.abs()) {
      if (to.dx > 0) {
        return Direction.right;
      }
      if (to.dx < 0) {
        return Direction.left;
      }
    }

  }

  static Direction opposite({of: Direction}) {
    if(of == Direction.left || of == Direction.right) {
      return of == Direction.left ? Direction.right : Direction.left;
    }
    else if(of == Direction.up || of == Direction.down) {
      return of == Direction.up ? Direction.down : Direction.up;
    }

    return Direction.stationary;
  }

  static double delta({d: double, direction: Direction}) {
    if(isHorizontal(direction)) {
      return direction == Direction.right ? d : -d;
    }
    else if (isVertical(direction)) {
      return direction == Direction.down ? d : -d;
    }

    return 0; //  Stationary = 0 delta
  }

  static isHorizontal(Direction direction) {
    return direction == Direction.left || direction == Direction.right;
  }

  static isVertical(Direction direction) {
    return direction == Direction.up || direction == Direction.down;
  }

}