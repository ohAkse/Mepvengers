//
//  Array.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/07/29.
//

import Foundation
import UIKit

class WeakReference<T: AnyObject> {
    weak var value: T?
    
    init(object: T) {
        self.value = object
    }
}

extension Array where Element: AnyObject {
    mutating func addWeakReference(_ object: Element) {
        if let value = WeakReference(object: object).value {
            self.append(value)
        }
    }
}
