# CHEATSHEET

## COMPATIBILITY

* MacOS only supports up to eight color buffers (`colortex0` to `colortex7`)

## MATRICES

### OpenGL

| Matrix | Origin space | Destination space | Notes |
| --- | --- | --- | --- |
| `gl_ModelViewMatrix` | Model | View | |
| `gl_ProjectionMatrix` | View | Clip | |
| `gl_ModelViewProjectionMatrix` | Model | Clip | |

### Iris built-in

| Matrix | Origin space | Destination space | Notes |
| --- | --- | --- | --- |
| `gbufferModelView` | Player | View | |
| `gbufferModelViewInverse` | View | Player | |
| `gbufferProjection` | View | Clip | Different in `gbuffers_hand` & `gbuffers_hand_water` |
| `gbufferProjectionInverse` | Clip | View | Different in `gbuffers_hand` & `gbuffers_hand_water` |

### Other considerations

* `ftransform()` &rarr; Equivalent to `gl_ModelViewProjectionMatrix * gl_Vertex`

## BUFFERS

| Name | Renders | Fallback |
| --- | --- | --- |
| `gbuffers_basic` | leash, block selection box | N/A |
| `gbuffers_line` | block outline, fishing line | `gbuffers_basic` |
| `gbuffers_textured` | particles | `gbuffers_basic` |
| `gbuffers_textured_lit` | lit particles, world border | `gbuffers_textured` |
| `gbuffers_skybasic` | sky, horizon, stars, void | `gbuffers_basic` |
| `gbuffers_skytextured` | sun, moon | `gbuffers_textured` |
| `gbuffers_clouds` | clouds | `gbuffers_textured` |
| `gbuffers_terrain` | solid, cutout, cutout mips | `gbuffers_textured_lit` |
| `gbuffers_damagedblock` | damaged blocks | `gbuffers_terrain` |
| `gbuffers_block` | block entities | `gbuffers_terrain` |
| `gbuffers_beaconbeam` | beacon beam | `gbuffers_textured` |
| `gbuffers_entities` | entities | `gbuffers_textured_lit` |
| `gbuffers_entities_glowing` | glowing entities, spectral effect | `gbuffers_entities` |
| `gbuffers_armor_glint` | armor glint, handheld item glint | `gbuffers_textured` |
| `gbuffers_spidereyes` | spider eyes, enderman eyes, dragon eyes | `gbuffers_textured` |
| `gbuffers_hand` | hand, opaque handheld items | `gbuffers_textured_lit` |
| `gbuffers_weather` | rain, snow | `gbuffers_textured_lit` |
| `gbuffers_water` | translucent | `gbuffers_terrain` |
| `gbuffers_hand_water` | translucent handheld items | `gbuffers_hand` |