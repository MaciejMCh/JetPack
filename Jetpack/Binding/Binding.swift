//
//  Binding.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.11.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

class PropertyEditor<T: JetPrimitive> {
    
}

class Binding {
    private static var bindings: [Binding] = []
    static func bindProperty<T>(editableProperty: PrimitiveEditableProperty<T>, editor: PropertyEditor<T>) {
        
    }
    
    
    
//    private let property: EditableProperty
//    private var editors = WeakReferencesArray<PropertyEditor>()
//    
//    init(property: EditableProperty) {
//        self.property = property
//    }
}
