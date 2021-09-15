//
//  EditItemViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 15/09/2021.
//

import Foundation
import Bond

protocol EditItemViewModel {
    var saveCommand : ICommand! { get }
    var deleteCommand : ICommand! { get }
    var canDelete : Observable<Bool>! { get }
}
