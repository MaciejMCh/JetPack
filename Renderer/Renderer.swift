//
//  Renderer.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct Renderer {
    let program: Program
    let renderingEntity: RenderingEntity
    
    public init(program: Program, renderingEntity: RenderingEntity) {
        self.program = program
        self.renderingEntity = renderingEntity
    }
    
    public func render() {
        program.use()
        renderingEntity.enviroment.pass()
        renderingEntity.vaoAllocation.draw()
    }
}
