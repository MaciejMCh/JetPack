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
    
    func tagPropertyEditorDisplayer(property: PrimitiveEditableProperty<Tag>) -> Displayer {
        return TagEditorViewController.withTagProperty(tagProperty: property)
    }
    
    func vec3PropertyEditorDisplayer(property: PrimitiveEditableProperty<Vector3>) -> Displayer {
        return Vector3EditorViewController.withProperty(vector3Property: property)
    }
    
    
}
