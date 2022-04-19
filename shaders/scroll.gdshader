shader_type canvas_item;

uniform vec2 dir = vec2(0.1);
uniform float alpha = 1.0;

void fragment() {
	  vec2 uv = mod(UV - dir * TIME, 1.0);
		vec4 tex = texture(TEXTURE, uv);
    COLOR = vec4(tex.rgb, tex.a * alpha);
}
