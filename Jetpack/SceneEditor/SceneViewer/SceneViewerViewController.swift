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

var program: GLuint = 0

class SceneViewerViewController: NSViewController {
    @IBOutlet weak var openGlView: JetpackCocoaOpenGlView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dump(openGlView.openGLContext)
    }
}

class JetpackCocoaOpenGlView: NSOpenGLView {
    var renderer: Renderer?
//    var vertexArray = GLuint()
//    var gCubeVertexData: [GLfloat] = [0, 0, 0,
//                                      0, 1, 0,
//                                      1, 1, 0]
    
    override func prepareOpenGL() {
        super.prepareOpenGL()
        let gpuApi = OpenGlGpuApi()
        
        let v1 = Vertex(data: [.Position: [0, 0, 0]])!
        let v2 = Vertex(data: [.Position: [0, 1, 0]])!
        let v3 = Vertex(data: [.Position: [1, 1, 0]])!
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


        
//        loadShaders()
//        
//        glGenVertexArrays(1, &vertexArray)
//        glBindVertexArray(vertexArray)
//        
//        var vertexBuffer = GLuint()
//        glGenBuffers(1, &vertexBuffer)
//        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
//        glBufferData(GLenum(GL_ARRAY_BUFFER), GLsizeiptr(MemoryLayout<GLfloat>.size * gCubeVertexData.count), &gCubeVertexData, GLenum(GL_STATIC_DRAW))
//        
//        glEnableVertexAttribArray(GLuint(0))
//        glVertexAttribPointer(GLuint(0), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 12, nil)
//        
//        glBindVertexArray(0)
        
    }
    
    override func draw(_ dirtyRect: NSRect) {
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
        glClearColor(0, 1, 0, 1)
        
        renderer!.render()
//        Renderer().render(renderingEntity: renderingEntity)
        
//        glBindVertexArray(vertexArray)
//        glUseProgram(program)
//        
//        glDrawArrays(GLenum(GL_TRIANGLES), 0, GLsizei(3))
//        
        glFlush()
        openGLContext?.flushBuffer()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let attrs: [NSOpenGLPixelFormatAttribute] = [UInt32(NSOpenGLProfileVersion4_1Core)]
        let attrs: [NSOpenGLPixelFormatAttribute] = [
                UInt32(NSOpenGLPFADoubleBuffer),
                UInt32(NSOpenGLPFADepthSize), 24,
//                // Must specify the 3.2 Core Profile to use OpenGL 3.2
                UInt32(NSOpenGLPFAOpenGLProfile),
                UInt32(NSOpenGLProfileVersion4_1Core),
                0
        ]
        
        let pf: NSOpenGLPixelFormat = NSOpenGLPixelFormat(attributes: attrs)!
        
//        if (!pf)
//        {
//            NSLog(@"No OpenGL pixel format");
//        }
//        
//        NSOpenGLContext* context = [[[NSOpenGLContext alloc] initWithFormat:pf shareContext:nil] autorelease];
        let context = NSOpenGLContext(format: pf, share: nil)
        
        pixelFormat = pf
        openGLContext = context
//        [self setPixelFormat:pf];
        
//        [self setOpenGLContext:context];
    }
}


