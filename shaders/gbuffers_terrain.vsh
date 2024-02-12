#version 130

out vec4 color;
out vec3 normal;
out vec2 light;
out vec2 uv;

void main() {
  gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;

  color = gl_Color;
  normal = gl_NormalMatrix * gl_Normal * 0.5 + 0.5;
  uv = gl_MultiTexCoord0.xy;

  light = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.xy;
  light = (light * 33.05 / 32.0) - (1.05 / 32.0); // scale to 0-1
}