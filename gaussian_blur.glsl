#version 300 es
precision mediump float;

out vec4 fragColor;
uniform vec2 u_resolution;
uniform sampler2D u_texture_0; //Texture binded through settings.json

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;

    //vec4 texture = texture2D(u_texture_0, uv); //Reading and storing the texture in a variable
    //vec3 color = texture.rgb; //Vec4 to Vec3 conversion

    //Original image resolution: 2560 x 2560
    vec2 imageResolution = vec2(640, 640);
    vec2 texelSize = 1.0 / imageResolution; //Calculating the size of a single texel in UV coordinates

    

    //Gaussian kernel weights
    vec3 gaussianBlurColor = vec3(0.0, 0.0, 0.0);

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