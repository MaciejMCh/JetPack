//
//  Instruction.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 27.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public protocol Instruction {}

public protocol AnyEvaluation: Instruction {}

class Evaluation<T: Primitive>: AnyEvaluation {}

public protocol AnyVariable: AnyEvaluation {
    var name: String {get}
    var type: Primitive {get}
}

class Variable<T: Primitive>: Evaluation<T>, AnyVariable {
    let name: String
    let type: Primitive
    
    init(name: String) {
        self.name = name
        self.type = T()
    }
}

protocol AnyFunction {
    var arguments: [AnyEvaluation] {get}
}

class Function<T: Primitive>: Evaluation<T>, AnyFunction {
    let arguments: [AnyEvaluation]
    
    init(arguments: [AnyEvaluation]) {
        self.arguments = arguments
    }
}

class InfixOperation<Lhs: Primitive, Rhs: Primitive, Result: Primitive>: Evaluation<Result> {
    let operatorSymbol: String
    let lhs: Evaluation<Lhs>
    let rhs: Evaluation<Rhs>
    
    init(operatorSymbol: String, lhs: Evaluation<Lhs>, rhs: Evaluation<Rhs>) {
        self.operatorSymbol = operatorSymbol
        self.lhs = lhs
        self.rhs = rhs
    }
}

struct Assignment<T: Primitive>: Instruction {
    let variable: Variable<T>
    let evaluation: Evaluation<T>
}

struct Declaration<T: Primitive>: Instruction {
    let variable: Variable<T>
}
