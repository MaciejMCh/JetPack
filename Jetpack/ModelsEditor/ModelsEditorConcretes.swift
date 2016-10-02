//
//  ModelsEditorConcretes.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

extension Node: EditableModel {
    var properties: [EditableProperty] {
        return [
            PrimitiveEditableProperty(name: "identity", property: identity),
            ModelEditableProperty(name: "element", model: element)
        ]}
}

extension Element: EditableModel {
    var properties: [EditableProperty] {
        return [
            OptionEditableProperty(name: "transform", options: [
                ModelEditableProperty(name: "static", model: StaticTransformation()),
                ModelEditableProperty(name: "dynamic", model: DynamicTransformation())
                ])
        ]
    }
}

extension StaticTransformation: EditableModel {
    var properties: [EditableProperty] {
        return [
            PrimitiveEditableProperty(name: "position", property: position),
            OptionEditableProperty(name: "orientation", options: [
                ModelEditableProperty(name: "axes", model: AxesRotation()),
                ModelEditableProperty(name: "euler", model: EulerRotiation())
                ])
        ]
    }
}

extension AxesRotation: EditableModel {
    var properties: [EditableProperty] {
        return [
            PrimitiveEditableProperty(name: "axes rotation vector", property: axesRotationVector)
        ]
    }
}


extension EulerRotiation: EditableModel {
    var properties: [EditableProperty] {
        return [
            PrimitiveEditableProperty(name: "euler angles", property: eulerAngles)
        ]
    }
}
