//
//  NodeEditorViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 14.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Cocoa

class NodeEditorViewController: NSViewController {
    @IBOutlet weak var scrollView: NSScrollView!
    @IBOutlet weak var containerView: NSView!
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
        containerView.addSubview(viewController.view)
        currentlyPresentingViewController = viewController
        
        containerView.addConstraint(viewController.view.pinToParent(attribute: .top))
        containerView.addConstraint(viewController.view.pinToParent(attribute: .leading))
        containerView.addConstraint(viewController.view.pinToParent(attribute: .trailing))
    }
}

extension NSView {
    func pinToParent(attribute: NSLayoutAttribute) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self,
                                  attribute: attribute,
                                  relatedBy: .equal,
                                  toItem: superview,
                                  attribute: attribute,
                                  multiplier: 1,
                                  constant: 0)
    }
}
