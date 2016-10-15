//
//  Node.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

class Node {
    let identity: Tag
    let element: Element
    
    init(identity: Tag = Tag(), element: Element = Element()) {
        self.identity = identity
        self.element = element
    }
}
