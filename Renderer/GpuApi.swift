//
//  GpuApi.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 22.11.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import GLKit

enum GpuApiError: Error {
    case GenerateStaticVerticesVboEmptyVertexArray
}

public protocol GpuApi {
    func bind(attribute: Attribute)
    func draw(mesh: Mesh)
    func generateStaticVao(mesh: Mesh) -> StaticDrawVao
}

struct OpenGlGpuApi: GpuApi {
    func bind(attribute: Attribute) {}
    func draw(mesh: Mesh) {}
    
    func generateStaticVao(mesh: Mesh) -> StaticDrawVao {
        var vaoGlName: GLuint = 0
        glGenVertexArrays(1, &vaoGlName)
        glBindVertexArray(vaoGlName)

        return StaticDrawVao(identity: OpenGlGpuIdentity(glName: vaoGlName), indicesVbo: generateIndicesVbo(indices: mesh.indices), dataVbo: generateStaticMeshVbo(mesh: mesh))
    }
    
    func generateIndicesVbo(indices: [UInt]) -> IndicesVbo {
        var indicesVboGlName: GLuint = 0
        glGenBuffers(1, &indicesVboGlName)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indicesVboGlName)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), Int(indices.count) * MemoryLayout<GLuint>.size, indices.map{GLuint($0)}, GLenum(GL_STATIC_DRAW))
        return IndicesVbo(gpuIdentity: OpenGlGpuIdentity(glName: indicesVboGlName))
    }
    
    func generateStaticMeshVbo(mesh: Mesh) -> Vbo {
        var data: [Float] = []
        for vertex in mesh.vertices {
            for attributeData in vertex.data {
                data.append(contentsOf: attributeData.value)
            }
        }
        
        var vboGlName: GLuint = 0
        glGenBuffers(1, &vboGlName)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vboGlName)
        glBufferData(GLenum(GL_ARRAY_BUFFER), data.count * MemoryLayout<GLfloat>.size, data.map{GLfloat($0)}, GLenum(GL_STATIC_DRAW))
        
        let vertexSize = Int(mesh.vertices[0].attributes().map{$0.size()}.reduce(0, +)) * MemoryLayout<GLuint>.size
        
        var ptr = UnsafePointer<GLfloat>(data)
        var index = GLuint(0)
        for attribute in mesh.vertices[0].attributes() {
            glVertexAttribPointer(index, GLint(attribute.size()), GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(vertexSize), ptr)
            ptr = ptr.advanced(by: Int(attribute.size()))
            index += 1
        }
        
        return Vbo(gpuIdentity: OpenGlGpuIdentity(glName: vboGlName))
    }
}

struct OpenGlGpuIdentity: GpuIdentity {
    let glName: GLuint
}

public struct GpuApiSettings {
    public static let gpuApi: GpuApi = OpenGlGpuApi()
}
