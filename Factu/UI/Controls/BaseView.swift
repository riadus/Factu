//
//  BaseView.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 16/09/2021.
//

import UIKit

class BaseView : UIView {
    
    var view : UIView!
    
    override init(frame:CGRect) {
       super.init(frame: frame)
       commonInit()
   }

   required init(coder aCoder: NSCoder) {
        super.init(coder: aCoder)!
        commonInit()
   }
    
    func commonInit() -> Void {
        view = self.loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
          
        return view
    }
}

public class BaseControl : UIControl {
    
    var view : UIView!
    
    override init(frame:CGRect) {
       super.init(frame: frame)
       commonInit()
   }

   required init(coder aCoder: NSCoder) {
        super.init(coder: aCoder)!
        commonInit()
   }
    
    func commonInit() -> Void {
        view = self.loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for:type(of: self))
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
          
        return view
    }
}
