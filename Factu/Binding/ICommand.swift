//
//  ICommand.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 24/07/2021.
//

import ReactiveKit
import Bond
import UIKit

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

class BindableTableViewCell : UITableViewCell {
    let control : UIControl = UIControl()
    
    
    override var isSelected: Bool
    {
        didSet {
            valueChanged()
        }
    }
}

extension BindableTableViewCell {
    @objc fileprivate func valueChanged() {
        control.sendActions(for: .valueChanged)
    }
}
extension ReactiveExtensions where Base : BindableTableViewCell {
    
    var isSelected: DynamicSubject<Bool> {
            return dynamicSubject(
                signal: controlEventsForValueChanged().eraseType(),
                get: { $0.isSelected },
                set: { $0.isSelected = $1 }
            )
        }
    
    func controlEventsForValueChanged() -> SafeSignal<Void> {
        let base = self.base
        return Signal { [weak base] observer in
            guard let base = base else {
                observer.receive(completion: .finished)
                return NonDisposable.instance
            }
            let target = BNDControlTarget(control: base.control, events: UIControl.Event.valueChanged) {
                observer.receive(())
            }
            return MainBlockDisposable {
                target.unregister()
            }
        }.prefix(untilOutputFrom: base.deallocated)
    }
}

@objc fileprivate class BNDControlTarget: NSObject
{
    private weak var control: UIControl?
    private let observer: () -> Void
    private let events: UIControl.Event

    fileprivate init(control: UIControl, events: UIControl.Event, observer: @escaping () -> Void) {
        self.control = control
        self.events = events
        self.observer = observer

        super.init()
        control.addTarget(self, action: #selector(actionHandler), for: events)
    }

    @objc private func actionHandler() {
        observer()
    }

    fileprivate func unregister() {
        control?.removeTarget(self, action: nil, for: events)
    }

    deinit {
        unregister()
    }
}
