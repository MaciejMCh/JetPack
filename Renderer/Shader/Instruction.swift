//
//  Instruction.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 27.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public protocol Instruction {
    func variablesUsed() -> [AnyVariable]
}

protocol AnyEvaluation: Instruction {
    
}

class Evaluation<T: Primitive>: AnyEvaluation {
    func variablesUsed() -> [AnyVariable] {
        return []
    }
}

public protocol AnyVariable {
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
    
    override func variablesUsed() -> [AnyVariable] {
        return [self]
    }
}

class Function<T: Primitive>: Evaluation<T> {
    let signature: String
    let arguments: [AnyEvaluation]
    
    init(signature: String, arguments: [AnyEvaluation]) {
        self.signature = signature
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
    
    override func variablesUsed() -> [AnyVariable] {
        return lhs.variablesUsed() + rhs.variablesUsed()
    }
}

struct Assignment<T: Primitive>: Instruction {
    let variable: Variable<T>
    let evaluation: Evaluation<T>
    
    func variablesUsed() -> [AnyVariable] {
        return [variable] + evaluation.variablesUsed()
    }
}

struct Declaration<T: Primitive>: Instruction {
    let variable: Variable<T>
    
    func variablesUsed() -> [AnyVariable] {
        return [variable]
    }
}
