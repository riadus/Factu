//
//  CalendarView.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 19/08/2021.
//

import UIKit
import Bond
import ReactiveKit

class CalendarView: BaseView, UICollectionViewDelegate {

    @IBOutlet weak var previousYearButton: UIButton!
    @IBOutlet weak var nextYearButton: UIButton!
    @IBOutlet weak var currentYearLabel: UILabel!
    @IBOutlet weak var monthsCollectionView: UICollectionView!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    @IBOutlet weak var numberOfDaysLabel: UILabel!
    @IBOutlet weak var numberOfDays: UILabel!
    
    var bindingContext : CalendarViewModel!
    var isEditingMode = false
    
    override func commonInit() {
        super.commonInit()
        loadView()
    }
    
    func loadView() -> Void {
        monthsCollectionView.register(UINib(nibName:"MonthViewCell", bundle: nil), forCellWithReuseIdentifier:"monthReuseIdentifier")
        
        let columnLayout = CalendarLayout()
        
        daysCollectionView.collectionViewLayout = columnLayout
        daysCollectionView?.contentInsetAdjustmentBehavior = .always
        
        daysCollectionView.register(UINib(nibName:"DayViewCell", bundle: nil), forCellWithReuseIdentifier:"dayReuseIdentifier")
        daysCollectionView.allowsMultipleSelection = true
    }
    
    func updateCalendarHeight() -> Void {
        daysCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setViewModel(bindingContext : CalendarViewModel) -> Void {
        self.bindingContext = bindingContext
        bindViewModel()
    }
    
    func bindViewModel() -> Void {
        bindingContext.year.bind(to: currentYearLabel.reactive.text)
        bindingContext.nextYear.bind(to : nextYearButton.reactive.title)
        bindingContext.previousYear.bind(to : previousYearButton.reactive.title)
        nextYearButton.reactive.Command(bindingContext.nextYearCommand)
        previousYearButton.reactive.Command(bindingContext.previousYearCommand)
        bindingContext.numberOfDaysText.bind(to : numberOfDaysLabel.reactive.text)
        bindingContext.numberOfDays.map { NSDecimalNumber(decimal : $0).stringValue }.bind(to : numberOfDays.reactive.text)
        
        bindingContext.months.bind(to : monthsCollectionView) { array, indexPath, collectionView in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthReuseIdentifier", for: indexPath) as! MonthViewCell
            let month = array[indexPath.item]
            cell.bindingContext = month
            month.monthText.bind(to : cell.monthLabel)
            month.isSelected
                .map { $0 ? UIColor(named: "Pink") : UIColor.white}
                .bind(to: cell.reactive.backgroundColor)
            month.isSelected
                .map{ $0 ? UIColor.white : UIColor.black}
                .bind(to: cell.monthLabel.reactive.textColor)

            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.selectMonth(_:))))
            return cell
          }
        
        bindingContext.days.bind(to : daysCollectionView) { array, indexPath, collectionView in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayReuseIdentifier", for: indexPath) as! DayViewCell
            if(array.count <= indexPath.item) {
                return UICollectionViewCell.init()
            }
            let day = array[indexPath.item]
            cell.bindingContext = day
            day.day.map{ String($0) }.bind(to: cell.dayLabel)
            cell.updateStyle()
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.dayLongPressed))
            let tapRecognizer = UITapGestureRecognizer(target : self, action: #selector(self.dayTapped))
            cell.addGestureRecognizer(longPressRecognizer)
            cell.addGestureRecognizer(tapRecognizer)
           
            return cell
          }
        
        daysCollectionView.reactive.delegate.forwardTo = self
    }
    
    @objc func dayLongPressed(sender: UILongPressGestureRecognizer) {
        if(sender.state == UIGestureRecognizer.State.began){
            let tapLocation = sender.location(in: self.daysCollectionView)
            let indexPath = self.daysCollectionView.indexPathForItem(at: tapLocation)
            let cell = self.daysCollectionView.cellForItem(at: indexPath!)
            guard let dayCell = cell as? DayViewCell else { return }
            dayCell.bindingContext!.longPressed()
            dayCell.updateStyle()
        }
    }
    
    @objc func dayTapped(sender: UITapGestureRecognizer) {
        if(self.isEditingMode) {
            return
        }
       let tapLocation = sender.location(in: self.daysCollectionView)
        let indexPath = self.daysCollectionView.indexPathForItem(at: tapLocation)
        let cell = self.daysCollectionView.cellForItem(at: indexPath!)
        guard let dayCell = cell as? DayViewCell else { return }
        dayCell.bindingContext!.tapped()
        dayCell.updateStyle()
    }
    
    @objc func selectMonth(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: self.monthsCollectionView)
        let indexPath = self.monthsCollectionView.indexPathForItem(at: tapLocation)
        let cell = self.monthsCollectionView.cellForItem(at: indexPath!)as! MonthViewCell
        
        bindingContext.updateMonth(cell.bindingContext)
        scrollToMonth()
        updateCalendarHeight()
      }
    
    func scrollToMonth() -> Void {
        let index = bindingContext.month.value!.monthIndex
        let indexPath = IndexPath(item: index, section: 0)
        self.monthsCollectionView.scrollToItem( at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        self.isEditingMode = true
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let dayCell = cell as? DayViewCell else { return }
        dayCell.isSelected = dayCell.bindingContext!.isSelected
    }
}

class CalendarLayout : UICollectionViewFlowLayout{
        
    let cellsPerRow: Int

        override required init() {
            self.cellsPerRow = 7
            super.init()

            self.minimumInteritemSpacing = 0
            self.minimumLineSpacing = 1
            self.sectionInset = .zero
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func prepare() {
            super.prepare()

            guard let collectionView = collectionView else { return }
        
            let itemWidth = (collectionView.bounds.size.width / CGFloat(cellsPerRow)).rounded(.down)
            itemSize = CGSize(width: itemWidth, height: itemWidth)
        }

        override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
            let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
            context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
            return context
        }
}

