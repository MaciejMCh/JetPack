//
//  OpenGlProgram.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 24.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Renderer

extension OpenGlGpuApi {
    public func compileProgramFromRenderFunction(renderFunction: RenderFunction) -> Program? {
        var uniforms: Set<Uniform> = []
        let uniformLocator = { (compilingProgramGlName: GLuint) -> () in
            for uniformFace in renderFunction.uniformInterface.uniformFaces {
                let location = glGetUniformLocation(compilingProgramGlName, uniformFace.name)
                let uniform = Uniform(face: uniformFace, location: OpenGlUniformLocation(openGlName: location))
                uniforms.insert(uniform)
            }
        }
        
        guard let programGlName = OpenGlProgramCompiler().compileProgram(vsCode: renderFunction.shaderCode.vertexShaderCode, fsCode: renderFunction.shaderCode.fragmentShaderCode, uniformLocator: uniformLocator) else {
            return nil
        }
        
        let useFunction = {
            glUseProgram(programGlName)
        }
        
        return Program(gpuIdentity: OpenGlGpuIdentity(openGlName: programGlName), attributeInterface: renderFunction.attributeInterface, uniforms: uniforms, useFunction: useFunction)
    }
}

struct OpenGlProgramCompiler {
    
    func compileProgram(vsCode: String, fsCode: String, uniformLocator: (GLuint) -> ()) -> GLuint? {
        var vertShader: GLuint = 0
        var fragShader: GLuint = 0
        
        // Create shader program.
        var programGlName = glCreateProgram()
        // Create and compile vertex shader.
        if compileShader(&vertShader, type: GLenum(GL_VERTEX_SHADER), code: vsCode) == false {
            print("Failed to compile vertex shader")
            return nil
        }
        
        // Create and compile fragment shader.
        if !compileShader(&fragShader, type: GLenum(GL_FRAGMENT_SHADER), code: fsCode) {
            print("Failed to compile fragment shader")
            return nil
        }
        
        // Attach vertex shader to program.
        glAttachShader(programGlName, vertShader)
        
        // Attach fragment shader to program.
        glAttachShader(programGlName, fragShader)
        
        // Bind attribute locations.
        // This needs to be done prior to linking.
        //    glBindAttribLocation(program, GLuint(0), "aPosition")
        //    glBindAttribLocation(program, GLuint(1), "aNormal")
        
        // Link program.
        if !linkProgram(programGlName) {
            print("Failed to link program: \(programGlName)")
            
            if vertShader != 0 {
                glDeleteShader(vertShader)
                vertShader = 0
            }
            if fragShader != 0 {
                glDeleteShader(fragShader)
                fragShader = 0
            }
            if programGlName != 0 {
                glDeleteProgram(programGlName)
                programGlName = 0
            }
            
            return nil
        }
        
        // Get uniform locations.
        uniformLocator(programGlName)
        
        // Release vertex and fragment shaders.
        if vertShader != 0 {
            glDetachShader(programGlName, vertShader)
            glDeleteShader(vertShader)
        }
        if fragShader != 0 {
            glDetachShader(programGlName, fragShader)
            glDeleteShader(fragShader)
        }
        
        return programGlName
    }
    
    
    private func compileShader(_ shader: inout GLuint, type: GLenum, code: String) -> Bool {
        var status: GLint = 0
        let source: UnsafePointer<Int8> = (code as NSString).utf8String!
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
    
    private func linkProgram(_ prog: GLuint) -> Bool {
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
    
    private func validateProgram(prog: GLuint) -> Bool {
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

}
