//
//  EulerEditorViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 02.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Cocoa

class EulerEditorViewController: EditorViewController {
    static func withEulerProperty(eulerProperty: PrimitiveEditableProperty<EulerAngles>) -> EulerEditorViewController {
        let me = NSStoryboard(name: "EulerEditorViewController", bundle: nil).instantiateInitialController() as! EulerEditorViewController
        me.eulerProperty = eulerProperty
        me.property = eulerProperty
        return me
    }
    
    @IBOutlet weak var yawLabel: NSTextField!
    @IBOutlet weak var pitchLabel: NSTextField!
    @IBOutlet weak var rollLabel: NSTextField!
    
    var eulerProperty: PrimitiveEditableProperty<EulerAngles>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yawLabel.stringValue = "\(eulerProperty.value.yaw.value)"
        pitchLabel.stringValue = "\(eulerProperty.value.pitch.value)"
        rollLabel.stringValue = "\(eulerProperty.value.roll.value)"
    }
}
