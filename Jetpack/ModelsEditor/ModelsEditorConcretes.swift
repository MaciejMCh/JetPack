//
//  ModelsEditorConcretes.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

extension Node: EditableModel {
    var properties: [EditableProperty] {return [PrimitiveEditableProperty(name: "identity", property: identity)]}
}
