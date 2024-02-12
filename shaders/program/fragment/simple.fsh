in vec2 uv;

uniform sampler2D colortex0;

void main() {
  vec3 color = texture(colortex0, uv).rgb;

  gl_FragData[0] = vec4(color, 1.0);
}