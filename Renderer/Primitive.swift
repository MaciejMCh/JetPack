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
struct SizeOf4: AlgebraicPrimitiveSize {}

class AlgebraicPrimitive<RowSize: AlgebraicPrimitiveSize, ColSize: AlgebraicPrimitiveSize>: Primitive {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

typealias Scalar = AlgebraicPrimitive<SizeOf1, SizeOf1>

typealias Vec<Size: AlgebraicPrimitiveSize> = AlgebraicPrimitive<SizeOf1, Size>
typealias Vec2 = Vec<SizeOf2>
typealias Vec3 = Vec<SizeOf3>
typealias Vec4 = Vec<SizeOf4>

typealias Mat<Size: AlgebraicPrimitiveSize> = AlgebraicPrimitive<Size, Size>
typealias Mat2 = Mat<SizeOf2>
typealias Mat3 = Mat<SizeOf3>
typealias Mat4 = Mat<SizeOf4>
