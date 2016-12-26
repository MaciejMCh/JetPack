//
//  Vertex.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct Vertex {
    let attributeInterface: AttributeInterface
    let data: [AttributeFace: [Float]]
    
    public init?(data: [AttributeFace: [Float]]) {
        if Vertex.validate(data: data) {
            self.data = data
            self.attributeInterface = AttributeInterface(attributes: Array(data.keys))
        } else {
            return nil
        }
    }
    
    private static func validate(data: [AttributeFace: [Float]]) -> Bool {
        for attribute in data.keys {
            if data[attribute]?.count != attribute.size() {
                return false
            }
        }
        return true
    }
}
