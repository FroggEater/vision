/* --------------------------------- VERTEX --------------------------------- */

#ifdef VSH

#include "/program/vertex/simple.glsl"

#endif // VSH

/* -------------------------------- FRAGMENT -------------------------------- */

#ifdef FSH

layout(location = 0) out vec3 color;

in vec2 uv0;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D shadowtex0;

void main() {
  color = texture(colortex0, uv0).rgb;
}

#endif // FSH