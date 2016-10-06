//
//  OptionsEditorViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 02.10.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Cocoa

class OptionsEditorViewController: EditorViewController {
    
    static func with(optionProperty: OptionEditableProperty) -> OptionsEditorViewController {
        let me = NSStoryboard(name: "OptionsEditorViewController", bundle: nil).instantiateInitialController() as! OptionsEditorViewController
        me.optionEditableProperty = optionProperty
        me.property = optionProperty
        return me
    }
    
    @IBOutlet weak var optionButton: NSPopUpButton!
    @IBOutlet weak var stackView: NSStackView!
    
    var optionEditableProperty: OptionEditableProperty!
    var displayingController: NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let controller = NSViewController().editingDisplayer(editableProperty: optionEditableProperty.options[optionButton.indexOfSelectedItem]) as! EditorViewController
        controller.nestingLevel = nestingLevel + 1
        displayingController = controller
        stackView.addView(controller.view, in: .center)
    }
}
