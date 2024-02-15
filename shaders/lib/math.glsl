#ifndef INCLUDE_MATH
#define INCLUDE_MATH

float prod(vec4 v) { return v.x * v.y * v.z * v.w; }
float prod(vec3 v) { return v.x * v.y * v.z; }
float prod(vec2 v) { return v.x * v.y; }

float sum(vec4 v) { return v.x + v.y + v.z + v.w; }
float sum(vec3 v) { return v.x + v.y + v.z; }
float sum(vec2 v) { return v.x + v.y; }

vec4 pow2(vec4 v) { return v * v; }
vec3 pow2(vec3 v) { return v * v; }
vec2 pow2(vec2 v) { return v * v; }
float pow2(float f) { return f * f; }
int pow2(int i) { return i * i; }

vec4 pow3(vec4 v) { return v * v * v; }
vec3 pow3(vec3 v) { return v * v * v; }
vec2 pow3(vec2 v) { return v * v * v; }
float pow3(float f) { return f * f * f; }
int pow3(int i) { return i * i * i; }

#endif // INCLUDE_MATH