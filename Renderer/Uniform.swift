//
//  Uniform.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct Uniform: Hashable {
    let face: UniformFace
    public let hashValue: Int
    
    init(face: UniformFace) {
        self.face = face
        self.hashValue = face.hashValue
    }
    
    public static func ==(lhs: Uniform, rhs: Uniform) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

struct UniformFace: Equatable, Hashable {
    let name: String
    let type: Primitive
    
    let hashValue: Int
    
    init(name: String, type: Primitive) {
        self.name = name
        self.type = type
        self.hashValue = (type.name + "_" + self.name).hashValue
    }
    
    static func ==(lhs: UniformFace, rhs: UniformFace) -> Bool {
        if lhs.name != rhs.name {
            return false
        }
        return true
    }
    
}

struct UniformInterface {
    let uniformFaces: Set<UniformFace>
}
