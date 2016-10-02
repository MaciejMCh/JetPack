//
//  ModelsEditorDisplayer.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

protocol Displayer {
    func display(displayer: Displayer)
    
    func rootDisplayer() -> Displayer
    func compoundDisplayer(displayers: [Displayer]) -> Displayer
    func editingDisplayer(editableProperty: EditableProperty) -> Displayer!
}
