//
//  Scene.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

class Scene {
    var nodes: [Node] = []
}


extension Scene {
    static func mocked() -> Scene {
        let scene = Scene()
        scene.nodes = [
            Node(identity: Tag(value: "hehe0")),
            Node(identity: Tag(value: "hehe1")),
            Node(identity: Tag(value: "hehe2")),
            Node(identity: Tag(value: "hehe3")),
        ]
        return scene
    }
}
