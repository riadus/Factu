//
//  RangeExtensions.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 18/08/2021.
//

import Foundation
import RealmSwift
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

extension Array where Element: Any{
    func toList<T>() -> List<T>{
        let result : List<T> = List<T>()
        for element in self {
            result.append(element as! T)
        }
        return result
    }
}
