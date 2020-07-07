//
//  ReusableKeyboard.swift
//  Monefi
//
//  Created by Andrea Perera on 2/20/20.
//  Copyright © 2020 Andrea Perera. All rights reserved.
//

import UIKit

class ReusableKeyboard: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    // numbers
    @IBOutlet weak var buttonKey0: UIButton!
    @IBOutlet weak var buttonKey1: UIButton!
    @IBOutlet weak var buttonKey2: UIButton!
    @IBOutlet weak var buttonKey3: UIButton!
    @IBOutlet weak var buttonKey4: UIButton!
    @IBOutlet weak var buttonKey5: UIButton!
    @IBOutlet weak var buttonKey6: UIButton!
    @IBOutlet weak var buttonKey7: UIButton!
    @IBOutlet weak var buttonKey8: UIButton!
    @IBOutlet weak var buttonKey9: UIButton!
    // backspace
    @IBOutlet weak var buttonKeyBackspace: UIButton!
    // keypoint
    @IBOutlet weak var buttonKeyPoint: UIButton!
   
    
    weak var delegate:ReusableKeyboardDelegate?
    // all non-backspace button outlets
    //array with all of our numeric buttons 
        var allButtons: [UIButton] { return [buttonKey0, buttonKey1, buttonKey2, buttonKey3, buttonKey4, buttonKey5, buttonKey6, buttonKey7, buttonKey8, buttonKey9, buttonKeyPoint] }

    
    // Initialization and lifecycle.
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      initializeKeyboard()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      initializeKeyboard()
    }
    
    func initializeKeyboard() {
      // set view
      let xibFileName = "Keyboard"
      let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)![0] as! UIView
      self.addSubview(view)
      view.frame = self.bounds
      
    }
   
      // Button actions
      @IBAction func numericButtonPressed(_ sender: UIButton) {
        self.delegate?.numericKeyPressed(key: sender.tag)
      }

      @IBAction func backspacePressed(_ sender: AnyObject) {
        self.delegate?.numericBackspacePressed()
      }
    @IBAction func keypointPressed(_ sender: AnyObject) {
        if let symbol = sender.titleLabel??.text{
            self.delegate?.numericKeypointPressed(symbol: symbol)
        }
        
        
    }
    
}

@objc protocol ReusableKeyboardDelegate {
 func numericKeyPressed(key: Int)
 func numericBackspacePressed()
 func numericKeypointPressed(symbol: String)
}
