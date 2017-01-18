//
//  Variable.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 27.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

struct AlgebraicPrimitiveOperations {
    static func multiplication<LhsRowSize: AlgebraicPrimitiveSize, ProductSize: AlgebraicPrimitiveSize, RhsColSize: AlgebraicPrimitiveSize>(arg1: Evaluation<AlgebraicPrimitive<LhsRowSize, ProductSize>>, arg2: Evaluation<AlgebraicPrimitive<ProductSize, RhsColSize>>) -> TwoArgsFunction<AlgebraicPrimitive<LhsRowSize, ProductSize>, AlgebraicPrimitive<ProductSize, RhsColSize>, AlgebraicPrimitive<LhsRowSize, RhsColSize>> {
        return TwoArgsFunction(arg1: arg1, arg2: arg2)
    }
    
    static func addition<RowSize: AlgebraicPrimitiveSize, ColSize: AlgebraicPrimitiveSize>(arg1: Evaluation<AlgebraicPrimitive<RowSize, ColSize>>, arg2: Evaluation<AlgebraicPrimitive<RowSize, ColSize>>) -> TwoArgsFunction<AlgebraicPrimitive<RowSize, ColSize>, AlgebraicPrimitive<RowSize, ColSize>, AlgebraicPrimitive<RowSize, ColSize>> {
        return TwoArgsFunction(arg1: arg1, arg2: arg2)
    }
    
    static func scalarMultiplication<RowSize: AlgebraicPrimitiveSize, ColSize: AlgebraicPrimitiveSize>(primitive: Evaluation<AlgebraicPrimitive<RowSize, ColSize>>, scalar: Evaluation<AlgebraicPrimitive<SizeOf1, SizeOf1>>) -> TwoArgsFunction<AlgebraicPrimitive<RowSize, ColSize>, AlgebraicPrimitive<SizeOf1, SizeOf1>, AlgebraicPrimitive<RowSize, ColSize>> {
        return TwoArgsFunction(arg1: primitive, arg2: scalar)
    }
    
    static func dotProduct<VectorSize: AlgebraicPrimitiveSize>(arg1: Evaluation<AlgebraicPrimitive<SizeOf1, VectorSize>>, arg2: Evaluation<AlgebraicPrimitive<SizeOf1, VectorSize>>) -> TwoArgsFunction<AlgebraicPrimitive<SizeOf1, VectorSize>, AlgebraicPrimitive<SizeOf1, VectorSize>, AlgebraicPrimitive<SizeOf1, SizeOf1>> {
        return TwoArgsFunction(arg1: arg1, arg2: arg2)
    }
}
