//
//  UIViewExtension.swift
//  Russian Block
//
//  Created by Chester Wong on 06/11/2017.
//  Copyright © 2017 Easy. All rights reserved.
//

import UIKit

extension UIView {
    
    func fadeIn(duration: TimeInterval = 1.0){
        self.alpha = 0.0
        self.isHidden = false
        UIView.animate(withDuration: duration, delay: duration, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }

}
