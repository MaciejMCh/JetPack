//
//  OpenGlVao.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 25.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import CoreModel

extension OpenGlGpuApi {
    public func allocateVaoFromMesh(mesh: Mesh) -> Vao? {
        var vaoGlName = GLuint()
        glGenVertexArrays(1, &vaoGlName)
        glBindVertexArray(vaoGlName)
        
        // Create indices vbo
        let indicesBuffer = mesh.indices.map{GLuint($0)}
        var indicesVboGLName = GLuint()
        glGenBuffers(1, &indicesVboGLName)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indicesVboGLName)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), indicesBuffer.size(), indicesBuffer, GLenum(GL_STATIC_DRAW))
        
        // Create data vbo
        let dataBuffer = mesh.bufferData().map{GLfloat($0)}
        var dataVboGlName = GLuint()
        glGenBuffers(1, &dataVboGlName)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), dataVboGlName)
        glBufferData(GLenum(GL_ARRAY_BUFFER), GLsizeiptr(MemoryLayout<GLfloat>.size * dataBuffer.count), dataBuffer, GLenum(GL_STATIC_DRAW))
        
        
        let vertexFloatsCount = mesh.attributeInterface.attributes.map{$0.size()}.reduce(0, +)
        let floatSize = MemoryLayout<GLfloat>.size
        let vertexSize = GLsizei(vertexFloatsCount * floatSize)
        
        var offsetPointer = 0
        var index = 0
        for attribute in mesh.attributeInterface.attributes {
            glEnableVertexAttribArray(GLuint(index))
            glVertexAttribPointer(GLuint(index), GLint(attribute.size()), GLenum(GL_FLOAT), GLboolean(GL_FALSE), vertexSize, UnsafeRawPointer(bitPattern: offsetPointer))
            offsetPointer += attribute.size() * floatSize
            index += 1
        }
        
        let gpuIdentity = OpenGlGpuIdentity(openGlName: vaoGlName)
        return Vao(gpuIdentity: gpuIdentity, dataVboGpuIdentity: OpenGlGpuIdentity(openGlName: dataVboGlName), dataCount: mesh.indices.count, attributeInterface: mesh.attributeInterface)
    }
    
    public func wholeVaoAllocation(vao: Vao) -> WholeVaoAllocation {
        return WholeVaoAllocation(vao: vao) {
            glBindVertexArray((vao.gpuIdentity as! OpenGlGpuIdentity).openGlName)
            glDrawElements(GLenum(GL_TRIANGLES), GLsizei(vao.dataCount), GLenum(GL_UNSIGNED_INT), nil)
        }
    }
}

extension Array {
    func size () -> Int {
        return self.count * MemoryLayout.size(ofValue: self[0])
    }
}
