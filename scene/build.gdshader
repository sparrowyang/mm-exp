shader_type canvas_item;

uniform vec4 focus_color: source_color = vec4(1.0);
uniform float deep: hint_range(0.0, 1.0,0.01) = 0;

void fragment() {
	// Place fragment code here.
	vec4 color = texture(TEXTURE,UV);
	color.rgb = mix(color.rgb,focus_color.rgb,deep);
	COLOR = color;
	
}
