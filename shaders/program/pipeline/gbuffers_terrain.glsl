/* --------------------------------- VERTEX --------------------------------- */

#ifdef VSH

in vec4 vaColor;
in vec3 vaPosition;
in vec2 vaUV0;

out vec4 tint;
out vec2 uv0;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 textureMatrix;
uniform vec3 chunkOffset;

void main() {
  gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition + chunkOffset, 1.0);

  tint = vaColor;
  uv0 = vaUV0;
}

#endif // VSH

/* -------------------------------- FRAGMENT -------------------------------- */

#ifdef FSH

#include "/lib/common.glsl"

in vec4 tint;
in vec2 uv0;

layout(location = 0) out vec4 albedo;

uniform sampler2D tex;

void main() {
  vec4 color = texture(tex, uv0);
  if (color.a < alphaTreshold) discard;

  albedo = color * tint;
}

#endif // FSH