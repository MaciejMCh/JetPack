//
//  Vertex.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 22.11.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct Vertex {
    let data: [Attribute: [Float]]
}

extension Vertex {
    public static func position(x: Float, y: Float, z: Float) -> Vertex {
        return Vertex(data: [.Position: [x, y, z]])
    }
}

extension Vertex {
    func attributes() -> Set<Attribute> {
        return Set<Attribute>(data.keys)
    }
}
