#ifndef INCLUDE_ALIAS
#define INCLUDE_ALIAS

// #define DECLARE_WG_BY_PX_1DX(count) const vec2 workGroupsRender = vec2(1.0 / float(count), 1.0)
// #define DECLARE_WG_BY_PX_1DY(count) const vec2 workGroupsRender = vec2(1.0, 1.0 / float(count))
// #define DECLARE_WG_BY_PX_2D(count) const vec2 workGroupsRender = vec2(1.0 / float(count * count), 1.0 / float(count * count))

// #define DECLARE_LG_BY_PX_1DX(count) layout(local_size_x = count, local_size_y = 1, local_size_z = 1) in;
// #define DECLARE_LG_BY_PX_1DY(count) layout(local_size_x = 1, local_size_y = count, local_size_z = 1) in;
// #define DECLARE_LG_BY_PX_1DZ(count) layout(local_size_x = 1, local_size_y = 1, local_size_z = count) in;
// #define DECLARE_LG_BY_PX_2D(count) layout(local_size_x = sqrt(count), local_size_y = sqrt(count)) in;

#define BUFFER_HISTOGRAM() layout(std430, binding = 0) buffer _histogram { uint bins[256]; uint count; };

#endif // INCLUDE_ALIAS