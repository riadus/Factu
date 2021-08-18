//
//  RangeExtensions.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 18/08/2021.
//

import Foundation

extension Range{
    func select<T>(action: (_ i: Int) -> T ,  defaultValue: T) -> [T] where Bound == Int
    {
        var result : [T] = [T](repeating: defaultValue, count: self.count)
        for index in self {
            result[index] = action(index)
        }
        return result
    }
}
