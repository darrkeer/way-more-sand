shader_type spatial;

render_mode blend_mix;

#include "random_utils.gdshaderinc"

uniform vec4 col_a : source_color;
uniform vec4 col_b : source_color;
uniform vec4 col_extra : source_color;
uniform float speed = 1;
uniform float scale = 1;
uniform float pixel_factor = 2;

varying vec3 world_pos;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

float ease_curve(float x) {
	return pow(x, 4);
}

void fragment() {
	vec2 xy = world_pos.xz + vec2(TIME, TIME) * speed;;
	xy = vec2(floor(xy.x / pixel_factor), floor(xy.y / pixel_factor));
	xy *= pixel_factor;
	float noise = voronoi2d(xy / scale);
	
	if (noise < -0.2) {
		ALBEDO = col_extra.rgb;
	} else {
		ALBEDO = mix(col_a.rgb, col_b.rgb, ease_curve(noise)).rgb;
	}
	ALPHA = 0.7;
}
