#ifndef INCLUDE_MATH
#define INCLUDE_MATH

vec4 sq(vec4 v) { return v * v; }
vec3 sq(vec3 v) { return v * v; }
vec2 sq(vec2 v) { return v * v; }
float sq(float x) { return x * x; }
int sq(int x) { return x * x; }

float sum(vec4 v) { return v.x + v.y + v.z + v.w; }
float sum(vec3 v) { return v.x + v.y + v.z; }
float sum(vec2 v) { return v.x + v.y; }

#endif // INCLUDE_MATH