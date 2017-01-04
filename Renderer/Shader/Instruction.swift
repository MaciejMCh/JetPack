//
//  Instruction.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 27.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

protocol Instruction {
    
}

protocol AnyEvaluation {
    
}

class Evaluation<T>: AnyEvaluation {
    
}

class Variable<T>: Evaluation<T> {
    let name: String
    
    init(name: String) {
        self.name = name
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
}

struct Assignment<T>: Instruction {
    let variable: Variable<T>
    let evaluation: Evaluation<T>
}
