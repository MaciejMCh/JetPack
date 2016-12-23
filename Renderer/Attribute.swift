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
}

public struct Attribute: Equatable, Hashable {
    let attributeFace: AttributeFace
    public let hashValue: Int
    
    init(attributeFace: AttributeFace) {
        self.attributeFace = attributeFace
        self.hashValue = attributeFace.hashValue
    }
    
    public static func ==(lhs: Attribute, rhs: Attribute) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

public struct AttributeInterface {
    public let attributes: [AttributeFace]
    
    func conformsToInterface(attributeInterface: AttributeInterface) -> Bool {
        return attributes == attributeInterface.attributes
    }
}
