shader_type spatial;

render_mode blend_mix, unshaded;

uniform sampler2D model_texture : source_color, filter_nearest;
uniform float glow_speed = 0.1;
uniform float glow_size = 0.1;
uniform float multiply_factor = 0.5;
uniform float pixel_size = 1;
uniform float opacity = 0.5;

vec3 hsv_to_rgb(vec3 hsv) {
    vec3 rgb = clamp(
        abs(mod(hsv.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0,
        0.0,
        1.0
    );
	
    return hsv.z * mix(vec3(1.0), rgb, hsv.y);
}

float color_func(float x, float y, float t) {
	return t + (x + y) * glow_size;
}

void fragment() {
	float t = (sin(TIME * glow_speed) + 1.0) / 2.0;
	vec2 xy = vec2(floor(VERTEX.x / pixel_size), floor(VERTEX.y / pixel_size)) * pixel_size;
	vec3 hsv = vec3(color_func(xy.x, xy.y, t), multiply_factor, 1.0);
    ALBEDO = texture(model_texture, UV).rgb * hsv_to_rgb(hsv);
	ALPHA = opacity;
}
