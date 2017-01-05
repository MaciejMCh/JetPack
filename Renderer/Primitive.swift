//
//  Primitive.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public protocol Primitive {
    var name: String {get}
    init()
}

public protocol AlgebraicPrimitiveSize {
    static var size: UInt {get}
}
public struct SizeOf1: AlgebraicPrimitiveSize {
    public static let size: UInt = 1
}
public struct SizeOf2: AlgebraicPrimitiveSize {
    public static let size: UInt = 2
}
public struct SizeOf3: AlgebraicPrimitiveSize {
    public static let size: UInt = 3
}
public struct SizeOf4: AlgebraicPrimitiveSize {
    public static let size: UInt = 4
}

public class AlgebraicPrimitive<RowSize: AlgebraicPrimitiveSize, ColSize: AlgebraicPrimitiveSize>: Primitive {
    public var name: String {
        if RowSize.size == 1 {
            if ColSize.size == 1 {
                return "scalar"
            }
            return "vec\(ColSize.size)"
        }
        
        if RowSize.size == ColSize.size {
            return "mat\(ColSize.size)"
        }
        
        return "mat\(RowSize.size)x\(ColSize.size)"
    }
    
    public required init() {}
}

public typealias Scalar = AlgebraicPrimitive<SizeOf1, SizeOf1>

public typealias Vec<Size: AlgebraicPrimitiveSize> = AlgebraicPrimitive<SizeOf1, Size>
public typealias Vec2 = Vec<SizeOf2>
public typealias Vec3 = Vec<SizeOf3>
public typealias Vec4 = Vec<SizeOf4>

public typealias Mat<Size: AlgebraicPrimitiveSize> = AlgebraicPrimitive<Size, Size>
public typealias Mat2 = Mat<SizeOf2>
public typealias Mat3 = Mat<SizeOf3>
public typealias Mat4 = Mat<SizeOf4>
