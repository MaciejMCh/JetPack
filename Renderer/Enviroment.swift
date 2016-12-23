//
//  Enviroment.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 22.11.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public protocol Enviroment {
    func mediums() -> [Medium]
}

public struct EmptyEnviroment: Enviroment {
    public func mediums() -> [Medium] {
        return []
    }
    
    public init() {
        
    }
}
