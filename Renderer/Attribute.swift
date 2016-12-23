//
//  Attribute.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 22.11.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public enum Attribute {
    case Position
    case Texel
    case Normal
    
    public func size() -> UInt {
        switch self {
        case .Position: return 3
        case .Texel: return 2
        case .Normal: return 3
        }
    }
}
