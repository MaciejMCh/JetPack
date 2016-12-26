//
//  OpenGlGpuApi.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import CoreModel
import GLKit

struct OpenGlGpuIdentity: GpuIdentity {
    let openGlName: GLuint
}

struct OpenGlUniformLocation: UniformLocation {
    let openGlName: GLint
}

public struct OpenGlGpuApi: GpuApi {
    public init() {}
}
