//
//  ICommand.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 24/07/2021.
//

import ReactiveKit
import Bond

public protocol ICommand {
    func Execute() -> Void
    func setAction(_ action: @escaping () -> Void ) -> Void
}

class Command : ICommand{
    private var action : () -> Void
    init(action : @escaping () -> Void){
        self.action = action
    }
    
    init(){
        self.action = {}
    }
    
    func Execute() -> Void {
        self.action()
    }
    
    func setAction(_ action: @escaping () -> Void ) -> Void{
        self.action = action
    }
}

extension ReactiveExtensions where Base: UIButton{
    public func Command(_ command: ICommand) -> Void {
        _ = tap
          .observeNext {
            command.Execute()
          }
    }
    
    public var titleColor: Bond<UIColor?> {
        return bond {
            $0.setTitleColor($1, for: .normal)
        }
    }
}
