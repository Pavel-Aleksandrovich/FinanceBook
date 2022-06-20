//
//  NewSegmentValidator.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import Foundation

protocol ISegmentValidator: AnyObject {
    func check(viewModel: ViewModelRequest?,
               complition: @escaping(ValidateResult) -> ()) -> Bool
}

final class SegmentValidator {}

extension SegmentValidator: ISegmentValidator {
    
    func check(viewModel: ViewModelRequest?,
               complition: @escaping(ValidateResult) -> ()) -> Bool {
        
        let checkName = self.checkName(viewModel?.name)
        
        if let error = checkName.error {
            complition(.error(error))
        } else {
            complition(.success(.name))
        }
        
        let checkAmount = self.checkAmount(viewModel?.amount)
        if let error = checkAmount.error {
            complition(.error(error))
        } else {
            complition(.success(.amount))
        }
        
        let checkDate = self.checkDate(viewModel?.date)
        if let error = checkDate.error {
            complition(.error(error))
        } else {
            complition(.success(.date))
        }
        
        if checkName.error == nil,
           checkAmount.error == nil,
           checkDate.error == nil { complition(.success(.all))
            return true }
        
        return false
    }
}

private extension SegmentValidator {
    
    func checkName(_ name: String?) -> (check: Bool, error: String?) {
        guard let name = name, name.isEmpty == false else {
            return (false, "Введите имя")
        }
        return (true, nil)
    }
    
    func checkAmount(_ amount: String?) -> (check: Bool, error: String?) {
        guard let amount = amount, amount.isEmpty == false else {
            return (false, "Введите сумму")
        }
        
        if let _ = UInt(amount) {
            return (true, nil)
        }
        
        return (false, "Некорректное значение")
    }
    
    func checkDate(_ date: String?) -> (check: Bool, error: String?) {
        guard let date = date, date.isEmpty == false else {
            return (false, "Введите category")
        }
        
        if let _ = DateConverter.getDateFrom(string: date) {
            return (true, nil)
        }
        
        return (false, "Некорректное значение")
    }
}
