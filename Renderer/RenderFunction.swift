//
//  RenderFunction.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

struct RenderFunction {
    let attributesInterface: AttributeInterface
    let uniformInterface: UniformInterface
    let shaderCode: ShaderCode
}

public protocol ShaderCode {
    var vertexShaderCode: String {get}
    var fragmentShaderCode: String {get}
}
