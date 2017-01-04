//
//  Variable.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 27.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

struct AlgebraicPrimitiveOperations {
    static func multiplication<LhsRowSize: AlgebraicPrimitiveSize, ProductSize: AlgebraicPrimitiveSize, RhsColSize: AlgebraicPrimitiveSize>(lhs: Evaluation<AlgebraicPrimitive<LhsRowSize, ProductSize>>, rhs: Evaluation<AlgebraicPrimitive<ProductSize, RhsColSize>>) -> InfixOperation<AlgebraicPrimitive<LhsRowSize, ProductSize>, AlgebraicPrimitive<ProductSize, RhsColSize>, AlgebraicPrimitive<LhsRowSize, RhsColSize>> {
        return InfixOperation(operatorSymbol: "*", lhs: lhs, rhs: rhs)
    }
    
    static func addition<RowSize: AlgebraicPrimitiveSize, ColSize: AlgebraicPrimitiveSize>(lhs: Evaluation<AlgebraicPrimitive<RowSize, ColSize>>, rhs: Evaluation<AlgebraicPrimitive<RowSize, ColSize>>) -> InfixOperation<AlgebraicPrimitive<RowSize, ColSize>, AlgebraicPrimitive<RowSize, ColSize>, AlgebraicPrimitive<RowSize, ColSize>> {
        return InfixOperation(operatorSymbol: "+", lhs: lhs, rhs: rhs)
    }
    
    static func scalarMultiplication<RowSize: AlgebraicPrimitiveSize, ColSize: AlgebraicPrimitiveSize>(primitive: Evaluation<AlgebraicPrimitive<RowSize, ColSize>>, scalar: Evaluation<AlgebraicPrimitive<SizeOf1, SizeOf1>>) -> InfixOperation<AlgebraicPrimitive<RowSize, ColSize>, AlgebraicPrimitive<SizeOf1, SizeOf1>, AlgebraicPrimitive<RowSize, ColSize>> {
        return InfixOperation(operatorSymbol: "*", lhs: primitive, rhs: scalar)
    }
    
    static func dotProduct<VectorSize: AlgebraicPrimitiveSize>(lhs: Evaluation<AlgebraicPrimitive<SizeOf1, VectorSize>>, rhs: Evaluation<AlgebraicPrimitive<SizeOf1, VectorSize>>) -> InfixOperation<AlgebraicPrimitive<SizeOf1, VectorSize>, AlgebraicPrimitive<SizeOf1, VectorSize>, AlgebraicPrimitive<SizeOf1, SizeOf1>> {
        return InfixOperation(operatorSymbol: "∙", lhs: lhs, rhs: rhs)
    }
}
