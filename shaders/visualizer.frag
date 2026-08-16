#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;
uniform vec4 uFrequencies; // (low, mid-low, mid-high, high)

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uResolution;
    vec2 p = uv * 2.0 - 1.0;
    p.x *= uResolution.x / uResolution.y;

    // Pick frequency amplitude based on X coordinate
    float band = 0.0;
    if (uv.x < 0.25) {
        band = uFrequencies.x;
    } else if (uv.x < 0.5) {
        band = uFrequencies.y;
    } else if (uv.x < 0.75) {
        band = uFrequencies.z;
    } else {
        band = uFrequencies.w;
    }

    // Dynamic wave formulation modulated by audio frequency
    float wave = sin(p.x * 6.0 + uTime * 3.0) * 0.25 * (0.3 + band * 0.7);
    wave += sin(p.x * 12.0 - uTime * 2.0) * 0.1 * band;

    // Line thickness and glow
    float dist = abs(p.y - wave);
    float glow = 0.02 / (dist + 0.01);

    // Color gradient based on frequency and position
    vec3 colA = vec3(0.1, 0.8, 0.9); // Cyan
    vec3 colB = vec3(0.9, 0.2, 0.6); // Magenta
    vec3 color = mix(colA, colB, uv.x) * glow * (1.0 + band * 1.5);

    // Vignette / background dark falloff
    color += vec3(0.02, 0.03, 0.08) * (1.0 - length(p) * 0.4);

    fragColor = vec4(color, 1.0);
}