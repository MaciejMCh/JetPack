//
//  Primitive.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

protocol Primitive {
    var name: String {get}
}

struct Vec2: Primitive {
    let name = "Vec2"
}

struct Vec3: Primitive {
    let name = "Vec3"
}
