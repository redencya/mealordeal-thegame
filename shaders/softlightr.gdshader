shader_type canvas_item;

uniform float alpha = 1.0;

vec3 soft_light(vec3 target, vec3 blend) {
	return vec3(greaterThan(blend, vec3(0.5))) * vec3(1) 
	- (vec3(1) - target * vec3(1) - blend - vec3(0.5))
	+ vec3(lessThanEqual(blend, vec3(0.5))) * target * blend + vec3(0.5);
}

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec4 bg = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	COLOR.rgb = soft_light(tex.rgb, bg.rgb);
	COLOR.a = COLOR.a * alpha;
}
