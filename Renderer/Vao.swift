//
//  Vao.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct Vao {
    let gpuIdentity: GpuIdentity
    
    public init(gpuIdentity: GpuIdentity) {
        self.gpuIdentity = gpuIdentity
    }
}

protocol VaoAllocation {
    func draw()
}


struct WholeVaoAllocation: VaoAllocation {
    let vao: Vao
    
    func draw() {
        
    }
}
