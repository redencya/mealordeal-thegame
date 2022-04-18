shader_type canvas_item;

vec3 col_dodge(vec3 a, vec3 b) {
	return a / (vec3(1) - b);
}

float col_dodge_alpha(float a, float b) {
	return a / (1.0 - b);
}

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec4 bg = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	COLOR.rgb = col_dodge(bg.rgb, tex.rgb);
}
