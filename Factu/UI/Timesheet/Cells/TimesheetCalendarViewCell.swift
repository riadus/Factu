//
//  TimesheetCalendarViewCell.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 20/09/2021.
//

import UIKit

class TimesheetCalendarViewCell: UITableViewCell {

    @IBOutlet weak var calendarView: CalendarView!
    
    func setViewModel(bindingContext : CalendarViewModel) -> Void {
        calendarView.setViewModel(bindingContext: bindingContext)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        calendarView.scrollToMonth()
    }
}
