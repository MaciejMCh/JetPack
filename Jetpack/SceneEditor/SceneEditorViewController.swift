//
//  SceneEditorViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 01.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Cocoa

class SceneEditorViewController: NSSplitViewController {
    weak var sceneContentBrowserController: SceneContentBrowserController!
    weak var sceneViewerViewController: SceneViewerViewController!
    weak var nodeEditorViewController: NodeEditorViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneContentBrowserController = splitViewItems[0].viewController as! SceneContentBrowserController
        sceneContentBrowserController.output = self
        sceneViewerViewController = splitViewItems[1].viewController as! SceneViewerViewController
        nodeEditorViewController = splitViewItems[2].viewController as! NodeEditorViewController
    }
}


extension SceneEditorViewController: SceeneContentBrowserInput {
    func passToInput(output: SceeneContentBrowserOutput) {
        switch output {
        case .selectedNode(let node): nodeEditorViewController.beginEditingNode(node: node)
        }
    }
}
