//
//  ViewExtensions.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 27/07/2021.
//

import UIKit
import Bond
import ReactiveKit

extension UIView {
    
    func moveToBottomOf(_ view : UIView) -> Void {
        self.frame = CGRect(x: self.frame.minX, y: view.frame.minY + view.frame.height, width: self.frame.width, height: self.frame.height)
    }
    
    func moveToTopOf(_ view : UIView) -> Void {
        self.frame = CGRect(x: self.frame.minX, y: view.frame.minY - self.frame.height, width: self.frame.width, height: self.frame.height)
    }
    
    func changeSizeOfFrame(width : CGFloat, height: CGFloat) -> Void {
        self.frame = CGRect(x : self.frame.minX, y : self.frame.minY, width: width, height: height)
    }
}

extension UITextField {
        class func connectFields(fields:[UITextField]) -> Void {
            guard let last = fields.last else {
                return
            }
            for i in 0 ..< fields.count - 1 {
                fields[i].returnKeyType = .next
                fields[i].addTarget(fields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
            }
            last.returnKeyType = .done
            last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
        }
    }
