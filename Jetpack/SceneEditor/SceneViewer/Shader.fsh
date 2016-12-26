#version 410 core

out vec4 colorOut;

in vec3 iColor;

void main() {
    colorOut = vec4(iColor , 1.0);
}
