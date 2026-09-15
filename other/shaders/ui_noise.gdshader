shader_type canvas_item;

#include "random_utils.gdshaderinc"

uniform float scale = 1;
uniform float opacity = 0.5;
uniform vec4 base_color : source_color;

void fragment() {
	vec2 xy = UV + vec2(sin(TIME), sin(TIME + 20.0));
	//COLOR = base_color * perlin_noise(vec2(mod(xy.x, scale), mod(xy.y, scale)) / (2.0 + sin(TIME)));
	COLOR = base_color * perlin_noise(xy / scale / (2.0 + sin(TIME)));
	COLOR.a = opacity * 0.5;
}
