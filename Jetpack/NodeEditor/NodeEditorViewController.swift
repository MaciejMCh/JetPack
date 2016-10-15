//
//  NodeEditorViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 14.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Cocoa

class NodeEditorViewController: NSViewController {
    
    weak var currentlyPresentingViewController: NSViewController?
    
    func beginEditingNode(node: Node) {
        removeCurrentlyPresentingViewController()
        let modelProperty = ModelEditableProperty(name: "co to xD", model: node)
        let controller = NSViewController().editingDisplayer(editableProperty: modelProperty)
        presentNewViewController(viewController: controller as! NSViewController)
    }
    
    func removeCurrentlyPresentingViewController() {
        currentlyPresentingViewController?.removeFromParentViewController()
        currentlyPresentingViewController?.view.removeFromSuperview()
    }
    
    func presentNewViewController(viewController: NSViewController) {
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        view.frame = CGRect(origin: CGPoint(), size: view.frame.size)
        currentlyPresentingViewController = viewController
    }
}
