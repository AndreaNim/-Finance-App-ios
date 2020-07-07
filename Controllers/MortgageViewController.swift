//
//  MortgageViewController.swift
//  Monefi
//
//  Created by Andrea Perera on 2/20/20.
//  Copyright © 2020 Andrea Perera. All rights reserved.
//

import UIKit
class MortgageViewController: UIViewController,ReusableKeyboardDelegate {
    @IBOutlet weak var AmountInput: UITextField!
    @IBOutlet weak var NumberOfYearsInput: UITextField!
    @IBOutlet weak var PaymentInput: UITextField!
    @IBOutlet weak var InterestInput: UITextField!
    
    var loanAmount : Double=0.0
    var interest   : Double=0.0
    var payment: Double=0.0
    var numberOfYears: Double=0.0
    var niiamount : Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        let savedAmountInput = UserDefaults.standard.string(forKey:"AmountInput")
        let savedNumberOfYearsInput = UserDefaults.standard.string(forKey:"NumberOfYearsInput")
        let savedPaymentInput = UserDefaults.standard.string(forKey:"PaymentInput")
        let savedInterestInput = UserDefaults.standard.string(forKey:"InterestInput")
        if let AmountInputsave = savedAmountInput
        {
            AmountInput.text = AmountInputsave
        }
        if let NumberOfYearsInputsave = savedNumberOfYearsInput
        {
            NumberOfYearsInput.text = NumberOfYearsInputsave
        }
        if let PaymentInputsave = savedPaymentInput
        {
            PaymentInput.text = PaymentInputsave
        }
        if let InterestInputsave = savedInterestInput
        {
            InterestInput.text = InterestInputsave
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NumberOfYearsInput.setAsReusableKeyboard(delegate: self)
        PaymentInput.setAsReusableKeyboard(delegate: self)
        InterestInput.setAsReusableKeyboard(delegate: self)
        AmountInput.setAsReusableKeyboard(delegate: self)
    }
    
    func numericKeyPressed(key: Int) {
        print("Numeric key \(key) pressed!")
        
    }
    
    func numericBackspacePressed() {
        print("Backspace pressed!")
        
    }
    func numericKeypointPressed(symbol: String){
        print(". pressed!")
    }
    @IBAction func saveData(_ sender: Any) {
        UserDefaults.standard.set(AmountInput.text, forKey:"AmountInput")
        UserDefaults.standard.set(NumberOfYearsInput.text, forKey:"NumberOfYearsInput")
        UserDefaults.standard.set(PaymentInput.text, forKey:"PaymentInput" )
        UserDefaults.standard.set(InterestInput.text, forKey:"InterestInput" )
        
    }
    
    @IBAction func mortgagrCalcalate(_ sender: UIButton) {
        var monthlyPayment : Double=0.0
        var mortageAmount : Double=0.0
        var interestRate : Double=0.0
        var NoOfYears : Double=0.0
        
        if let unwrapped = Double(AmountInput.text!) {
            loanAmount = unwrapped
            
        }
        if let unwrapped = Double(PaymentInput.text!) {
            payment = unwrapped
        }
        if let unwrapped = Double(InterestInput.text!) {
            interest = unwrapped
        }
        if let unwrapped = Double(NumberOfYearsInput.text!) {
            numberOfYears = unwrapped
        }
        
        
        let doubleamount = Double(self.loanAmount)
        print("doubleamount",doubleamount)
        
        let doubleNumberOfYears = Double(self.numberOfYears)
        print("doubleNumberOfYears",doubleNumberOfYears)
        
        let doublePayment = Double(self.payment)
        print("doublePayment",doublePayment)
        
        let doubleInterest = Double(self.interest)
        print("doubleInterest",doubleInterest)
        
        
        let mongthlyInterest = Double((doubleInterest/100)/12)
        let numberOfMonths = Double(doubleNumberOfYears*12)
        let pwr = Double(pow((1+mongthlyInterest),numberOfMonths))
        print(pwr)
        print("mongthlyInterest",mongthlyInterest)
        //calculating monthly Payment
//        𝑃𝑀𝑇=𝑃𝑉𝑖(1+𝑖)𝑛(1+𝑖)𝑛−1
        if ((AmountInput.text != "") && (NumberOfYearsInput.text != "")) && (InterestInput.text != "" && PaymentInput.text == ""){
            monthlyPayment=Double(doubleamount * mongthlyInterest * pwr)/(pwr-1)
            print(monthlyPayment)
            PaymentInput.text=String(format: "%.2f",monthlyPayment)
            
            
        }
            //calculating mortageAmount
        else if ((PaymentInput.text != "") && (NumberOfYearsInput.text != "")) && (InterestInput.text != "" && AmountInput.text == "") {
            
            mortageAmount=round((doublePayment*(pwr-1))/(mongthlyInterest*pwr))
            print(mortageAmount)
            AmountInput.text=String(format: "%.2f",mortageAmount)
            
            
        }
            //Interest
        else if((PaymentInput.text != "") && (NumberOfYearsInput.text != "")) && (AmountInput.text != "" && InterestInput.text == "") {
            
            interestRate = LoanViewController.interestRateCalculation(loan:loanAmount,PMT:doublePayment,  n:doubleNumberOfYears)
            InterestInput.text=String(interestRate)
        }
            //number of years
        else if((PaymentInput.text != "") && (NumberOfYearsInput.text == "")) && (InterestInput.text != "" && AmountInput.text != ""){
        
//            NoOfYears=round(Double((mongthlyInterest+doubleamount)/doublePayment)/12)
             NoOfYears=round(log((doublePayment/mongthlyInterest ) / ((doublePayment/mongthlyInterest) - doubleamount))/log(1 + mongthlyInterest)/12)
            print(NoOfYears)
            
            NumberOfYearsInput.text=String(NoOfYears)
            
        }
        else{
            alerts()
            
        }
        
    }
    func alerts() {
        let alertController = UIAlertController(title: "error", message:
            "Invaild inputs", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}
