//
//  Enviroment.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

struct Enviroment {
    let processingUnions: [ProcessingUnion]
    
    func pass() {
        for processingUnion in processingUnions {
            processingUnion.update()
        }
    }
}
