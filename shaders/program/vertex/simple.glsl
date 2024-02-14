in vec3 vaPosition;
in vec2 vaUV0;

out vec2 uv0;

void main() {
  gl_Position = vec4(vaPosition * 2.0 - 1.0, 1.0);

  uv0 = vaUV0;
}