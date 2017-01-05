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
        return NSStoryboard(name: Self.storyboardName, bundle: nil).instantiateController(withIdentifier: Self.storyboardIdentifier) as! Self
    }
}

class ScopeViewController: NSViewController {
    @IBOutlet weak var stackView: NSStackView!
    
    var scope: Scope!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        stackView.removeFromSuperview()
//        view.layer?.backgroundColor = CGColor.init(red: 1, green: 0, blue: 0, alpha: 1)
//        stackView.addView(VariableView.instantiate(), in: .bottom)
    }
}

extension ScopeViewController: StoryboardInstance {
    static let storyboardIdentifier = "Scope"
    static let storyboardName = "ShaderLab"
}

class VariableView: NSView {
    static func instantiate() {
        let me = VariableView()
        me.setupView()
    }
    
    let variableNameLabel = NSTextField()
    let variableTypeLabel = NSTextField()
    
    var variableName: String!
    var variableType: Primitive!
    
//    init(variableName: String!, variableType: Primitive!) {
//        super.init(coder: NSCoder())!
//        self.variableName = variableName
//        self.variableType = variableType
//        setupView()
//    }
    
    func setupView() {
        layer?.backgroundColor = CGColor.init(red: 1, green: 0, blue: 0, alpha: 1)
    }
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
}
