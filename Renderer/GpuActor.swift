//
//  GpuActor.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 29.11.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

protocol GpuIdentity {}

protocol GpuActor {
    var gpuIdentity: GpuIdentity {get}
}
