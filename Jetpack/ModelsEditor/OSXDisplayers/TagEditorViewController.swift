//
//  TagEditorViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Cocoa

class TagEditorViewController: EditorViewController {
    static func withTagProperty(tagProperty: PrimitiveEditableProperty<Tag>) -> TagEditorViewController {
        let me = NSStoryboard(name: "TagEditorViewController", bundle: nil).instantiateInitialController() as! TagEditorViewController
        me.tagProperty = tagProperty
        me.property = tagProperty
        return me
    }
    
    @IBOutlet weak var propertyValueTextField: NSTextField!
    var tagProperty: PrimitiveEditableProperty<Tag>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        propertyValueTextField.stringValue = tagProperty.value
        propertyValueTextField.target = self
        propertyValueTextField.action = #selector(textFieldChanged)
    }
    
    func textFieldChanged() {
        tagProperty.value = propertyValueTextField.stringValue
        tagProperty.updateValue()
    }
}
