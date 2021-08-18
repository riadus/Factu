//
//  TimeSheetViewController.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 21/07/2021.
//

import UIKit
import Bond

class TimesheetViewController : BaseViewController<TimesheetViewModel>, UICollectionViewDelegate {
    
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
    @IBOutlet weak var nextYearButton: UIButton!
    @IBOutlet weak var currentYearLabel: UILabel!
    @IBOutlet weak var previousYearButton: UIButton!
    @IBOutlet weak var monthsCollectionView: UICollectionView!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    
    private let titleContainerSize :CGFloat = 50
    private var _assignmentClosed : Bool = true
    private var _calendarClosed : Bool = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        closeAssignment()
        closeCalendar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToMonth()
        updateCalendarHeight()
    }
    
    func updateCalendarHeight() -> Void {
        calendarHeightConstraint.constant = daysCollectionView.contentSize.height
        daysCollectionView.layoutIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        assignmentButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        monthsCollectionView.register(UINib(nibName:"MonthViewCell", bundle: nil), forCellWithReuseIdentifier:"monthReuseIdentifier")
        
        let columnLayout = FlowLayout(
                cellsPerRow: 7
              
                //sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            )
        
        daysCollectionView.collectionViewLayout = columnLayout
        daysCollectionView?.contentInsetAdjustmentBehavior = .always
        
        daysCollectionView.register(UINib(nibName:"DayViewCell", bundle: nil), forCellWithReuseIdentifier:"dayReuseIdentifier")
        daysCollectionView.allowsMultipleSelection = true
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
        bindingContext.timesheetText.bind(to: timesheetLabel.reactive.text)
        bindingContext.assignmentText.bind(to: assignmentLabel.reactive.text)
        bindingContext.calendarText.bind(to: calendarLabel.reactive.text)
        bindingContext.saveText.bind(to: saveButton.reactive.title)
        bindingContext.generateInvoiceText.bind(to : generateInvoiceButton.reactive.title)
        generateInvoiceButton.reactive.Command(bindingContext.generateInvoiceCommand)
        
        // Calendar
        bindingContext.calendarViewModel.year.bind(to: currentYearLabel.reactive.text)
        bindingContext.calendarViewModel.nextYear.bind(to : nextYearButton.reactive.title)
        bindingContext.calendarViewModel.previousYear.bind(to : previousYearButton.reactive.title)
        nextYearButton.reactive.Command(bindingContext.calendarViewModel.nextYearCommand)
        previousYearButton.reactive.Command(bindingContext.calendarViewModel.previousYearCommand)
        
        bindingContext.calendarViewModel.months.bind(to : monthsCollectionView) { array, indexPath, collectionView in
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
        
        bindingContext.calendarViewModel.days.bind(to : daysCollectionView) { array, indexPath, collectionView in
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
        
        bindingContext.calendarViewModel.updateMonth(cell.bindingContext)
        scrollToMonth()
        updateCalendarHeight()
      }
    
    func scrollToMonth() -> Void {
        let index = bindingContext.calendarViewModel.month.value!.monthIndex
        let indexPath = IndexPath(item: index, section: 0)
        self.monthsCollectionView.scrollToItem( at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        self.setEditing(true, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        return true
    }
}

class FlowLayout : UICollectionViewFlowLayout{
        
    let cellsPerRow: Int

        init(cellsPerRow: Int, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
            self.cellsPerRow = cellsPerRow
            super.init()

            self.minimumInteritemSpacing = minimumInteritemSpacing
            self.minimumLineSpacing = minimumLineSpacing
            self.sectionInset = sectionInset
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
