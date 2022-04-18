shader_type canvas_item;

uniform float alpha = 1.0;

void fragment() {
	COLOR.a = texture(TEXTURE, UV).a * 0.2;
}
