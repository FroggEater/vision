#ifndef INCLUDE_COLOR_COMMON
#define INCLUDE_COLOR_COMMON

#include "/lib/math.glsl"

/* ---------------------------------- GAMMA --------------------------------- */

vec3 fastestGammaToLinear(vec3 color) {
  return sq(color);
}
vec3 fastestLinearToGamma(vec3 color) {
  return sqrt(color);
}

vec3 fastGammaToLinear(vec3 color) {
  return pow(color, vec3(2.2));
}
vec3 fastLinearToGamma(vec3 color) {
  return pow(color, vec3(1.0 / 2.2));
}

vec3 gammaToLinear(vec3 color) {
  float a = 12.92;
  float b = 0.055;
  float g = 2.4;
  float t = 0.04045;

  return vec3(
    (color.r <= t) ? color.r / a : pow((color.r + b) / (1.0 + b), g),
    (color.g <= t) ? color.g / a : pow((color.g + b) / (1.0 + b), g),
    (color.b <= t) ? color.b / a : pow((color.b + b) / (1.0 + b), g)
  );
}
vec3 linearToGamma(vec3 color) {
  float a = 12.92;
  float b = 0.055;
  float g = 2.4;
  float t = 0.0031308;

  return vec3(
    (color.r <= t) ? color.r * a : (1.0 + b) * pow(color.r, 1.0 / g) - b,
    (color.g <= t) ? color.g * a : (1.0 + b) * pow(color.g, 1.0 / g) - b,
    (color.b <= t) ? color.b * a : (1.0 + b) * pow(color.b, 1.0 / g) - b
  );
}

#endif // INCLUDE_COLOR_COMMON