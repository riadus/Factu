//
//  InvoiceViewController.swift
//  Factu
//
//  Created by Riad Lakehal-Ayat on 01/09/2021.
//

import UIKit

class InvoiceViewController: BaseViewController<InvoiceViewModel>, UIDocumentInteractionControllerDelegate {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var companyAddressLabel: UILabel!
    @IBOutlet weak var companyPostalCodeLabel: UILabel!
    @IBOutlet weak var companyCountryLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var clientAddressLabel: UILabel!
    @IBOutlet weak var clientPostalCodeLabel: UILabel!
    @IBOutlet weak var clientCountryName: UILabel!
    @IBOutlet weak var invoiceLabel: UILabel!
    @IBOutlet weak var invoiceDateValueLabel: UILabel!
    @IBOutlet weak var invoiceDateLabel: UILabel!
    @IBOutlet weak var paymentDateValueLabel: UILabel!
    @IBOutlet weak var paymentDateLabel: UILabel!
    @IBOutlet weak var invoiceNumberValueLabel: UILabel!
    @IBOutlet weak var invoiceNumberLabel: UILabel!
    @IBOutlet weak var vatNumberValueLabel: UILabel!
    @IBOutlet weak var vatNumberLabel: UILabel!
    @IBOutlet weak var kvkValueLabel: UILabel!
    @IBOutlet weak var kvkLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionValueLabel: UILabel!
    @IBOutlet weak var quantityValueLabel: UILabel!
    @IBOutlet weak var unitValueLabel: UILabel!
    @IBOutlet weak var rateValueLabel: UILabel!
    @IBOutlet weak var amountValueLabel: UILabel!
    @IBOutlet weak var extraDescriptionValueLabel: UILabel!
    @IBOutlet weak var totalExcludingValueLabel: UILabel!
    @IBOutlet weak var totalExcludingLabel: UILabel!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var vatValueLabel: UILabel!
    @IBOutlet weak var totalIncludingValueLabel: UILabel!
    @IBOutlet weak var totalIncludingLabel: UILabel!
    @IBOutlet weak var legalMentionLabel: UILabel!
    @IBOutlet weak var invoiceNumberButton: UIButton!
    @IBOutlet weak var generatePdfButton: UIButton!
    
    @IBOutlet weak var BicValue: UILabel!
    @IBOutlet weak var IbanValue: UILabel!
    
    @IBAction func showPDFPressed(_ sender: Any) {
        let data = getOutputData(withView: scrollView.subviews[0])
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(bindingContext.getFileName())
        try! data.write(to: url, options: .atomicWrite)
        
        let documentInteractionController = UIDocumentInteractionController(url: url)
        documentInteractionController.delegate = self
        documentInteractionController.presentPreview(animated: true)
    }
    
    func getOutputData(withView view: UIView) -> NSData {

        let pdfWidth : CGFloat = 792
        let pdfHeight : CGFloat = 1122
        let marginY : CGFloat = 100
        let xScale = pdfWidth / view.bounds.width
        let yScale = pdfHeight / view.bounds.height
        let scale = xScale < yScale ? xScale : yScale;
        
        let pdfX = (pdfWidth - (view.bounds.width * scale)) / 2
        let pdfY = marginY
        
        let pageDimensions = CGRect(x: 0, y: 0, width: pdfWidth, height: pdfHeight)
        
        let outputData = NSMutableData()

        UIGraphicsBeginPDFContextToData(outputData, pageDimensions, nil)
        if let context = UIGraphicsGetCurrentContext() {
            UIGraphicsBeginPDFPage()
            context.translateBy(x: pdfX, y: pdfY)
            context.scaleBy(x: scale, y: scale)
            view.layer.render(in: context)
        }
        UIGraphicsEndPDFContext()

        return outputData
    }
    
    func getPath() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    override func bindViewModel() -> Void {
        super.bindViewModel()
        
        bindingContext.companyName.bind(to: companyNameLabel.reactive.text)
        bindingContext.companyAddress.bind(to: companyAddressLabel.reactive.text)
        bindingContext.companyPostalCode.bind(to: companyPostalCodeLabel.reactive.text)
        bindingContext.companyCountry.bind(to: companyCountryLabel.reactive.text)
        bindingContext.clientName.bind(to: clientNameLabel.reactive.text)
        bindingContext.clientAddress.bind(to: clientAddressLabel.reactive.text)
        bindingContext.clientPostalCode.bind(to: clientPostalCodeLabel.reactive.text)
        bindingContext.clientCountry.bind(to: clientCountryName.reactive.text)
        bindingContext.invoiceText.bind(to: invoiceLabel.reactive.text)
        bindingContext.invoiceDate.bind(to: invoiceDateValueLabel.reactive.text)
        bindingContext.invoiceDateText.bind(to: invoiceDateLabel.reactive.text)
        bindingContext.paymentDate.bind(to: paymentDateValueLabel.reactive.text)
        bindingContext.paymentDateText.bind(to: paymentDateLabel.reactive.text)
        bindingContext.invoiceNumber.bind(to: invoiceNumberValueLabel.reactive.text)
        bindingContext.invoiceNumberText.bind(to: invoiceNumberLabel.reactive.text)
        bindingContext.vatNumber.bind(to: vatNumberValueLabel.reactive.text)
        bindingContext.vatNumberText.bind(to: vatNumberLabel.reactive.text)
        bindingContext.kvk.bind(to: kvkValueLabel.reactive.text)
        bindingContext.kvkText.bind(to: kvkLabel.reactive.text)
        bindingContext.descriptionText.bind(to: descriptionLabel.reactive.text)
        bindingContext.quantityText.bind(to: quantityLabel.reactive.text)
        bindingContext.unitText.bind(to: unitLabel.reactive.text)
        bindingContext.rateText.bind(to: rateLabel.reactive.text)
        bindingContext.amountText.bind(to: amountLabel.reactive.text)
        bindingContext.description.bind(to: descriptionValueLabel.reactive.text)
        bindingContext.quantity.bind(to: quantityValueLabel.reactive.text)
        bindingContext.unit.bind(to: unitValueLabel.reactive.text)
        bindingContext.rate.bind(to: rateValueLabel.reactive.text)
        bindingContext.amount.bind(to: amountValueLabel.reactive.text)
        bindingContext.extraDescription.bind(to: extraDescriptionValueLabel.reactive.text)
        bindingContext.totalExcludingText.bind(to: totalExcludingLabel.reactive.text)
        bindingContext.totalExcluding.bind(to: totalExcludingValueLabel.reactive.text)
        bindingContext.vatText.bind(to: vatLabel.reactive.text)
        bindingContext.vat.bind(to: vatValueLabel.reactive.text)
        bindingContext.totalIncluding.bind(to: totalIncludingValueLabel.reactive.text)
        bindingContext.totalIncludingText.bind(to: totalIncludingLabel.reactive.text)
        bindingContext.legalMentionsText.bind(to: legalMentionLabel.reactive.text)
        bindingContext.bic.bind(to: BicValue.reactive.text)
        bindingContext.iban.bind(to: IbanValue.reactive.text)
        invoiceNumberButton.reactive.Command(bindingContext.invoiceNumberCommand)
        
        self.bindingContext.canGeneratePdf.bind(to : generatePdfButton.reactive.isEnabled)
        self.bindingContext.canGeneratePdf.map{ $0 ? UIColor.white : UIColor.gray }.bind(to: generatePdfButton.reactive.titleColor)
    
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
