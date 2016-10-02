//
//  Primitives.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

protocol JetPrimitive {
    associatedtype CPUType
    var value: CPUType {get set}
}

class Tag: JetPrimitive {
    typealias CPUType = String
    
    var value: String
    
    init(value: String = "") {
        self.value = value
    }
}

class Scalar {
    var value: Float
    
    init(value: Float = 0.0) {
        self.value = value
    }
}

class Matrix4 {
    
}

class Vector3: JetPrimitive {
    typealias CPUType = (x: Scalar, y: Scalar, z: Scalar)
    
    var value: CPUType
    
    init(value: CPUType = (x: Scalar(), y: Scalar(), z: Scalar())) {
        self.value = value
    }
    
}

class EulerAngles: JetPrimitive {
    typealias CPUType = (yaw: Scalar, pitch: Scalar, roll: Scalar)
    
    var value: CPUType
    
    init(value: CPUType = (yaw: Scalar(), pitch: Scalar(), roll: Scalar())) {
        self.value = value
    }
}
