//
//  EditViewController.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 13/09/2021.
//

import UIKit

class EditViewController: BaseViewController<EditViewModel> {
        
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var navigationEditTagret : NavigationEditTagret!
        func setTarget(target : NavigationEditTagret){
            navigationEditTagret = target
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            switch self.navigationEditTagret {
            case .consulant:
                loadView(view: ConsultantView(frame : containerView.bounds), viewModel: bindingContext.editItemViewModel)
                    break
            case .client:
                loadView(view: CompanyView(frame : containerView.bounds), viewModel: bindingContext.editItemViewModel)
                    break
            case .project :
                loadView(view: ProjectView(frame : containerView.bounds), viewModel: bindingContext.editItemViewModel)
                    break
                default:
                    return
            }
        }
    
    
    func loadView(view : BaseSettingItemView, viewModel : EditItemViewModel) -> Void {
        view.setViewModel(bindingContext: viewModel)
        containerView.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
           let leftConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
           let topConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
           let rightConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
           let bottomConstraint = NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        containerView.addConstraints([leftConstraint, topConstraint, rightConstraint, bottomConstraint])
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        saveButton.reactive.Command(self.bindingContext.editItemViewModel.saveCommand)
        deleteButton.reactive.Command(self.bindingContext.editItemViewModel.deleteCommand)
        
        self.bindingContext.editItemViewModel.canDelete.bind(to : deleteButton.reactive.isEnabled)
        self.bindingContext.editItemViewModel.canDelete.map{ $0 ? UIColor.white : UIColor.gray }.bind(to : deleteButton.reactive.titleColor)
    }
}

extension EditViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }

    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}
