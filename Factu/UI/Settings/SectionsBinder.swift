//
//  AssignmentBinder.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 11/09/2021.
//

import Foundation
import Bond

class SectionsBinder<Changeset: SectionedDataSourceChangeset>: TableViewBinderDataSource<Changeset>, UITableViewDelegate where Changeset.Collection == SectionsArray2D {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Section") as! SettingSectionViewCell
        let isOpen = self.changeset!.collection[sectionAt: section].metadata.isOpened.value
        let factor = CGFloat(isOpen == true ? 0 : -1)
        cell.openCloseImage.transform = CGAffineTransform(rotationAngle: factor * CGFloat.pi / 4)
        self.changeset!.collection[sectionAt: section].metadata.title.bind(to : cell.sectionTitle)
        cell.setTapAction {
            self.changeset!.collection[sectionAt: section].metadata.openCloseCommand.Execute()
            let factor = CGFloat(!isOpen ? 0 : -1)
            UIView.animate(withDuration: 0.3, animations: {
                cell.openCloseImage.transform = CGAffineTransform(rotationAngle: factor * CGFloat.pi / 4)
            })
            tableView.reloadSections(IndexSet([section]), with: .none)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(changeset?.collection[sectionAt: indexPath.section].metadata.isOpened.value == true)
        {
            return UITableView.automaticDimension
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
}
