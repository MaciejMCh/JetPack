//
//  ShaderCreator.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 17.01.2017.
//  Copyright © 2017 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Utils

public extension Scope {
    public func variablesUsed() -> [AnyVariable] {
        return (instructions.typeFiltered() as [VariablesUser]).map{$0.variables()}.reduce([], +)
    }
}

protocol VariablesUser {
    func variables() -> [AnyVariable]
}

extension Declaration: VariablesUser {
    func variables() -> [AnyVariable] {
        return [variable]
    }
}

extension AnyEvaluation {
    func variables() -> [AnyVariable] {
        if let function = self as? AnyFunction {
            return function.arguments.map{$0.variables()}.reduce([], +)
        }
        if let variable = self as? AnyVariable {
            return [variable]
        }
        return []
    }
}

extension Assignment: VariablesUser {
    func variables() -> [AnyVariable] {
        return [variable] +? evaluation.variables()
    }
}
