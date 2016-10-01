//
//  ViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = TagEditorViewController.withTagProperty(tagProperty: PrimitiveEditableProperty(name: "identifier", property: Tag(value: "node_0")))
        view.addSubview(controller.view)
        controller.view.frame = view.frame
        addChildViewController(controller)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

