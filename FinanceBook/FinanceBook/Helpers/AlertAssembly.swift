//
//  AlertAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

enum AlertAssembly {
    
    static func createLanguageAlert(complition: @escaping(String) -> ()) -> UIAlertController {
        
        let alert = UIAlertController(title: "Choose Language", message: nil, preferredStyle: .actionSheet)
        
        let us = UIAlertAction(title: "us", style: .default) { _ in
            complition("us")
        }
        let ru = UIAlertAction(title: "ru", style: .default) { _ in
            complition("ru")
        }
        
        alert.addAction(us)
        alert.addAction(ru)
        
        return alert
    }
}
