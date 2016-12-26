#version 410 core

layout(location = 0) in vec3 aPosition;
layout(location = 1) in vec3 aColor;

out vec3 iColor;

void main() {
    iColor = aColor;
    gl_Position = vec4(aPosition, 1.0);
}
