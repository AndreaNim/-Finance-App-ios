//
//  HelpViewController.swift
//  Monefi
//
//  Created by Andrea Perera on 3/7/20.
//  Copyright © 2020 Andrea Perera. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    @IBOutlet weak var savingView: UIView!
    @IBOutlet weak var mortgageView: UIView!
   
    @IBOutlet weak var loanView: UIView!
    
    @IBOutlet weak var howToUseView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        howToUseView.alpha = 1
        savingView.alpha = 0
        mortgageView.alpha = 0
        loanView.alpha = 0
    }

    @IBAction func Onchange(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            print("how to use")
            howToUseView.alpha = 1
            savingView.alpha = 0
            mortgageView.alpha = 0
            loanView.alpha = 0
        }
        else if sender.selectedSegmentIndex == 1{
            print("loan")
            loanView.alpha = 1
            savingView.alpha = 0
            mortgageView.alpha = 0
            howToUseView.alpha = 0

            }
        else if sender.selectedSegmentIndex == 2{
            print("mortgage")
            howToUseView.alpha = 0
            loanView.alpha = 0
            savingView.alpha = 0
            mortgageView.alpha = 1
        }
        else{
            print("saving")
            mortgageView.alpha = 0
            savingView.alpha = 1
            loanView.alpha = 0
            howToUseView.alpha = 0

            }
      }
    }
    

