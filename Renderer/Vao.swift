//
//  Vao.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 22.11.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public protocol GpuMemoryAllocation {
    func draw()
}

public struct StaticDrawVao: GpuMemoryAllocation {
    let identity: GpuIdentity
    let indicesVbo: IndicesVbo
    let dataVbo: Vbo
    
    public func draw() {
        
    }
}
