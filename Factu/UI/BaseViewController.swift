//
//  BaseViewController.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 23/07/2021.
//

import UIKit

class BaseViewController<T : IBaseViewModel> : UIViewController
{
    @Inject var bindingContext : T
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        if(bindingContext.back != ""){
            navigationItem.backBarButtonItem = UIBarButtonItem(title: bindingContext.back, style: .plain, target: nil, action: nil)
        }
    }
    
    func bindViewModel() -> Void{
        bindingContext.title.bind(to : navigationItem.reactive.title)
    }
}
