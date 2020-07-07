//
//  SavingsViewController.swift
//  Monefi
//
//  Created by Andrea Perera on 2/20/20.
//  Copyright © 2020 Andrea Perera. All rights reserved.
//

import UIKit

class SavingsViewController: UIViewController,ReusableKeyboardDelegate {
    
    @IBOutlet weak var RegularContributionUI: UIStackView!
    
    @IBOutlet weak var TotalNumberOfPaymentsInput: UITextField!
    @IBOutlet weak var FutureValueInput: UITextField!
    @IBOutlet weak var CompondPerYearInput: UITextField!
    @IBOutlet weak var PaymentInput: UITextField!
    @IBOutlet weak var InterestInput: UITextField!
    @IBOutlet weak var PrincipalAmountInput: UITextField!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var endSwitch: UISwitch!
    var Amount : Double=0.0
    var Interest : Double=0.0
    var InterestCompond: Double=0.0
    var FutureVal: Double=0.0
    var Time : Double=0.0
    var payment :Double=0.0
    var switchOn : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        let savedPrincipalAmountInput = UserDefaults.standard.string(forKey:"PrincipalAmountInput")
        let savedTotalNumberOfPaymentsInput = UserDefaults.standard.string(forKey:"TotalNumberOfPaymentsInput")
        let savedFutureValueInput = UserDefaults.standard.string(forKey:"FutureValueInput")
        let savedPaymentInput = UserDefaults.standard.string(forKey:"PaymentInput")
        let savedInterestInput = UserDefaults.standard.string(forKey:"InterestInput")
        
