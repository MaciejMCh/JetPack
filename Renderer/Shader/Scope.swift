//
//  Scope.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 27.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

struct Scope {
    let instructions: [Instruction]
}

// MARK: Basic samples
struct Scopes {
    static func LambertFactorScope() -> Scope {
        let bug: Variable<Vec<SizeOf3>>?

        let surfaceNormalVersor: Variable<Vec3> = Variable(name: "surfaceNormalVersor")
        let surfaceToLightVersor: Variable<Vec3> = Variable(name: "surfaceToLightVersor")
        let lambertFactor: Variable<Scalar> = Variable(name: "lambertFactor")
        
        let dotProduct = AlgebraicPrimitiveOperations.dotProduct(lhs: surfaceNormalVersor, rhs: surfaceToLightVersor)
        let assignment = Assignment(variable: lambertFactor, evaluation: dotProduct)
        
        return Scope(instructions: [assignment])
    }
}
