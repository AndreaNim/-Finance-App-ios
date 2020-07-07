//
//  LoanViewController.swift
//  Monefi
//
//  Created by Andrea Perera on 2/20/20.
//  Copyright © 2020 Andrea Perera. All rights reserved.
//

import UIKit

class LoanViewController: UIViewController,ReusableKeyboardDelegate  {
    
    @IBOutlet weak var PaymentTermsInput: UITextField!
    @IBOutlet weak var InterrestRateInput: UITextField!
    @IBOutlet weak var loanAmountInput: UITextField!
    @IBOutlet weak var InstallmentInput: UITextField!
    
    var Amount : Double=0.0
    var interestRate : Double=0.0
    var payment: Double=0.0
    var paymentTerms: Double=0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        let savedPaymentTermsInput = UserDefaults.standard.string(forKey:"PaymentTermsInput")
        let savedInterrestRateInput = UserDefaults.standard.string(forKey:"InterrestRateInput")
        let savedloanAmountInput = UserDefaults.standard.string(forKey:"loanAmountInput")
        let savedInstallmentInput = UserDefaults.standard.string(forKey:"InstallmentInput")
        if let PaymentTermsInputsave = savedPaymentTermsInput
        {
            PaymentTermsInput.text = PaymentTermsInputsave
        }
        if let InterrestRateInputsave = savedInterrestRateInput
        {
            InterrestRateInput.text = InterrestRateInputsave
        }
        if let loanAmountInputsave = savedloanAmountInput
        {
            loanAmountInput.text = loanAmountInputsave
        }
        if let InstallmentInputsave = savedInstallmentInput
        {
            InstallmentInput.text = InstallmentInputsave
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loanAmountInput.setAsReusableKeyboard(delegate: self)
        PaymentTermsInput.setAsReusableKeyboard(delegate: self)
        InterrestRateInput.setAsReusableKeyboard(delegate: self)
        InstallmentInput.setAsReusableKeyboard(delegate: self)
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
        UserDefaults.standard.set(PaymentTermsInput.text, forKey:"PaymentTermsInput")
        UserDefaults.standard.set(InterrestRateInput.text, forKey:"InterrestRateInput")
        UserDefaults.standard.set(loanAmountInput.text, forKey:"loanAmountInput" )
        UserDefaults.standard.set(InstallmentInput.text, forKey:"InstallmentInput" )
    }
    @IBAction func calculateLoan(_ sender: UIButton) {
        var monthlyPayment : Double=0.0
        var loanAmount : Double=0.0
        var NoOfYears : Double=0.0
        var interest : Double=0.0
        if let unwrapped = Double(PaymentTermsInput.text!) {
            paymentTerms = unwrapped
        }
        if let unwrapped = Double(loanAmountInput.text!) {
            Amount = unwrapped
        }
        if let unwrapped = Double(InterrestRateInput.text!) {
            interestRate = unwrapped
        }
        if let unwrapped = Double(InstallmentInput.text!) {
            payment = unwrapped
        }
        let doubleamount = Double(self.Amount)
        print(doubleamount)
        
        let doubleNumberOfYears = Double(self.paymentTerms)
        print(doubleNumberOfYears)
        let doubleInterest = Double(self.interestRate)
        print(doubleInterest)
        let doublePayment = Double(self.payment)
        print(doublePayment)
        
        //𝑃𝑉=𝑃𝑀𝑇/i[1−[1/(1+𝑖)n]]
        let mongthlyInterest = Double((doubleInterest/100)/12)
        let numberOfMonths = Double(doubleNumberOfYears*12)
        let pwrWithNoOfMoths = Double(pow((1+mongthlyInterest),numberOfMonths))
        
        //calculate loanamount
        if ((loanAmountInput.text == "") && (PaymentTermsInput.text != "")) && (InterrestRateInput.text != "" && InstallmentInput.text != ""){
            loanAmount=round(Double(doublePayment/mongthlyInterest)*(1-(1/pwrWithNoOfMoths)))
            print(loanAmount)
            loanAmountInput.text=String(format: "%.2f",loanAmount)
        }
            //caculate monthly payment
        else if ((InstallmentInput.text == "") && (InterrestRateInput.text != "")) && (loanAmountInput.text != "" && PaymentTermsInput.text != "") {
            monthlyPayment=Double((doubleamount*mongthlyInterest)*(pwrWithNoOfMoths))/(pwrWithNoOfMoths-1)
            print(monthlyPayment)
            InstallmentInput.text=String(format: "%.2f",monthlyPayment)
        }
            //caculate number of years
        else if ((PaymentTermsInput.text == "") && (InterrestRateInput.text != "")) && (loanAmountInput.text != "" && InstallmentInput.text != "") {
            
//            NoOfYears=round(Double((mongthlyInterest+doubleamount)/doublePayment)/12)
             NoOfYears=round(log((doublePayment/mongthlyInterest ) / ((doublePayment/mongthlyInterest) - doubleamount))/log(1 + mongthlyInterest)/12)
            print(NoOfYears)
            PaymentTermsInput.text=String(NoOfYears)
        }
            //caculate interest rate
        else if ((InterrestRateInput.text == "") && (PaymentTermsInput.text != "")) && (loanAmountInput.text != "" && InstallmentInput.text != "") {
            interest=LoanViewController.interestRateCalculation(loan:doubleamount,PMT:doublePayment,  n:doubleNumberOfYears)
            InterrestRateInput.text=String(interest)
            
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
    
    static func interestRateCalculation(loan:Double,PMT:Double,n:Double) -> Double {
        var months = n*12
        var x = 1 + (((PMT*months/loan) - 1) / 12)
        // var x = 0.1;
        let FINANCIAL_PRECISION = Double(0.000001) // 1e-6
        
        func F(_ x: Double) -> Double { // f(x)
            // (loan * x * (1 + x)^n) / ((1+x)^n - 1) - pmt
            return Double(loan * x * pow(1 + x, months) / (pow(1+x, months) - 1) - PMT);
        }
        
        func FPrime(_ x: Double) -> Double { // f'(x)
            // (loan * (x+1)^(n-1) * ((x*(x+1)^n + (x+1)^n-n*x-x-1)) / ((x+1)^n - 1)^2)
            let c_derivative = pow(x+1, months)
            return Double(loan * pow(x+1, months-1) *
                (x * c_derivative + c_derivative - (n*x) - x - 1)) / pow(c_derivative - 1, 2)
        }
        
        while(abs(F(x)) > FINANCIAL_PRECISION) {
            x = x - F(x) / FPrime(x)
        }
        
        // Convert to yearly interest & Return as a percentage
        // with two decimal fraction digits
        
        let I = Double(round(12 * x * 100))
        
        print("DEBUG", I)
        
        // if the found value for I is inf or less than zero
        // there's no interest applied
        if I.isNaN || I.isInfinite || I < 0 {
            return 0.0;
        } else {
            // this may return a value more than 100% for cases such as
            // where payment = 2000, n = 12, amount = 10000  <--- unreal figures
            return I
            
        }
        
    }
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
}

