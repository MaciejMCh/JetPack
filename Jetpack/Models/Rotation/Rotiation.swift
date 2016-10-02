//
//  Rotiation.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

protocol Rotation {
    func rotationMatrix() -> Matrix4
}

class AxesRotation: Rotation {
    var axesRotationVector: Vector3 = Vector3()
    
    func rotationMatrix() -> Matrix4 {
        return Matrix4()
    }
}

class EulerRotiation: Rotation {
    var eulerAngles: EulerAngles = EulerAngles()
    
    func rotationMatrix() -> Matrix4 {
        return Matrix4()
    }
}
