/* --------------------------------- COMPUTE -------------------------------- */

#ifdef STAGE_COMPUTE

#define clamp16F(x) clamp(x, 0.0, 65535.0)

// Groups of 4x4 pixels ?
// const vec2 workGroupsRender = vec2(0.25, 0.25);
const ivec3 workGroups = ivec3(32, 32, 1);

layout(local_size_x = 1, local_size_y = 1) in;

layout(rgba8) uniform image2D colorimg0;

uniform sampler2D colortex0;

void main() {
  ivec2 coord = ivec2(gl_GlobalInvocationID.xy);
  ivec2 size = ivec2(imageSize(colorimg0).xy / (gl_NumWorkGroups.xy - 1));

  vec3 value = texelFetch(colortex0, coord * size, 0).rgb;

  for (int x = 0; x < size.x; x++) {
    for (int y = 0; y < size.y; y++) {
      imageStore(colorimg0, coord * size + ivec2(x, y), vec4(value, 1.0));
    }
  }
  // imageStore(colorimg1, coord, vec4(value, 1.0));
}

#endif // STAGE_COMPUTE

/* --------------------------------- VERTEX --------------------------------- */

#ifdef STAGE_VERTEX

#include "/program/vertex/simple.glsl"

#endif // STAGE_VERTEX

/* -------------------------------- FRAGMENT -------------------------------- */

#ifdef STAGE_FRAGMENT

#include "/program/common.glsl"

layout(location = 0) out vec3 color;

in vec2 uv0;

uniform sampler2D colortex0;

void main() {
  color = texture(colortex0, uv0).rgb;
}

#endif // STAGE_FRAGMENT