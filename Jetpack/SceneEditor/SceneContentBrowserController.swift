//
//  SceneContentController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 06.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Cocoa

enum SceeneContentBrowserOutput {
    case selectedNode(node: Node)
}


protocol SceeneContentBrowserInput {
    func passToInput(output: SceeneContentBrowserOutput)
}


class SceneContentBrowserController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    var scene = Scene.mocked()
    
    var output: SceeneContentBrowserInput?
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return scene.nodes.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.make(withIdentifier: "cell", owner: nil) as! NodeTableViewCell
        let node = scene.nodes[row]
        cell.titleLabel.stringValue = node.identity.value
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let tableView = notification.object as! NSTableView
        let selectedRow = tableView.selectedRow
        let selectedNode = scene.nodes[selectedRow]
        output?.passToInput(output: .selectedNode(node: selectedNode))
    }
}


class NodeTableViewCell: NSTableCellView {
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var iconImageView: NSImageView!
}
