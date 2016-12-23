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
    let attributes: Set<Attribute>
    let uniforms: Set<Uniform>
    
    public init(gpuIdentity: GpuIdentity, attributes: Set<Attribute>, uniforms: Set<Uniform>) {
        self.gpuIdentity = gpuIdentity
        self.attributes = attributes
        self.uniforms = uniforms
    }
    
    public func use() {
        
    }
}
