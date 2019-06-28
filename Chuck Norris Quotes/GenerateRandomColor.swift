//
//  GenerateRandomColor.swift
//  Chuck Norris Quotes
//
//  Created by Johan Park on 6/28/19.
//  Copyright © 2019 Johan Park. All rights reserved.
//

import Foundation
import UIKit

class GenerateRandomColor {
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}
