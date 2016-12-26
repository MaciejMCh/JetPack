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
    let location: UniformLocation
    
    public let hashValue: Int
    
    public init(face: UniformFace, location: UniformLocation) {
        self.face = face
        self.location = location
        self.hashValue = face.hashValue
    }
    
    public static func ==(lhs: Uniform, rhs: Uniform) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

public protocol UniformLocation {
    
}

public struct UniformFace: Equatable, Hashable {
    public let name: String
    let type: Primitive
    
    public let hashValue: Int
    
    init(name: String, type: Primitive) {
        self.name = name
        self.type = type
        self.hashValue = (type.name + "_" + self.name).hashValue
    }
    
    public static func ==(lhs: UniformFace, rhs: UniformFace) -> Bool {
        if lhs.name != rhs.name {
            return false
        }
        return true
    }
    
}

public struct UniformInterface {
    public let uniformFaces: Set<UniformFace>
    
    public init(uniformFaces: Set<UniformFace>) {
        self.uniformFaces = uniformFaces
    }
}
