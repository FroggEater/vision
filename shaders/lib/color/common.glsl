#ifndef INCLUDE_COLOR_COMMON
#define INCLUDE_COLOR_COMMON

#include "/lib/math.glsl"

const mat3 RGB2CIEXYZ = mat3(
  0.4124564, 0.3575761, 0.1804375,
  0.2126729, 0.7151522, 0.0721750,
  0.0193339, 0.1191920, 0.9503041
);
const mat3 CIEXYZ2RGB = mat3(
  3.2404542, -1.5371385, -0.4985314,
  -0.9692660, 1.8760108, 0.0415560,
  0.0556434, -0.2040259, 1.0572252
);

const vec3 CIEXYZD65 = vec3(0.950489, 1.000000, 1.088840);
const vec3 LUM = vec3(0.2126729, 0.7151522, 0.0721750);

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

/* ------------------------------- CONVERSIONS ------------------------------ */

float RGBToLuminance(vec3 color) {
  return dot(color, LUM);
}

vec3 RGBToCIEXYZ(vec3 color) {
  return RGB2CIEXYZ * color;
}
vec3 CIEXYZToRGB(vec3 color) {
  return CIEXYZ2RGB * color;
}

vec3 CIEXYZToCIExyY(vec3 color) {
  float s = sum(color);

  return vec3(
    s == 0.0 ? CIEXYZD65.x : color.x / s,
    s == 0.0 ? CIEXYZD65.y : color.y / s,
    color.y
  );
}
vec3 CIExyYToCIEXYZ(vec3 color) {
  return vec3(
    color.x * color.z / color.y,
    color.z,
    (1.0 - color.x - color.y) * color.z / color.y
  );
}

vec3 CIEXYZToCIELab(vec3 color) {
  float a = 4.0 / 29.0;  // Reused constant
  float d = 6.0 / 29.0;  // Delta
  float dt = cb(d);  // Delta treshold
  float df = pow(d, -2.0);  // Delta factor
  float y = 1.0 / 3.0;  // Reused constant
  
  float tx = color.x / CIEXYZD65.x;
  float ty = color.y / CIEXYZD65.y;
  float tz = color.z / CIEXYZD65.z;

  float fx = (tx > dt) ? pow(tx, y) : y * tx * df + a;
  float fy = (ty > dt) ? pow(ty, y) : y * ty * df + a;
  float fz = (tz > dt) ? pow(tz, y) : y * tz * df + a;

  return vec3(
    116.0 * fy - 16.0,
    500.0 * (fx - fy),
    200.0 * (fy - fz)
  );
}
vec3 CIELabToCIEXYZ(vec3 color) {
  float a = 4.0 / 29.0;  // Reused constant
  float dt = 6.0 / 29.0;  // Delta treshold
  float df = sq(dt);  // Delta factor

  float ty = (color.x + 16.0) / 116.0;
  float tx = ty + color.y / 500.0;
  float tz = ty - color.z / 200.0;

  float fx = (tx > dt) ? cb(tx) : 3.0 * df * (tx - a);
  float fy = (ty > dt) ? cb(ty) : 3.0 * df * (ty - a);
  float fz = (tz > dt) ? cb(tz) : 3.0 * df * (tz - a);

  return vec3(
    fx * CIEXYZD65.x,
    fy * CIEXYZD65.y,
    fz * CIEXYZD65.z
  );
}

vec3 RGBToCIExyY(vec3 color) {
  return CIEXYZToCIExyY(RGBToCIEXYZ(color));
}
vec3 CIExyYToRGB(vec3 color) {
  return CIEXYZToRGB(CIExyYToCIEXYZ(color));
}

vec3 RGBToCIELab(vec3 color) {
  return CIEXYZToCIELab(RGBToCIEXYZ(color));
}
vec3 CIELabToRGB(vec3 color) {
  return CIEXYZToRGB(CIELabToCIEXYZ(color));
}

#endif // INCLUDE_COLOR_COMMON