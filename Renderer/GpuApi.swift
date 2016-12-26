//
//  GpuApi.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public protocol GpuApi {
    func allocateVaoFromMesh(mesh: Mesh) -> Vao?
    func compileProgramFromRenderFunction(renderFunction: RenderFunction) -> Program?
    func wholeVaoAllocation(vao: Vao) -> WholeVaoAllocation
}
