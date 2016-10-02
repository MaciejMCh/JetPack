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
        let nodeDisplayables = Node().properties.map{root.editingDisplayer(editableProperty: $0)}
        let compound = root.compoundDisplayer(displayers: nodeDisplayables as! [Displayer])
        display(displayer: compound)
    }
}
