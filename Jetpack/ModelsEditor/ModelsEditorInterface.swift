//
//  Editor.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

protocol EditableModel {
    var properties: [EditableProperty] {get}
}

protocol EditableProperty {
    func updateValue()
}

class PrimitiveEditableProperty<T: JetPrimitive>: EditableProperty {
    let name: String
    var property: T
    var value: T.CPUType
    
    init(name: String, property: T) {
        self.name = name
        self.property = property
        self.value = property.value
    }
    
    func updateValue() {
        property.value = value
    }
}
