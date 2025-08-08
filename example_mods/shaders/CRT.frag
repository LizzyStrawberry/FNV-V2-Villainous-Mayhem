#pragma header

uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragCoord (openfl_TextureCoordv * openfl_TextureSize)
#define iResolution openfl_TextureSize

float warp = 0.75; // simulate curvature of CRT monitor
float scan = 0.75; // simulate darkness between scanlines

void main()
{
    // Normalized UV
    vec2 uv = fragCoord / iResolution;

    // Squared distance from center
    vec2 dc = abs(0.5 - uv);
    dc *= dc;

    // Warp the fragment coordinates
    uv.x -= 0.5;
    uv.x *= 1.0 + (dc.y * (0.3 * warp));
    uv.x += 0.5;

    uv.y -= 0.5;
    uv.y *= 1.0 + (dc.x * (0.4 * warp));
    uv.y += 0.5;

    // Sample inside boundaries, otherwise set to black
    if (uv.y > 1.0 || uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0) {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        float alpha = texture(iChannel0, uv).a;

        // Determine if we are drawing in a scanline
        float apply = abs(sin(fragCoord.y) * 0.5 * scan);

        // Sample the texture and darken for scanline
        gl_FragColor = vec4(
            mix(texture(iChannel0, uv).rgb, vec3(0.0), apply),
            alpha
        );
    }
}
