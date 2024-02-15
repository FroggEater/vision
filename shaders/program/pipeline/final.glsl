/* --------------------------------- COMPUTE -------------------------------- */

#ifdef CSH

#include "/lib/alias.glsl"
#include "/lib/math.glsl"
#include "/lib/color/common.glsl"

// Scaling for 256 executions (16x16 pixels workgroups, 16x16 local size)
const vec2 workGroupsRender = vec2(0.0625, 0.0625);
layout(local_size_x = 16, local_size_y = 16) in;

BUFFER_HISTOGRAM()

uniform sampler2D colortex0;

void main() {
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  uint index = gl_LocalInvocationIndex;
  // Setting the total number of invocations (might be useful later)
  // This only needs to be done once
  if (coord.x == 0 && coord.y == 0)
    atomicExchange(count, uint(prod(gl_NumWorkGroups.xy * gl_WorkGroupSize.xy)));

  vec4 color = texelFetch(colortex0, coord, 0);
  float luminance = RGBToLuminance(color.rgb);
  // luminance = clamp((log2(luminance) - 0.25) / 2.0, 0.0, 1.0);
  uint bin = uint(luminance * 254.0 + 1.0);

  atomicAdd(bins[bin], 1);
}

#endif // CSH

/* --------------------------------- VERTEX --------------------------------- */

#ifdef VSH

#include "/program/vertex/simple.glsl"

#endif // VSH

/* -------------------------------- FRAGMENT -------------------------------- */

#ifdef FSH

#include "/program/common.glsl"

layout(std430, binding = 0) buffer histogram { uint bins[256]; uint count; };
layout(location = 0) out vec3 color;

in vec2 uv0;

uniform sampler2D colortex0;

void main() {
  float averageLuminance = 0.0;
  for (int i = 0; i < 256; i++) {
    float luminance = float(i) / 255.0;
    averageLuminance += luminance * float(bins[i]);
  }
  averageLuminance /= float(count);
  color = texture(colortex0, uv0).rgb;
  // color = vec3(averageLuminance);
}

#endif // FSH