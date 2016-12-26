//
//  Program.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct Program {
    let gpuIdentity: GpuIdentity
    let attributeInterface: AttributeInterface
    let uniforms: Set<Uniform>
    let useFunction: () -> ()
    
    public init(gpuIdentity: GpuIdentity, attributeInterface: AttributeInterface, uniforms: Set<Uniform>, useFunction: @escaping () -> ()) {
        self.gpuIdentity = gpuIdentity
        self.attributeInterface = attributeInterface
        self.uniforms = uniforms
        self.useFunction = useFunction
    }
    
    public func use() {
        useFunction()
    }
}
