//
//  TextField+ReusableKeyboard.swift
//  Monefi
//
//  Created by Andrea Perera on 2/22/20.
//  Copyright © 2020 Andrea Perera. All rights reserved.
//

import Foundation
import UIKit

private var reusableKeyboardDelegate: ReusableKeyboardDelegate? = nil

extension UITextField: ReusableKeyboardDelegate {
    
 // NumericKeyboardDelegate methods
 
  internal func numericKeyPressed(key: Int) {
    self.text?.append("\(key)")
  }

  internal func numericBackspacePressed() {
    self.deleteBackward()
  }
  internal func numericKeypointPressed(symbol: String) {
    if (self.text?.isEmpty)!{
        self.text?.append("0"+symbol)
    }
    else if(self.text?.contains("."))!
    {

    }
    else{
        self.text?.append(symbol)
    }
    

   
    }
    
    
    // Public methods to set or unset this uitextfield as NumericKeyboard.
    
     func setAsReusableKeyboard(delegate: ReusableKeyboardDelegate?) {
       let reusableKeyboard = ReusableKeyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 220))
       self.inputView = reusableKeyboard
       reusableKeyboardDelegate = delegate
       reusableKeyboard.delegate = self
     }
    
     func unsetAsReusableKeyboard() {
       if let reusableKeyboard = self.inputView as? ReusableKeyboard {
         reusableKeyboard.delegate = nil
       }
       self.inputView = nil
       reusableKeyboardDelegate = nil
     }
    
    
   

}

