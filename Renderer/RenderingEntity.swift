//
//  RenderingEntity.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 22.11.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct RenderingEntity {
    let gpuMemoryAllocation: GpuMemoryAllocation
    let enviroment: Enviroment
    
    public init(gpuMemoryAllocation: GpuMemoryAllocation, enviroment: Enviroment) {
        self.gpuMemoryAllocation = gpuMemoryAllocation
        self.enviroment = enviroment
    }
}
