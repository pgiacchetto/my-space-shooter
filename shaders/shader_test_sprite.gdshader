shader_type canvas_item;

uniform bool active = false;

void vertex()
{
	// Called for every vertex the material is visible on.
}

void fragment()
{
	// Called for every pixel the material is visible on.
	if (active)
	{
		COLOR.r = 242.0/255.0;
		COLOR.g = 255.0/255.0;
		COLOR.b = 178.0/255.0;
	}
}
