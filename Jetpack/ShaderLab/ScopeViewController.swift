//
//  ScopeViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 04.01.2017.
//  Copyright © 2017 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Cocoa
import CoreModel

protocol StoryboardInstance {
    static var storyboardIdentifier: String {get}
    static var storyboardName: String {get}
}

extension StoryboardInstance where Self: NSViewController {
    static func instantiate() -> Self {
        let storyboard = NSStoryboard(name: Self.storyboardName, bundle: nil)
        let controller = storyboard.instantiateController(withIdentifier: Self.storyboardIdentifier) as! Self
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }
}

class ScopeViewController: NSViewController {
    @IBOutlet weak var stackView: NSStackView!
    
    var scope: Scope! = Scopes.lambertFactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer!.borderWidth = 1
        view.layer!.borderColor = NSColor.black.cgColor
        
        for instruction in scope.instructions {
            for variable in instruction.variablesUsed() {
                let variableView = VariableView.instantiate()
                variableView.nameLabel.stringValue = variable.name
                variableView.typeLabel.stringValue = variable.type.name
                stackView.addView(variableView, in: .bottom)
            }
        }
    }
}

extension ScopeViewController: StoryboardInstance {
    static let storyboardIdentifier = "Scope"
    static let storyboardName = "ShaderLab"
}

class VariableView: NSView {
    static func instantiate() -> VariableView {
        let storyboard = NSStoryboard(name: "ShaderLab", bundle: nil)
        let controller = storyboard.instantiateController(withIdentifier: "Variable") as! NSViewController
        let view = controller.view as! VariableView
        return view
    }
    
    @IBOutlet weak var nameLabel: NSTextField!
    @IBOutlet weak var typeLabel: NSTextField!
}

class ViewLoaderController: NSViewController {}
