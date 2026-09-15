shader_type canvas_item;

uniform float jiggle_factor = 1;

float hash(float n) {
    return fract(sin(n) * 43758.5453123);
}

void vertex() {
	float delta = sin(VERTEX.x + TIME);
	VERTEX.x += delta * jiggle_factor;
	VERTEX.y += delta * jiggle_factor;
}
