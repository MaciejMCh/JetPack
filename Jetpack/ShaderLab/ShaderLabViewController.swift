//
//  ShaderLabViewController.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 04.01.2017.
//  Copyright © 2017 Maciej Chmielewski. All rights reserved.
//

import Foundation
import Cocoa

class MapEntity {
    var controller: NSViewController
    var position: CGPoint
    
    init(controller: NSViewController, position: CGPoint = CGPoint.zero) {
        self.controller = controller
        self.position = position
    }
}

class MapViewController: NSViewController {
    @IBOutlet weak var scrollViewContainer: NSView!
    var mapEntities: [MapEntity] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tryit()
    }
    
    
    func tryit() {
        let c = MapSpotViewController.instantiate()
        addMapEntity(controller: c)
        
        let v = c.view
        v.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        v.layer!.backgroundColor = NSColor.red.cgColor
    }
    
    func addMapEntity(controller: NSViewController) {
        scrollViewContainer.addSubview(controller.view)
        controller.view.addGestureRecognizer(NSPanGestureRecognizer(target: self, action: #selector(dragAction)))
        
        let mapEntity = MapEntity(controller: controller)
        mapEntities.append(mapEntity)
        updateMapEntityView(mapEntity: mapEntity)
    }
    
    func updateMapEntityView(mapEntity: MapEntity) {
        var frame = mapEntity.controller.view.frame
        frame.origin = mapEntity.position
        mapEntity.controller.view.frame = frame
    }
    
    func updateMapSize() {
        let contentWidth = mapEntities.map{$0.controller.view.frame.maxX}.sorted().last ?? 0.0
        let contentHeight = mapEntities.map{$0.controller.view.frame.maxY}.last ?? 0.0
        
        let width = max(view.frame.width, contentWidth)
        let height = max(view.frame.height, contentHeight)
        
        scrollViewContainer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    private func mapEntityFromView(view: NSView) -> MapEntity? {
        for mapEntity in mapEntities {
            if mapEntity.controller.view == view {
                return mapEntity
            }
        }
        return nil
    }
    
    func dragAction(panGestureRecognizer: NSPanGestureRecognizer) {
        guard let mapEntity = mapEntityFromView(view: panGestureRecognizer.view!) else {return}
        let mapEntityView = mapEntity.controller.view
        let translation = panGestureRecognizer.translation(in: view.superview)
        
        switch panGestureRecognizer.state {
        case .changed:
            let origin = mapEntity.position
            mapEntityView.frame = CGRect(origin: CGPoint(x: origin.x + translation.x, y: origin.y + translation.y), size: mapEntityView.frame.size)
        case .ended:
            mapEntity.position = mapEntityView.frame.origin
            updateMapEntityView(mapEntity: mapEntity)
            updateMapSize()
        default: break
        }
    }
    
}

class MapSpotViewController: NSViewController, StoryboardInstance {
    static var storyboardName = "ShaderLab"
    static var storyboardIdentifier = "MapSpot"
}
