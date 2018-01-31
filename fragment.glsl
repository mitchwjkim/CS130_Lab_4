uniform sampler2D tex;
varying vec3 N;
varying vec4 position;

void main()
{
    vec3 diff = vec3(gl_LightSource[0].position - position);
    vec3 L = normalize(diff);
    vec3 normal = normalize(N);

    float intensity = max(dot(L, normal),0.0);
//    gl_FragColor.rgb = intensity * gl_FrontMaterial.diffuse.rgb * gl_LightSource[0].diffuse.rgb + gl_FrontMaterial.ambient.rgb * gl_LightSource[0].ambient.rgb;
    gl_FragColor.a = 1.0;

   vec4 tex_color;


	tex_color = texture2D(tex, gl_TexCoord[0].st);

	// Ambient + Diffuse
	gl_FragColor.rgb += intensity * tex_color * gl_LightSource[0].diffuse.rgb + gl_FrontMaterial.ambient.rgb * gl_LightSource[0].ambient.rgb;

	// Specular
	vec3 r, c;
	r = (2.0) * dot(L, N) *N - L;

	float prod_rc = dot(normalize(r), normalize(-position));

	gl_FragColor.rgb += pow(max(0.0, prod_rc), intensity) * gl_LightSource[0].specular.rgb * tex_color;

} // End of MAIN
