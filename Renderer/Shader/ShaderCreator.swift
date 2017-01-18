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
        return instructions.map{$0.variablesUsed()}.reduce([], +)
    }
    
    public func isDeclaredInScope(variable: AnyVariable) -> Bool {
        for declaration: Declaration in instructions.typeFiltered() {
            if declaration.variable.equals(variable: variable)  {
                return true
            }
        }
        return false
    }
}

extension AnyVariable {
    func equals(variable: AnyVariable) -> Bool {
        return name == variable.name && type.name == type.name
    }
}
