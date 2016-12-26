//
//  RenderFunction.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct RenderFunction {
    public let attributeInterface: AttributeInterface
    public let uniformInterface: UniformInterface
    public let shaderImplementation: ShaderImplementation
    
    public init(attributeInterface: AttributeInterface, uniformInterface: UniformInterface, shaderImplementation: ShaderImplementation) {
        self.attributeInterface = attributeInterface
        self.uniformInterface = uniformInterface
        self.shaderImplementation = shaderImplementation
    }
}

public protocol ShaderImplementation {
    var vertexShaderCode: String {get}
    var fragmentShaderCode: String {get}
}

public struct ResourceShaderCode: ShaderImplementation {
    public let vertexShaderCode: String
    public let fragmentShaderCode: String
    
    public init(resourceName: String) {
        self.vertexShaderCode = try! String.init(contentsOfFile: Bundle.main.path(forResource: resourceName, ofType: "vsh")!)
        self.fragmentShaderCode = try! String.init(contentsOfFile: Bundle.main.path(forResource: resourceName, ofType: "fsh")!)
    }
}
