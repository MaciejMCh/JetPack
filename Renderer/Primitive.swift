//
//  Primitive.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

protocol Primitive {
    var name: String {get}
}

protocol AlgebraicPrimitiveSize {}
struct SizeOf1: AlgebraicPrimitiveSize {}
struct SizeOf2: AlgebraicPrimitiveSize {}
struct SizeOf3: AlgebraicPrimitiveSize {}

class AlgebraicPrimitive<RowSize: AlgebraicPrimitiveSize, ColSize: AlgebraicPrimitiveSize>: Primitive {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct AlgebraicPrimitives {
    static let scalar = AlgebraicPrimitive<SizeOf1, SizeOf1>(name: "Scalar")
    static let vec2 = AlgebraicPrimitive<SizeOf1, SizeOf1>(name: "Vec2")
    static let vec3 = AlgebraicPrimitive<SizeOf1, SizeOf1>(name: "Vec3")
    static let vec4 = AlgebraicPrimitive<SizeOf1, SizeOf1>(name: "Vec4")
    static let mat2 = AlgebraicPrimitive<SizeOf1, SizeOf1>(name: "Mat2")
    static let mat3 = AlgebraicPrimitive<SizeOf1, SizeOf1>(name: "Mat3")
    static let mat4 = AlgebraicPrimitive<SizeOf1, SizeOf1>(name: "Mat4")
}
