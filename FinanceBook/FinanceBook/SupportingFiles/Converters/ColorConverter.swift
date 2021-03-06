//
//  ColorConverter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

enum ColorConverter {
    
    static func toColor(fromData: Data) -> UIColor? {
        
        try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(fromData) as? UIColor
    }
    
    static func toData(fromColor: UIColor) -> Data? {
        
        try? NSKeyedArchiver.archivedData(withRootObject: fromColor,
                                          requiringSecureCoding: false)
    }
}
