//
//  RepositoryAssembly.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 25/08/2021.
//

import Foundation

struct RepositoryAssembly : DIPart {
    
    var body: some DIPart {
            DIRegister(Repository.init)
                    .as(RepositoryProtocol.self)
    }
}
