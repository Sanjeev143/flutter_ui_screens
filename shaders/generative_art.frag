#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;

out vec4 fragColor;

// Palettes generator function
vec3 palette( in float t ) {
    vec3 a = vec3(0.05, 0.08, 0.20); // Deep Navy Base
    vec3 b = vec3(0.20, 0.40, 0.80); // Electric Blue Accent
    vec3 c = vec3(1.00, 1.00, 1.00);
    vec3 d = vec3(0.263, 0.416, 0.557); // Violet/Teal shifts

    return a + b * cos( 6.28318 * (c * t + d) );
}

void main() {
    // Normalize canvas space so origin (0,0) is in the center
    vec2 uv = (gl_FragCoord.xy * 2.0 - uResolution.xy) / min(uResolution.x, uResolution.y);
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);

    for (float i = 0.0; i < 3.0; i++) {
        // Organic distortion grid shift
        uv = fract(uv * 1.5) - 0.5;

        float d = length(uv) * exp(-length(uv0));

        vec3 col = palette(length(uv0) + i * 0.4 + uTime * 0.2);

        // Sinusoidal wave rings
        d = sin(d * 8.0 + uTime) / 8.0;
        d = abs(d);

        // Glowing light intensity algorithm
        d = pow(0.01 / d, 1.2);

        finalColor += col * d;
    }

    // Output glowing color with solid alpha
    fragColor = vec4(finalColor, 1.0);
}