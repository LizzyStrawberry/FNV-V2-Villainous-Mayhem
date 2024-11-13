#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main

//by Vladimir Storm 
//https://twitter.com/vladstorm_

#define t iTime

const float scanlines = 0.11;
const float fuzz = .0014;
const float fuzzDensity = 999.;
const float chromatic = .0002;
const float staticNoise = .119;
const float vignette = 1.49;
const float pi = 3.14159265359;

vec4 hash42(vec2 p){
    
    vec4 p4 = fract(vec4(p.xyxy) * vec4(443.8975,397.2973, 491.1871, 470.7827));
    p4 += dot(p4.wzxy, p4+19.19);
    return fract(vec4(p4.x * p4.y, p4.x*p4.z, p4.y*p4.w, p4.x*p4.w));
}


float hash( float n ){
    return fract(sin(n)*43758.5453123);
}

// 3d noise function (iq's)
float n( in vec3 x ){
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = f*f*(3.0-2.0*f);
    float n = p.x + p.y*57.0 + 113.0*p.z;
    float res = mix(mix(mix( hash(n+  0.0), hash(n+  1.0),f.x),
                        mix( hash(n+ 57.0), hash(n+ 58.0),f.x),f.y),
                    mix(mix( hash(n+113.0), hash(n+114.0),f.x),
                        mix( hash(n+170.0), hash(n+171.0),f.x),f.y),f.z);
    return res;
}

//tape noise
float nn(vec2 p){


    float y = p.y;
    float s = iTime*2.;
    
    float v = (n( vec3(y*.01 +s, 			1., 1.0) ) + .0)
            *(n( vec3(y*.011+1000.0+s, 	1., 1.0) ) + .0) 
            *(n( vec3(y*.51+421.0+s, 	1., 1.0) ) + .0)   
        ;
    //v*= n( vec3( (openfl_TextureCoordv.xy + vec2(s,0.))*100.,1.0) );
    v*= hash42(   vec2(p.x +iTime*0.01, p.y) ).x +.3 ;

    
    v = pow(v+.3, 1.);
    if(v<.8) v = 0.;  //threshold
    return v;
}

float hash2(vec2 p)
{
    p  = 50.0*fract( p*0.3183099 + vec2(0.71,0.113));
    return -1.0+2.0*fract( p.x*p.y*(p.x+p.y) );
}

float noise( in vec2 p )
{
    vec2 i = floor( p );
    vec2 f = fract( p );
    vec2 u = f*f*(3.0-2.0*f);
    return mix( mix( hash2( i + vec2(0.0,0.0) ), 
                    hash2( i + vec2(1.0,0.0) ), u.x),
                mix( hash2( i + vec2(0.0,1.0) ), 
                    hash2( i + vec2(1.0,1.0) ), u.x), u.y);
}

void main()
{
    vec2 uv = openfl_TextureCoordv;
    
    // noise
    vec4 c = vec4(0);
    c += staticNoise * ((sin(iTime)+2.)*.3)*sin(.8-uv.y+sin(iTime*3.)*.1) *
        noise(vec2(uv.y*999. + iTime*999., (uv.x+999.)/(uv.y+.1)*19.));
    
    // fuzz on edges
    uv.x += fuzz*noise(vec2(uv.y*fuzzDensity, iTime*9.));
    
    // chromatic aberration
    c += vec4
    (
        flixel_texture2D(bitmap, uv + vec2(-chromatic, 0)).r,
        flixel_texture2D(bitmap, uv + vec2( 0        , 0)).g,
        flixel_texture2D(bitmap, uv + vec2( chromatic, 0)).b,
        1.
    );
    
    // scanlines
    c *= 1. + scanlines*sin(uv.y*iResolution.y*pi/2.);

    // vignette
    float dx = vignette * abs(uv.x - .5);
    float dy = vignette * abs(uv.y - .5);
    c *= (1.0 - dx * dx - dy * dy);

    // vhs noise effect
    float linesN = 400.; //fields per seconds
    uv = floor(uv*linesN);

    float col =  nn(-uv);
    
    // vhs twitching
    vec2 pos=vec2(0.5+0.5*sin(iTime),uv.y);
    vec3 coltwitch=vec3(flixel_texture2D(bitmap,pos))*0.06;
    
    gl_FragColor = vec4(vec3( col ),1.0);
    
    gl_FragColor += c;
    
    gl_FragColor += vec4(coltwitch,1.0);
}