        if let PrincipalAmountInputsave = savedPrincipalAmountInput 
        {
            PrincipalAmountInput.text = PrincipalAmountInputsave
        }
        if let TotalNumberOfPaymentsInputsave = savedTotalNumberOfPaymentsInput
        {
            TotalNumberOfPaymentsInput.text = TotalNumberOfPaymentsInputsave
        }
        if let FutureValueInputsave = savedFutureValueInput
        {
            FutureValueInput.text = FutureValueInputsave
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
    @IBAction func saveData(_ sender: Any) {
        
        UserDefaults.standard.set(TotalNumberOfPaymentsInput.text, forKey:"TotalNumberOfPaymentsInput")
        UserDefaults.standard.set(FutureValueInput.text, forKey:"FutureValueInput" )
        UserDefaults.standard.set(CompondPerYearInput.text, forKey:"CompondPerYearInput" )
        UserDefaults.standard.set(PaymentInput.text, forKey:"PaymentInput")
        UserDefaults.standard.set(InterestInput.text, forKey:"InterestInput" )
        UserDefaults.standard.set(PrincipalAmountInput.text, forKey:"PrincipalAmountInput" )
        
        
    }
    @IBAction func SwichInput(_ sender: UISwitch) {
        if(sender.isOn == true){
            RegularContributionUI.isHidden=false
            switchOn = true
            print("swich on")
        }
        else{
            RegularContributionUI.isHidden=true
            switchOn = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PrincipalAmountInput.setAsReusableKeyboard(delegate:self)
        TotalNumberOfPaymentsInput.setAsReusableKeyboard(delegate:self)
        PaymentInput.setAsReusableKeyboard(delegate:self)
        InterestInput.setAsReusableKeyboard(delegate: self)
        FutureValueInput.setAsReusableKeyboard(delegate: self)
        CompondPerYearInput.setAsReusableKeyboard(delegate:self)
        
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
    
    @IBAction func calculateSavings(_ sender: UIButton) {

        var compoundedUnitTime : Double=0.0
        var principalAmount : Double=0.0
        var FutureValue : Double=0.0
        var interestRate : Double=0.0
        var timeInvest : Double=0.0
        var nt : Double=0.0
        var x : Double=0.0
        
        if let unwrapped = Double(CompondPerYearInput.text!) {
            InterestCompond = unwrapped
            
        }
        if let unwrapped = Double(PrincipalAmountInput.text!) {
            Amount = unwrapped
        }
        if let unwrapped = Double(FutureValueInput.text!) {
            FutureVal = unwrapped
        }
        if let unwrapped = Double(InterestInput.text!) {
            Interest  = unwrapped
        }
        if let unwrapped = Double(TotalNumberOfPaymentsInput.text!) {
            Time  = unwrapped
        }
        let doubleAmount = Double(self.Amount)
        print("doubleAmount",doubleAmount)
        
        let doubleFutureVal = Double(self.FutureVal)
        print("doubleFutureVal",doubleFutureVal)
        
        let doubleInterest = Double(self.Interest)
        print("doubleInterest",doubleInterest)
        
        let doubleTime  = Double(self.Time )
        print("doubleTime",doubleTime)
        
        let doubleInterestCompond  = Double(self.InterestCompond)
        print("doubleInterestCompond",doubleInterestCompond)
        
        let annualInterest = Double((doubleInterest/100))
        //       var numberOfMonths = Double(doubleTime*12)
        
        nt=Double(doubleInterestCompond*doubleTime)
        //(1+r/n)
        x=Double((1+annualInterest/doubleInterestCompond))
        
        //calculate future value
        if ((FutureValueInput.text == "") && (CompondPerYearInput.text != "")) && (PrincipalAmountInput.text != "" && InterestInput.text != "") && (TotalNumberOfPaymentsInput.text != "") && (PaymentInput.text == ""){
            //A = P (1 + r/n) (nt)
            FutureValue = Double(doubleAmount*(pow(x,nt)))
            print(FutureValue)
            FutureValueInput.text=String(format: "%.2f",FutureValue)
            
        }
            //calculate principal amount
        else if((PrincipalAmountInput.text == "") && (CompondPerYearInput.text != "")) && (FutureValueInput.text != "" && InterestInput.text != "") && (TotalNumberOfPaymentsInput.text != "") && (PaymentInput.text == ""){
            //P=A/(1+r/n)nt
            principalAmount = Double(doubleFutureVal/(pow(x,nt)))
            PrincipalAmountInput.text=String(format: "%.2f",principalAmount)
            
        }
            //calculate interest rate
        else if((InterestInput.text == "") && (CompondPerYearInput.text != "")) && (FutureValueInput.text != "" && PrincipalAmountInput.text != "") && (TotalNumberOfPaymentsInput.text != "") && (PaymentInput.text == ""){
            //r=n[A/P]1/nt-1]
            interestRate=round(Double(doubleInterestCompond*(Double(pow((doubleFutureVal/doubleAmount),(1/nt)))-1))*100)
            InterestInput.text=String(interestRate)
            
        }
            //time(number of paymments)
        else if((TotalNumberOfPaymentsInput.text == "") && (CompondPerYearInput.text != "")) && (FutureValueInput.text != "" && PrincipalAmountInput.text != "") && (InterestInput.text != "") && (PaymentInput.text == ""){
            //T=((FV/A)-1)/R
           //timeInvest = ( ( (doubleFutureVal/doubleAmount)-1 ) / annualInterest)
            timeInvest = round( log( Double(doubleFutureVal/doubleAmount) ) / ( doubleInterestCompond * ( log(Double(1+( annualInterest/doubleInterestCompond) ) ) ) ) )
                                                                         
           
            TotalNumberOfPaymentsInput.text=String(format: "%.2f",timeInvest)
            
            
        }
        else if(switchOn){
            print("On ON")
            savingsWithRegularContribution(P:doubleAmount,A:doubleFutureVal, r : doubleInterest ,t: doubleTime, n:doubleInterestCompond,nt:nt,x:x)
        }
            
        else if((TotalNumberOfPaymentsInput.text != "") && (CompondPerYearInput.text != "")) && (FutureValueInput.text != "" && PrincipalAmountInput.text != "") && (InterestInput.text != "") && (PaymentInput.text != ""){
            
            alerts()
        }
            
            
        else{
            alerts()
            
        }
        
        
    }
    func savingsWithRegularContribution(P:Double,A:Double,r:Double , t:Double, n:Double,nt: Double,x:Double) {
        
        var compoundInterestPrincipal: Double=0.0
        var futureValueSeries: Double=0.0
        var monthlyPayment: Double=0.0
        var numberOfYears : Double=0.0
        var FutureValue : Double=0.0
        
        if let unwrapped = Double(PaymentInput.text!) {
            payment = unwrapped
            
        }
        
        let doublepayment = Double(self.payment)
        print(doublepayment)
        compoundInterestPrincipal = Double(P*(pow(x,nt)))
        //calculate future value
        if ((FutureValueInput.text == "") && (CompondPerYearInput.text != "")) && (PrincipalAmountInput.text != "" && InterestInput.text != "") && (TotalNumberOfPaymentsInput.text != "") && (PaymentInput.text != ""){
            
            futureValueSeries = Double(doublepayment*(((pow(x,nt))-1)/(r/n)))
            FutureValue = Double(compoundInterestPrincipal + futureValueSeries )
            FutureValueInput.text=String(format: "%.2f",FutureValue)
            if(endSwitch.isOn==false){
                futureValueSeries = Double(doublepayment*(((pow(x,nt))-1)/(r/n)))*(Double(1+(r/n)))
                FutureValue = Double(compoundInterestPrincipal + futureValueSeries )
                FutureValueInput.text=String(format: "%.2f",FutureValue)
            }
            
        }
            //calculate monthly payments
        else if((PaymentInput.text == "") && (CompondPerYearInput.text != "")) && (PrincipalAmountInput.text != "" && InterestInput.text != "") && (TotalNumberOfPaymentsInput.text != "") && (FutureValueInput.text != "") {
            monthlyPayment=Double(A-compoundInterestPrincipal)/(((pow(x,nt))-1)/(r/n))
            PaymentInput.text=String(format: "%.2f",monthlyPayment)
            if(endSwitch.isOn==false){
                monthlyPayment=Double(A-compoundInterestPrincipal)/(((pow(x,nt))-1)/(r/n)*(Double(1+(r/n))))
                PaymentInput.text=String(format: "%.2f",monthlyPayment)
            }
        }
                //calculate time
            else if((TotalNumberOfPaymentsInput.text == "") && (CompondPerYearInput.text != "")) && (PrincipalAmountInput.text != "" && InterestInput.text != "") && (PaymentInput.text != "") && (FutureValueInput.text != "") {
                // t=ln(A+((PMT*n)/r))-ln((rP+PMT*n)/r) /n* (ln(1+(r/n)))
                numberOfYears = log(Double(A+((doublepayment*n)/r))) - log(Double((r*P+doublepayment*n)/r))/(n*(log(Double(1+(r/n)))))
                TotalNumberOfPaymentsInput.text=String(format: "%.2f",numberOfYears)
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
