import 'package:flame/animation.dart';
import 'dart:ui';
import 'package:kevin_gamify/game/components/Direction.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';

/// The actual animations / images for drawing a [Character]
abstract class CharacterAnimations {

}

/// Animations for handling a character that can move around on the screen
class DirectionalCharacterAnimations {

  Map<Direction, Animation> _directionAnimations = {};

  double height = 64.0;
  double width = 64.0;

  DirectionalCharacterAnimations() {

    Animation downAnimation = Animation.sequenced('player_character.png',
      7,
      textureHeight: height,
      textureWidth: width,
      textureX: 0.0,
      textureY: 14 * height
    );

    _directionAnimations[Direction.down] = _getCharacterAnimation(4, 7);
    _directionAnimations[Direction.up] = _getCharacterAnimation(10, 7);
    _directionAnimations[Direction.left] = _getCharacterAnimation(9, 7);
    _directionAnimations[Direction.right] = _getCharacterAnimation(11, 7);
    _directionAnimations[Direction.stationary] = _getCharacterAnimation(1, 7);
  }

  Direction _direction;

  Animation _getCharacterAnimation(int sheetRow, int numFrames) {
    return Animation.sequenced('player_character.png',
        numFrames,
        textureHeight: height,
        textureWidth: width,
        textureX: 0.0,
        textureY: sheetRow * height
    );
  }

  Image nextFrame() {
    return _directionAnimations[_direction].getSprite().image;
  }

  Sprite nextSprite() {
    return _directionAnimations[_direction].getSprite();
  }

  void update(Direction directionToTarget, double timePassedSeconds) {
    _direction = directionToTarget;
    _directionAnimations[_direction].update(timePassedSeconds);
  }





}