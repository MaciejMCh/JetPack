//
//  Instruction.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 27.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Utils

public protocol Instruction {
    func variablesUsed() -> [AnyVariable]
}


public protocol AnyEvaluation {
    func variablesUsed() -> [AnyVariable]
}

public class Evaluation<T: Primitive>: AnyEvaluation {
    public func variablesUsed() -> [AnyVariable] {
        return []
    }
}

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

protocol AnyFunction: AnyEvaluation {
    var arguments: [AnyEvaluation] {get}
}

class Function<T: Primitive>: Evaluation<T>, AnyFunction {
    let arguments: [AnyEvaluation]
    
    init(arguments: [AnyEvaluation]) {
        self.arguments = arguments
    }
    
    override func variablesUsed() -> [AnyVariable] {
        return arguments.typeFiltered()
    }
}

class OneArgFunction<Arg: Primitive, Result: Primitive>: Function<Result> {
    let arg: Evaluation<Arg>
    
    init(arg: Evaluation<Arg>) {
        self.arg = arg
        super.init(arguments: [arg])
    }
}

class TwoArgsFunction<Arg1: Primitive, Arg2: Primitive, Result: Primitive>: Function<Result> {
    let arg1: Evaluation<Arg1>
    let arg2: Evaluation<Arg2>
    
    init(arg1: Evaluation<Arg1>, arg2: Evaluation<Arg2>) {
        self.arg1 = arg1
        self.arg2 = arg2
        super.init(arguments: [arg1, arg2])
    }
}

struct Assignment<T: Primitive>: Instruction {
    let variable: Variable<T>
    let evaluation: Evaluation<T>
    
    func variablesUsed() -> [AnyVariable] {
        var result = evaluation.variablesUsed()
        result.append(variable)
        return result
    }
}

struct Declaration: Instruction {
    let variable: AnyVariable
    
    func variablesUsed() -> [AnyVariable] {
        return [variable]
    }
}
