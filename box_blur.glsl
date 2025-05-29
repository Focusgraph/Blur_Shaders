#version 300 es

precision mediump float;

out vec4 fragColor;
uniform vec2 u_resolution;
uniform sampler2D u_texture_0;


void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;

    vec2 imageResolution = vec2(640, 640);
    vec2 texelSize = 1.0 / imageResolution; //Calculating the size of a single texel in UV coordinates

    vec3 boxBlurColor = vec3(0.0, 0.0, 0.0);

        //For a kernelSize of 1, the loop will iterate over a 3x3 area (i ==> -1, 0, 1 and j ==> -1, 0, 1)
        //For a kernelSize of 2, the loop will iterate over a 5x5 area (i ==> -2, -1, 0, 1, 2 and j ==> -2, -1, 0, 1, 2)
        const float kernelSize = 1.0; //Change this value to increase or decrease the blur effect
        for (float i = -kernelSize; i <= kernelSize; i++){
            for (float j = -kernelSize; j <= kernelSize; j++){
                vec4 texture = texture(u_texture_0, uv + vec2(i, j) * texelSize);
                boxBlurColor = boxBlurColor + texture.rgb;
            }
        }
        float boxBlurDivisor = pow(2.0 * kernelSize + 1.0, 2.0); //If kernelSize is 1, the divisor will be 9 (3x3 kernel)
        boxBlurColor = boxBlurColor / boxBlurDivisor;
        vec3 color = boxBlurColor;

    fragColor = vec4(color, 1.0);

}