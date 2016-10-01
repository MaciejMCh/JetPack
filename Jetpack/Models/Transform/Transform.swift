//
//  Transform.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

protocol Transformation {
    func transformationMatrix() -> Matrix4
}

class StaticTransformation: Transformation {
    var position: Vector3 = Vector3()
    var orientation: Rotation = AxesRotation()
    
    func transformationMatrix() -> Matrix4 {
        return Matrix4()
    }
}
