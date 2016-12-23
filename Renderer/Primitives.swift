//
//  Primitives.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 22.11.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

protocol GpuPrimitive {
    associatedtype CpuCounterpart
}

struct Vec3: GpuPrimitive {
    typealias CpuCounterpart = (Float, Float, Float)
}
