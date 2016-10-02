//
//  OptionsEditorViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 02.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Cocoa

class OptionsEditorViewController: NSViewController {
    
    static func with(optionProperty: OptionEditableProperty) -> OptionsEditorViewController {
        let controller = NSStoryboard(name: "OptionsEditorViewController", bundle: nil).instantiateInitialController() as! OptionsEditorViewController
        controller.optionEditableProperty = optionProperty
        return controller
    }
    
    @IBOutlet weak var propertyNameLabel: NSTextField!
    @IBOutlet weak var optionButton: NSPopUpButton!
    @IBOutlet weak var stackView: NSStackView!
    
    var optionEditableProperty: OptionEditableProperty!
    var displayingController: NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        propertyNameLabel.stringValue = optionEditableProperty.name
        setupPopupButton()
    }
    
    func setupPopupButton() {
        optionButton.removeAllItems()
        for option in optionEditableProperty.options {
            optionButton.addItem(withTitle: option.name)
        }
        popUpButtonChanged()
        optionButton.target = self
        optionButton.action = #selector(popUpButtonChanged)
    }
    
    func popUpButtonChanged() {
        if let displayingView = displayingController?.view {
            stackView.removeView(displayingView)
        }
        let controller = NSViewController().editingDisplayer(editableProperty: optionEditableProperty.options[optionButton.indexOfSelectedItem]) as! NSViewController
        displayingController = controller
        stackView.addView(controller.view, in: .center)
    }
}
