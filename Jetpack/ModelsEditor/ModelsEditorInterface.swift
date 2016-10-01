//
//  Editor.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

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

class ModelEditableProperty: EditableProperty {
    let name: String
    let model: EditableModel
    
    init(name: String, model: EditableModel) {
        self.name = name
        self.model = model
    }
    
    func updateValue() {
        for property in model.properties {
            property.updateValue()
        }
    }
}

protocol EditableModel {
    var properties: [EditableProperty] {get}
}

class OptionEditableProperty: EditableProperty {
    let name: String
    let options: [EditableProperty]
    var selectedOption: EditableProperty
    
    init(name: String, options: [EditableProperty]) {
        self.name = name
        self.options = options
        selectedOption = options.first!
    }
    
    func updateValue() {
        selectedOption.updateValue()
    }
}
