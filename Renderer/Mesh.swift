//
//  Mesh.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 22.11.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct Mesh {
    let vertices: [Vertex]
    let indices: [UInt]
    
    public init?(vertices: [Vertex], indices: [UInt]) {
        if !MeshValidator().validateVertices(vertices: vertices, indices: indices) {
            return nil
        }
        
        self.vertices = vertices
        self.indices = indices
    }
}

struct MeshValidator {
    func validateVertices(vertices: [Vertex], indices: [UInt]) -> Bool {
        if vertices.isEmpty {
            return false
        }
        
        if indices.min() != 0 {
            return false
        }
        
        if UInt(vertices.count - 1) != indices.max() {
            return false
        }
        
        let vertexAttributes: (Vertex) -> Set<Attribute> = { (vertex: Vertex) in
            return Set<Attribute>(vertex.data.keys)
        }
        
        guard let first = vertices.first else {return false}
        let attributes = vertexAttributes(first)
        
        for vertex in vertices {
            if vertexAttributes(vertex) != attributes {
                return false
            }
        }
        
        return true
    }
}
