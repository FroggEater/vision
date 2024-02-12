#version 130

in vec4 color;
in vec3 normal;
in vec2 light;
in vec2 uv;

uniform sampler2D tex;

void main() {
  vec4 albedo = texture(tex, uv) * color;

  /* DRAWBUFFERS:012 */
  gl_FragData[0] = albedo;
  gl_FragData[1] = vec4(normal, 1.0);
  gl_FragData[2] = vec4(light, 0.0, 1.0);
}