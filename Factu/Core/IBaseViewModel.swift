//
//  IBaseViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import Bond

protocol IBaseViewModel {
    init()
    var title : Observable<String> { get }
    var back : String { get }
}
