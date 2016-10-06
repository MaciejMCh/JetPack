//
//  OSXDisplayer.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Cocoa

extension NSViewController: Displayer {
    func display(displayer: Displayer) {
        guard let viewController = displayer as? NSViewController else {return}
        presentViewControllerAsModalWindow(viewController)
    }
    
    func rootDisplayer() -> Displayer {
        return ViewController.rootViewController
    }
    
    func compoundDisplayer(displayers: [Displayer]) -> Displayer {
        let controller = CompoundViewController.withComponents(components: displayers as! [NSViewController])
        return controller
    }
    
    func editingDisplayer(editableProperty: EditableProperty) -> Displayer! {
        if let modelProperty = editableProperty as? ModelEditableProperty {
            return NSViewController().compoundDisplayer(displayers: modelProperty.model.properties.map{NSViewController().editingDisplayer(editableProperty: $0)})
        }
        if let optionsProperty = editableProperty as? OptionEditableProperty {
            return OptionsEditorViewController.with(optionProperty: optionsProperty)
        }
        if let vecto3Property = editableProperty as? PrimitiveEditableProperty<Vector3> {
            return Vector3EditorViewController.withProperty(vector3Property: vecto3Property)
        }
        if let tagProperty = editableProperty as? PrimitiveEditableProperty<Tag> {
            return TagEditorViewController.withTagProperty(tagProperty: tagProperty)
        }
        if let eulerProperty = editableProperty as? PrimitiveEditableProperty<EulerAngles> {
            return EulerEditorViewController.withEulerProperty(eulerProperty: eulerProperty)
        }
        assert(false, "not implemented for \(editableProperty)")
        return nil
    }
}
