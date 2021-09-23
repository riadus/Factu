//
//  HomeViewModel.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 21/07/2021.
//

import Foundation
import Bond

class HomeViewModel : IBaseViewModel{
    let back = "Back"
    let title = Observable<String>("Factu")
    let timesheetText = Observable<String>("Timesheet")
    let settingsText = Observable<String>("Settings")
    let archivedText = Observable<String>("Archived")
    var timesheetCommand : ICommand!
    var settingsCommand : ICommand!
    var archiveCommand : ICommand!
    
    @Inject var coordinator : ICoordinator
    
    required init(){
        timesheetText.value = timesheetText.value.uppercased()
        settingsText.value = settingsText.value.uppercased()
        archivedText.value = archivedText.value.uppercased()
        timesheetCommand = Command(action: navigateToTimesheet)
        settingsCommand = Command(action: navigateToSettings)
        archiveCommand = Command(action: navigateToArchives)
    }
    
    private func navigateToTimesheet() -> Void{
        coordinator.toTimesheet()
    }
    
    private func navigateToSettings() -> Void {
        coordinator.toSettings()
    }
    
    private func navigateToArchives() -> Void {
        coordinator.toArchives()
    }
}
