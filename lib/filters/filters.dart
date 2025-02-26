import 'dart:ui';

class ColorFilters {
  static const ColorFilter none = ColorFilter.mode(
    Color(0x00000000), // Sin filtro
    BlendMode.dst,
  );

  static const ColorFilter greyscale = ColorFilter.matrix([
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ]);

  static const ColorFilter sepia = ColorFilter.matrix([
    0.393, 0.769, 0.189, 0, 0,
    0.349, 0.686, 0.168, 0, 0,
    0.272, 0.534, 0.131, 0, 0,
    0, 0, 0, 1, 0,
  ]);

  static const ColorFilter invert = ColorFilter.matrix([
    -1,  0,  0,  0, 255,
    0, -1,  0,  0, 255,
    0,  0, -1,  0, 255,
    0,  0,  0,  1,   0,
  ]);
}
