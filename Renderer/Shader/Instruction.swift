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

class Evaluation<T>: AnyEvaluation {
    func variablesUsed() -> [AnyVariable] {
        return []
    }
}

public protocol AnyVariable {
    var name: String {get}
}

class Variable<T>: Evaluation<T>, AnyVariable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    override func variablesUsed() -> [AnyVariable] {
        return [self]
    }
}

class Function<T>: Evaluation<T> {
    let signature: String
    let arguments: [AnyEvaluation]
    
    init(signature: String, arguments: [AnyEvaluation]) {
        self.signature = signature
        self.arguments = arguments
    }
}

class InfixOperation<Lhs, Rhs, Result>: Evaluation<Result> {
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

struct Assignment<T>: Instruction {
    let variable: Variable<T>
    let evaluation: Evaluation<T>
    
    func variablesUsed() -> [AnyVariable] {
        return [variable] + evaluation.variablesUsed()
    }
}

struct Declaration<T>: Instruction {
    let variable: Variable<T>
    
    func variablesUsed() -> [AnyVariable] {
        return [variable]
    }
}
