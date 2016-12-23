//
//  Medium.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 22.11.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public protocol Medium {
    func pass()
}

struct PrimitiveGpuMedium: Medium {
    private let passClosure: () -> ()
    
    init<T: GpuPrimitive>(uniform: GpuPrimitiveUniform<T>, cpuCounterpartGetter: @escaping () -> (T.CpuCounterpart)) {
        passClosure = {
            UniformPass<T>(uniform: uniform, primitive: cpuCounterpartGetter()).pass()
        }
    }
    
    func pass() {
        passClosure()
    }
}

struct UniformPass<T: GpuPrimitive> {
    private let uniform: Uniform
    private let primitive: T.CpuCounterpart
    
    init(uniform: Uniform, primitive: T.CpuCounterpart) {
        self.uniform = uniform
        self.primitive = primitive
    }
    
    func pass() {
        
    }
}
