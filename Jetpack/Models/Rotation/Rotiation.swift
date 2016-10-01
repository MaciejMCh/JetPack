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
    let x: Scalar = Scalar()
    let y: Scalar = Scalar()
    let z: Scalar = Scalar()
    
    func rotationMatrix() -> Matrix4 {
        return Matrix4()
    }
}
