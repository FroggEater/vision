#version 130

#include "/lib/math.glsl"
#include "/lib/color/common.glsl"

in vec2 uv;

uniform sampler2D colortex0; // albedo
uniform sampler2D colortex1; // normal
uniform sampler2D colortex2; // light
uniform sampler2D depthtex0;
uniform vec3 skyColor;
uniform vec3 sunPosition;

/*
const int colortex0Format = RGBF16;
const int colortex1Format = RGB16;
const int colortex2Format = RG16;
*/

const float ambientStrength = 10000.0; // Diffuse skylight, in lux
const float shadowStrength = 50.0; // Shadowed skylight, in lux
const float sunStrength = 97500.0; // Direct sunlight, in lux
const float torchStrength = 250.0; // Torch light, in lux

float computeLambertDiffuse(vec3 normal, vec3 light) {
  float ndl = dot(normal, light);

  return max(0.0, ndl);
}

float computeOrenNayarDiffuse(vec3 normal, vec3 light, float albedo, float roughness) {
  vec3 view = vec3(0.0, 0.0, -1.0);
  float sigma = sq(roughness);

  float A = 1.0 + sigma * (albedo / (sigma + 0.13) + 0.5 / (sigma + 0.33));
  float B = 0.45 * sigma / (sigma + 0.09);

  float ldv = dot(light, view);
  float ndl = dot(normal, light);
  float ndv = dot(normal, view);

  float s = ldv - ndl * ndv;
  float t = max(1.0, max(ndl, ndv));

  return max(0.0, ndl) * (A + B * s / t) / 3.1415;
}

void main() {
  vec3 albedo = texture(colortex0, uv).rgb;
  vec3 normal = texture(colortex1, uv).xyz;
  // vec3 view = texture(colortex2, uv).xyz;
  float depth = texture(depthtex0, uv).r;

  normal = normalize(normal * 2.0 - 1.0);

  if (depth == 1.0) {
    gl_FragData[0] = vec4(albedo, 1.0);
    return;
  }

  vec3 color = albedo;
  color = gammaToLinear(color);

  vec3 torchColor = gammaToLinear(vec3(1.0, 0.25, 0.08)) * torchStrength;
  vec3 ambientColor = gammaToLinear(skyColor) * ambientStrength;
  vec3 sunDir = normalize(sunPosition);

  vec2 light = texture(colortex2, uv).xy;
  torchColor = light.x * torchColor;
  ambientColor = light.y * ambientColor;

  // float sunColor = computeLambertDiffuse(normal, sunDir);
  float sunColor = computeOrenNayarDiffuse(normal, sunDir, 0.5, 0.75) * sunStrength;

  color = color * (shadowStrength + ambientColor + sunColor * light.y + torchColor);

  // color = vec3(1.0) - exp(-color * 0.0001); // Incorrect Reinhard tonemapping
  color = RGBToCIExyY(color);
  color.z = 1.0 - exp(-color.z * 0.0001); // Incorrect Reinhard tonemapping
  color = CIExyYToRGB(color);

  color = linearToGamma(color);
  gl_FragData[0] = vec4(vec3(color), 1.0);
}