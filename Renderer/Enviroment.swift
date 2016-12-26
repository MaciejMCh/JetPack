//
//  Enviroment.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

public struct Enviroment {
    let processingUnions: [ProcessingUnion]
    
    public init(processingUnions: [ProcessingUnion]) {
        self.processingUnions = processingUnions
    }
    
    func pass() {
        for processingUnion in processingUnions {
            processingUnion.update()
        }
    }
}
