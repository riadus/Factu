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
        setupHideKeyboardOnTap()
        bindViewModel()
        if(bindingContext.back != ""){
            navigationItem.backBarButtonItem = UIBarButtonItem(title: bindingContext.back, style: .plain, target: nil, action: nil)
        }
    }
    
    func bindViewModel() -> Void{
        bindingContext.title.bind(to : navigationItem.reactive.title)
    }
}

extension UIViewController {
    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
