//
//  TimeSheetViewController.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 21/07/2021.
//

import UIKit
import Bond

class TimesheetViewController : BaseViewController<TimesheetViewModel> {
    
    @IBOutlet weak var assignmentButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var calendarLabel: UILabel!
    @IBOutlet weak var assignmentLabel: UILabel!
    @IBOutlet weak var timesheetLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var generateInvoiceButton: UIButton!
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet weak var assignmentContainer: UIView!
    @IBOutlet weak var assignmentContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarView: CalendarView!
    
    private let titleContainerSize :CGFloat = 60
    private var _assignmentClosed : Bool = true
    private var _calendarClosed : Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        closeAssignment()
        closeCalendar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarView.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.loadView()
        calendarButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        assignmentButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
    }
    
    @IBAction func assignmentButtonTapped(_ sender: Any) {
        if(self._assignmentClosed){
            self.openAssignment()
        }else{
            self.closeAssignment()
        }
        UIView.animate(withDuration: 0.5, animations:{
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func calendarButtonTapped(_ sender: Any) {
        if(self._calendarClosed){
            self.openCalendar()
        } else {
            self.closeCalendar()
        }
        UIView.animate(withDuration: 0.5, animations:{
            self.view.layoutIfNeeded()
        })
    }
    
    override func bindViewModel() {
        self.calendarView.setViewModel(bindingContext: bindingContext.calendarViewModel)
        bindingContext.timesheetText.bind(to: timesheetLabel.reactive.text)
        bindingContext.assignmentText.bind(to: assignmentLabel.reactive.text)
        bindingContext.calendarText.bind(to: calendarLabel.reactive.text)
        bindingContext.saveText.bind(to: saveButton.reactive.title)
        bindingContext.generateInvoiceText.bind(to : generateInvoiceButton.reactive.title)
        saveButton.reactive.Command(bindingContext.saveCommand)
        generateInvoiceButton.reactive.Command(bindingContext.generateInvoiceCommand)
    }
    
    func closeAssignment() -> Void {
        UIView.animate(withDuration: 0.5, animations:{
                        self.assignmentButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4)})
        _assignmentClosed = true
        self.assignmentContainerConstraint.constant = titleContainerSize
    }
    
    func closeCalendar() -> Void {
        UIView.animate(withDuration: 0.5, animations:{
            self.calendarButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 4)
        })
        _calendarClosed = true
        self.calendarContainerConstraint.constant = titleContainerSize
    }
    
    func openAssignment() -> Void {
        UIView.animate(withDuration: 0.5, animations:{
                        self.assignmentButton.transform = CGAffineTransform(rotationAngle: 0)})
        closeCalendar()
        _assignmentClosed = false
        assignmentContainerConstraint.constant = saveButton.frame.minY - titleContainerSize - assignmentContainer.frame.minY
        
    }
    
    func openCalendar() -> Void {
        UIView.animate(withDuration: 0.5, animations:{
            self.calendarButton.transform = CGAffineTransform(rotationAngle: 0)
        })
        closeAssignment()
        _calendarClosed = false
        calendarContainerConstraint.constant = saveButton.frame.minY - titleContainerSize - assignmentContainer.frame.minY
    }
}
