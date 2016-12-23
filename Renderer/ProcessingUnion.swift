//
//  ProcessingUnion.swift
//  Jetpack
//
//  Created by Maciej Chmielewski on 23.12.2016.
//  Copyright © 2016 Maciej Chmielewski. All rights reserved.
//

import Foundation

struct ProcessingUnion {
    private let updater: () -> ()
    
    init<T: Primitive>(primitiveGetter: @escaping () -> (T)) {
        updater = {PassFunction().pass(value: primitiveGetter())}
    }
    
    func update() {
        updater()
    }
}

struct PassFunction<T: Primitive> {
    func pass(value: T) {
        
    }
}
