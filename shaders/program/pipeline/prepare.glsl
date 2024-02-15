/* --------------------------------- COMPUTE -------------------------------- */

#ifdef CSH

const ivec3 workGroups = ivec3(1, 1, 1);
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

layout(std430, binding = 0) buffer histogram { uint bins[256]; uint count; };

void main() {
  count = 0;
  for (int i = 0; i < 256; i++) {
    bins[i] = 0;
  }
}

#endif // CSH