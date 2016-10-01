//
//  CompoundViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Cocoa

class CompoundViewController: NSViewController {
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
            component.view.frame = NSRect(x: 0, y: 0, width: 100, height: 100)
            stackView.addView(component.view, in: .center)
        }
    }
    
}
