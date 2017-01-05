//
//  ShaderLabViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 04.01.2017.
//  Copyright © 2017 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Cocoa

class MapViewController: NSViewController {
    @IBOutlet weak var scrollViewContainer: NSView!
    var mapSpots: [MapSpotViewController] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tryit()
    }
    
    
    func tryit() {
        let c = MapSpotViewController.instantiate()
        mapSpots.append(c)
        let v = c.view
        scrollViewContainer.addSubview(v)
        v.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        v.layer!.backgroundColor = NSColor.red.cgColor
    }
}

class MapSpotViewController: NSViewController, StoryboardInstance {
    static var storyboardName = "ShaderLab"
    static var storyboardIdentifier = "MapSpot"
    
    var dragInitialPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer?.backgroundColor = NSColor.red.cgColor
        view.addGestureRecognizer(NSPanGestureRecognizer(target: self, action: #selector(dragAction)))
    }
    
    func dragAction(panGestureRecognizer: NSPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: view.superview)
        
        switch panGestureRecognizer.state {
        case .began: dragInitialPoint = CGPoint(x: translation.x + view.frame.origin.x, y: translation.y + view.frame.origin.y)
        case .changed:
            let origin = dragInitialPoint
            view.frame = CGRect(origin: CGPoint(x: origin.x + translation.x, y: origin.y + translation.y), size: view.frame.size)
        default: break
        }
    }
}
