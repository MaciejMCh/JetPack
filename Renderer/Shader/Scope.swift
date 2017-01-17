//
//  Scope.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 27.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

// There is `segmentation fault 11` without these declarations
let bugv3: Variable<Vec<SizeOf3>>? = nil
let bugm4: Variable<Mat<SizeOf4>>? = nil

public struct Scope {
    public let instructions: [Instruction]
}

// MARK: Basic samples
public struct Scopes {
    public static func lambertFactor() -> Scope {
        
        let surfaceNormalVersor: Variable<Vec3> = Variable(name: "surfaceNormalVersor")
        let surfaceToLightVersor: Variable<Vec3> = Variable(name: "surfaceToLightVersor")
        let lambertFactor: Variable<Scalar> = Variable(name: "lambertFactor")
        
        let dotProduct = AlgebraicPrimitiveOperations.dotProduct(lhs: surfaceNormalVersor, rhs: surfaceToLightVersor)
        let assignment = Assignment(variable: lambertFactor, evaluation: dotProduct)
        
        return Scope(instructions: [assignment])
    }
}
