//
//  Attribute.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public enum AttributeFace {
    case Position
    case Texel
    case Normal
    
    public func size() -> Int {
        switch self {
        case .Position: return 3
        case .Texel: return 2
        case .Normal: return 3
        }
    }
    
    func name() -> String {
        switch self {
        case .Position: return "position"
        case .Texel: return "texel"
        case .Normal: return "normal"
        }
    }
}

public struct AttributeInterface {
    public let attributes: [AttributeFace]
    
    public init(attributes: [AttributeFace]) {
        self.attributes = attributes
    }
    
    func conformsToInterface(attributeInterface: AttributeInterface) -> Bool {
        return attributes == attributeInterface.attributes
    }
}