func loadShaders() -> Bool {
    var vertShader: GLuint = 0
    var fragShader: GLuint = 0
    var vertShaderPathname: String
    var fragShaderPathname: String
    
    // Create shader program.
    program = glCreateProgram()
    // Create and compile vertex shader.
    vertShaderPathname = Bundle.main.path(forResource: "Shader", ofType: "vsh")!
    if compileShader(&vertShader, type: GLenum(GL_VERTEX_SHADER), file: vertShaderPathname) == false {
        print("Failed to compile vertex shader")
        return false
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = Bundle.main.path(forResource: "Shader", ofType: "fsh")!
    if !compileShader(&fragShader, type: GLenum(GL_FRAGMENT_SHADER), file: fragShaderPathname) {
        print("Failed to compile fragment shader")
        return false
    }
    
    // Attach vertex shader to program.
    glAttachShader(program, vertShader)
    
    // Attach fragment shader to program.
    glAttachShader(program, fragShader)
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
//    glBindAttribLocation(program, GLuint(0), "aPosition")
//    glBindAttribLocation(program, GLuint(1), "aNormal")
    
    // Link program.
    if !linkProgram(program) {
        print("Failed to link program: \(program)")
        
        if vertShader != 0 {
            glDeleteShader(vertShader)
            vertShader = 0
        }
        if fragShader != 0 {
            glDeleteShader(fragShader)
            fragShader = 0
        }
        if program != 0 {
            glDeleteProgram(program)
            program = 0
        }
        
        return false
    }
    
    // Get uniform locations.
    let UNIFORM_MODELVIEWPROJECTION_MATRIX = glGetUniformLocation(program, "modelViewProjectionMatrix")
    let UNIFORM_NORMAL_MATRIX = glGetUniformLocation(program, "normalMatrix")
    
    // Release vertex and fragment shaders.
    if vertShader != 0 {
        glDetachShader(program, vertShader)
        glDeleteShader(vertShader)
    }
    if fragShader != 0 {
        glDetachShader(program, fragShader)
        glDeleteShader(fragShader)
    }
    
    return true
}


func compileShader(_ shader: inout GLuint, type: GLenum, file: String) -> Bool {
    var status: GLint = 0
    var source: UnsafePointer<Int8>
    do {
        source = try NSString(contentsOfFile: file, encoding: String.Encoding.utf8.rawValue).utf8String!
    } catch {
        print("Failed to load vertex shader")
        return false
    }
    var castSource: UnsafePointer<GLchar>? = UnsafePointer<GLchar>(source)
    
    shader = glCreateShader(type)
    glShaderSource(shader, 1, &castSource, nil)
    glCompileShader(shader)
    
    //#if defined(DEBUG)
            var logLength: GLint = 0
            glGetShaderiv(shader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
            if logLength > 0 {
                let log: UnsafeMutablePointer<GLchar> = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(logLength))
                glGetShaderInfoLog(shader, logLength, &logLength, log)
                NSLog("Shader compile log: \n%s", log)
                free(log)
            }
    //#endif
    
    glGetShaderiv(shader, GLenum(GL_COMPILE_STATUS), &status)
    if status == 0 {
        glDeleteShader(shader)
        return false
    }
    return true
}

func linkProgram(_ prog: GLuint) -> Bool {
    var status: GLint = 0
    glLinkProgram(prog)
    
    //#if defined(DEBUG)
    //        var logLength: GLint = 0
    //        glGetShaderiv(shader, GLenum(GL_INFO_LOG_LENGTH), &logLength)
    //        if logLength > 0 {
    //            var log = UnsafeMutablePointer<GLchar>(malloc(Int(logLength)))
    //            glGetShaderInfoLog(shader, logLength, &logLength, log)
    //            NSLog("Shader compile log: \n%s", log)
    //            free(log)
    //        }
    //#endif
    
    glGetProgramiv(prog, GLenum(GL_LINK_STATUS), &status)
    if status == 0 {
        return false
    }
    
    return true
}

func validateProgram(prog: GLuint) -> Bool {
    var logLength: GLsizei = 0
    var status: GLint = 0
    
    glValidateProgram(prog)
    glGetProgramiv(prog, GLenum(GL_INFO_LOG_LENGTH), &logLength)
    if logLength > 0 {
        var log: [GLchar] = [GLchar](repeating: 0, count: Int(logLength))
        glGetProgramInfoLog(prog, logLength, &logLength, &log)
        print("Program validate log: \n\(log)")
    }
    
    glGetProgramiv(prog, GLenum(GL_VALIDATE_STATUS), &status)
    var returnVal = true
    if status == 0 {
        returnVal = false
    }
    return returnVal
}
