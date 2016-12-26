//
//  Mesh.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct Mesh {
    public let attributeInterface: AttributeInterface
    let vertices: [Vertex]
    public let indices: [UInt]
    
    public init?(vertices: [Vertex], indices: [UInt]) {
        if Mesh.validate(vertices: vertices, indices: indices) {
            self.vertices = vertices
            self.indices = indices
            self.attributeInterface = vertices.first!.attributeInterface
        } else {
            return nil
        }
    }
    
    private static func validate(vertices: [Vertex], indices: [UInt]) -> Bool {
        guard let first = vertices.first else {return false}
        let attributeInterface = first.attributeInterface
        for vertex in vertices {
            if !vertex.attributeInterface.conformsToInterface(attributeInterface: attributeInterface) {
                return false
            }
        }
        
        let sortedIndices = indices.sorted()
        if sortedIndices.first != 0 {
            return false
        }
        if sortedIndices.last != UInt(vertices.count - 1)  {
            return false
        }
        
        return true
    }
}

public extension Mesh {
    public func bufferData() -> [Float] {
        let nested = vertices.map{vertex in
            return vertex.attributeInterface.attributes.map{attribute in
                return vertex.data[attribute]!
            }
        }
        
        return nested.reduce([], +).reduce([], +)
    }
}

extension Array {
    static func +<T>(lhs: [T], rhs: [T]) -> [T] {
        return []
    }
}
