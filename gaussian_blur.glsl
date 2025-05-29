#version 300 es
precision mediump float;

out vec4 fragColor;
uniform vec2 u_resolution;
uniform sampler2D u_texture_0; //Texture binded through settings.json

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;


    vec2 blurResolution = vec2(640, 640);
    //Calculating the size of a single texel in UV coordinates
    vec2 texelSize = 1.0 / blurResolution; 

    vec3 gaussianBlurColor = vec3(0.0, 0.0, 0.0);

    //Gaussian kernel weights
    mat3 kernel = mat3(
        1, 2, 1,
        2, 4, 2,
        1, 2, 1
    );

    float kernelSum = 16.0;
    int samplingArea = 1;
    for (int i = -samplingArea; i <= samplingArea; i++) {
        for (int j = -samplingArea; j <= samplingArea; j++) {
            float weight = kernel[i + samplingArea][j + samplingArea];
            gaussianBlurColor += texture(u_texture_0, uv + vec2(float(i), float(j)) * texelSize).rgb * weight;
        }
    }

    gaussianBlurColor = gaussianBlurColor / kernelSum;
    vec3 color = gaussianBlurColor;

    fragColor = vec4(color, 1.0);
}