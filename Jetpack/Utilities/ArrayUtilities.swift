//
//  ArrayUtilities.swift
//  Living Social
//
//  Created by Maciej Chmielewski on 25.08.2016.
//  Copyright © 2016 Northcliffe Digital. All rights reserved.
//

import Foundation


extension Array {
    func typeFiltered<T>() -> [T] {
        var filtered: [T] = []
        for element in self {
            if let elementWithType = element as? T {
                filtered.append(elementWithType)
            }
        }
        return filtered
    }
}


infix operator +
public func + <T>(lhs: Array<T>, rhs: Array<T>) -> Array<T> {
    var result: Array<T> = []
    result.append(contentsOf: lhs)
    result.append(contentsOf: rhs)
    return result
}


extension Array where Element : Collection {
    func stomp() -> [Element.Iterator.Element] {
        var result: [Element.Generator.Element] = []
        for element in self {
            result.append(contentsOf: element)
        }
        return result
    }
}


class WeakReference<T: AnyObject> {
    weak var reference: T?
    
    init(reference: T) {
        self.reference = reference
    }
}

class WeakReferencesArray<T: AnyObject> {
    private var weakReferencesArray: [WeakReference<T>] = []
    
    init(collection: [T]? = nil) {
        guard let collection = collection else {return}
        for element in collection {
            append(element: element)
        }
    }
    
    func append(element: T) {
        weakReferencesArray.append(WeakReference(reference: element))
    }
    
    func iterateUsingBlock(block: (T) -> ()) {
        weakReferencesArray = weakReferencesArray.filter{$0.reference != nil}
        for weakReference in weakReferencesArray {
            if let reference = weakReference.reference {
                block(reference)
            }
        }
    }
}

extension WeakReferencesArray where T: Equatable {
    func next(current: T) -> T? {
        var currentFound = false
        var nextElement: T? = nil
        iterateUsingBlock { (element) in
            if currentFound == true {
                nextElement = element
                currentFound = false
            }
            if current == element {
                currentFound = true
            }
        }
        return nextElement
    }
}
