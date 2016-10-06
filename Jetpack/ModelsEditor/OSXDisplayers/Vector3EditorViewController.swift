//
//  Vector3EditorViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Cocoa

class Vector3EditorViewController: EditorViewController {
    static func withProperty(vector3Property: PrimitiveEditableProperty<Vector3>) -> Vector3EditorViewController {
        let controller = NSStoryboard(name: "Vector3EditorViewController", bundle: nil).instantiateInitialController() as! Vector3EditorViewController
        controller.vector3Property = vector3Property
        controller.property = vector3Property
        return controller
    }
    
    var vector3Property: PrimitiveEditableProperty<Vector3>!
    
    @IBOutlet weak var xValueTextField: NSTextField!
    @IBOutlet weak var yValueTextField: NSTextField!
    @IBOutlet weak var zValueTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xValueTextField.stringValue = "\(vector3Property.value.x.value)"
        yValueTextField.stringValue = "\(vector3Property.value.y.value)"
        zValueTextField.stringValue = "\(vector3Property.value.z.value)"
    }
}
