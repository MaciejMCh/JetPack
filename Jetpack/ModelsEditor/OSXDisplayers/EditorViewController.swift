//
//  EditorViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 02.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Cocoa

class EditorViewController: NSViewController {
    @IBOutlet weak var propertyNameLabel: NSTextField!
    @IBOutlet weak var leadingMarginConstraint: NSLayoutConstraint!
    
    var nestingLevel: UInt = 0
    var property: EditableProperty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeadingMarginConstraint()
        setupPropertyNameLabel()
    }
    
    func setupPropertyNameLabel() {
        propertyNameLabel?.stringValue = property.name
    }
    
    func setupLeadingMarginConstraint() {
        leadingMarginConstraint?.constant = CGFloat(100) + CGFloat(20 * nestingLevel)
    }
}
