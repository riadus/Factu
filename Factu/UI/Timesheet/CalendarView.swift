//
//  CalendarView.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 19/08/2021.
//

import UIKit
import Bond
import ReactiveKit

class CalendarView: UIScrollView, UICollectionViewDelegate {

    @IBOutlet weak var previousYearButton: UIButton!
    @IBOutlet weak var nextYearButton: UIButton!
    @IBOutlet weak var currentYearLabel: UILabel!
    @IBOutlet weak var monthsCollectionView: UICollectionView!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    var bindingContext : CalendarViewModel!
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            initSubviews()
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            initSubviews()
        }

        func initSubviews() {
            let view = Bundle.main.loadNibNamed("CalendarView", owner: self, options: nil)![0] as! UIView
            view.frame = self.bounds
            addSubview(view)
        }
    
    func loadView() -> Void {
        monthsCollectionView.register(UINib(nibName:"MonthViewCell", bundle: nil), forCellWithReuseIdentifier:"monthReuseIdentifier")
        
        let columnLayout = CalendarLayout()
        
        daysCollectionView.collectionViewLayout = columnLayout
        daysCollectionView?.contentInsetAdjustmentBehavior = .always
        
        daysCollectionView.register(UINib(nibName:"DayViewCell", bundle: nil), forCellWithReuseIdentifier:"dayReuseIdentifier")
        daysCollectionView.allowsMultipleSelection = true
    }
    
    func viewDidLayoutSubviews() {
        scrollToMonth()
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
            let day = array[indexPath.item]
            cell.bindingContext = day
            day.day.map{ String($0) }.bind(to: cell.dayLabel)
            cell.updateStyle()
            return cell
          }
        
        daysCollectionView.reactive.delegate.forwardTo = self
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
        return true
    }
}

class CalendarLayout : UICollectionViewFlowLayout{
        
    let cellsPerRow: Int

        override required init() {
            self.cellsPerRow = 7
            super.init()

            self.minimumInteritemSpacing = 0
            self.minimumLineSpacing = 0
            self.sectionInset = .zero
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func prepare() {
            super.prepare()

            guard let collectionView = collectionView else { return }
            let marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
            let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
            itemSize = CGSize(width: itemWidth, height: itemWidth)
        }

        override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
            let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
            context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
            return context
        }
}

