//
//  Vao.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct Vao {
    public let gpuIdentity: GpuIdentity
    public let dataVboGpuIdentity: GpuIdentity
    public let dataCount: Int
    let attributeInterface: AttributeInterface
    
    public init(gpuIdentity: GpuIdentity, dataVboGpuIdentity: GpuIdentity, dataCount: Int, attributeInterface: AttributeInterface) {
        self.gpuIdentity = gpuIdentity
        self.dataVboGpuIdentity = dataVboGpuIdentity
        self.dataCount = dataCount
        self.attributeInterface = attributeInterface
    }
}

public protocol VaoAllocation {
    var attributeInterface: AttributeInterface {get}
    func draw()
}


public struct WholeVaoAllocation: VaoAllocation {
    let vao: Vao
    let drawFunction: () -> ()
    public let attributeInterface: AttributeInterface
    
    public init(vao: Vao, drawFunction: @escaping () -> ()) {
        self.vao = vao
        self.drawFunction = drawFunction
        self.attributeInterface = vao.attributeInterface
    }
    
    public func draw() {
        drawFunction()
    }
}
