//
//  RoundUIView.swift
//  CryptoTrading
//
//  Created by Mohamed aymen AFIA on 27/12/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class RoundUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}
