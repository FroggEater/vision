/* --------------------------------- COMPUTE -------------------------------- */

#ifdef CSH

#include "/lib/alias.glsl"

const ivec3 workGroups = ivec3(1, 1, 1);
layout(local_size_x = 1, local_size_y = 1, local_size_z = 1) in;

BUFFER_HISTOGRAM()

void main() {
  count = 0;
  for (int i = 0; i < 256; i++) {
    bins[i] = 0;
  }
}

#endif // CSH