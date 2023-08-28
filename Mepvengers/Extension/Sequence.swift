//
//  Sequence.swift
//  Mepvengers
//
//  Created by 박유경 on 2023/08/03.
//

import Foundation
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
