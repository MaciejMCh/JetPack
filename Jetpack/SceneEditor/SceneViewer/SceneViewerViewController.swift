//
//  SceneViewerViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 14.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Cocoa
import OpenGL
import GLKit
import OpenGlGpuApi

import Renderer

class SceneViewerViewController: NSViewController {
    @IBOutlet weak var openGlView: JetpackCocoaOpenGlView!
}

class JetpackCocoaOpenGlView: NSOpenGLView {
    var renderer: Renderer?
    var vertexArray = GLuint()
    var gCubeVertexData: [GLfloat] = [0, 0, 0,
                                      0, 1, 0,
                                      1, 1, 0]
    var indices: [GLuint] = [0, 1, 2]
    
    override func prepareOpenGL() {
        super.prepareOpenGL()
        let gpuApi = OpenGlGpuApi()
        
        let v1 = Vertex(data: [.Position: [0, 0, 0], .Texel: [0, 0]])!
        let v2 = Vertex(data: [.Position: [0, 1, 0], .Texel: [0.5, 0.5]])!
        let v3 = Vertex(data: [.Position: [1, 1, 0], .Texel: [1, 1]])!
        let mesh = Mesh(vertices: [v1, v2, v3], indices: [0, 1, 2])!
        let vao = gpuApi.allocateVaoFromMesh(mesh: mesh)!
        let vaoAllocation = gpuApi.wholeVaoAllocation(vao: vao)
        let enviroment = Enviroment(processingUnions: [])
        let renderingEntity = RenderingEntity(vaoAllocation: vaoAllocation, enviroment: enviroment)
        let attributeInterface = AttributeInterface(attributes: [.Position])
        let uniformInterface = UniformInterface(uniformFaces: [])
        let shaderCode = ResourceShaderCode(resourceName: "Shader")
        let renderFunction = RenderFunction(attributeInterface: attributeInterface, uniformInterface: uniformInterface, shaderCode: shaderCode)
        let program = gpuApi.compileProgramFromRenderFunction(renderFunction: renderFunction)!
        renderer = Renderer(program: program, renderingEntity: renderingEntity)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
        glClearColor(0, 1, 0, 1)
        
        renderer!.render()

        glFlush()
        openGLContext?.flushBuffer()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let attributes: [NSOpenGLPixelFormatAttribute] = [
                UInt32(NSOpenGLPFADoubleBuffer),
                UInt32(NSOpenGLPFADepthSize), 24,
                UInt32(NSOpenGLPFAOpenGLProfile),
                UInt32(NSOpenGLProfileVersion4_1Core),
                0
        ]
        
        let pixelFormat: NSOpenGLPixelFormat = NSOpenGLPixelFormat(attributes: attributes)!
        let context = NSOpenGLContext(format: pixelFormat, share: nil)
        self.pixelFormat = pixelFormat
        openGLContext = context
    }
}
