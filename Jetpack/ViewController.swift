//
//  ViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    static var rootViewController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewController.rootViewController = self

        let root = NSViewController().rootDisplayer()
        let tagDisplay = root.tagPropertyEditorDisplayer(property: PrimitiveEditableProperty(name: "identifier", property: Tag(value: "node_0")))
        let vecDisplay = root.vec3PropertyEditorDisplayer(property: PrimitiveEditableProperty(name: "position", property: Vector3()))
        let compound = root.compoundDisplayer(displayers: [tagDisplay, vecDisplay])
        
        
        ModelEditableProperty(name: "node", model: Node())
        display(displayer: compound)
        
        view.layer?.backgroundColor = NSColor.red.cgColor
        
    }
}
