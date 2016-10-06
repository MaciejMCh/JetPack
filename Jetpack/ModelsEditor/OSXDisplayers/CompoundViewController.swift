//
//  CompoundViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Cocoa

class CompoundViewController: EditorViewController {
    static func withComponents(components: [NSViewController]) -> CompoundViewController {
        let controller = NSStoryboard(name: "CompoundViewController", bundle: nil).instantiateInitialController() as! CompoundViewController
        controller.components = components
        return controller
    }
    
    @IBOutlet weak var stackView: NSStackView!
    
    var components: [NSViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for component in components {
            if let editor = component as? EditorViewController {
                editor.nestingLevel = nestingLevel
            }
            stackView.addView(component.view, in: .center)
        }
        view.layer?.backgroundColor = NSColor.red.cgColor
    }
    
    override func setupLeadingMarginConstraint() {
//        leadingMarginConstraint.constant = CGFloat(10) * CGFloat(nestingLevel)
    }
    
}
