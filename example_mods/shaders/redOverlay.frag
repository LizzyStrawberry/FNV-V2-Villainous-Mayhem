//Grayscale shading, but turned red lmao

#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

void mainImage()
{
    vec2 uv = (fragCoord.xy / iResolution.xy);
    vec3 gammaColor = texture(iChannel0, uv).xyz;
    // ungamma (should be 2.2 but...)
    vec3 color = pow(gammaColor, vec3(2.0));
    // grayscale conversion
    float gray = dot(color, vec3(0.2126, 0.7152, 0.0722));
    // regamma
    float gammaGray = sqrt(gray);
    fragColor = vec4(1, gammaGray, gammaGray, 1.0);
}