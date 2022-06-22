//
//  NewSegmentValidator.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import Foundation

protocol ITransactionDetailsValidator: AnyObject {
    func check(viewModel: TransactionDetailsValidateRequest?,
               complition: @escaping(ValidateResult) -> ()) -> Bool
}

final class TransactionDetailsValidator {}

extension TransactionDetailsValidator: ITransactionDetailsValidator {
    
    func check(viewModel: TransactionDetailsValidateRequest?,
               complition: @escaping(ValidateResult) -> ()) -> Bool {
        
        let nameError = self.checkName(viewModel?.name)
        
        if nameError != nil {
            complition(.error(.name))
        } else {
            complition(.success(.name))
        }
        
        let amountError = self.checkAmount(viewModel?.amount)
        
        if amountError != nil {
            complition(.error(.amount))
        } else {
            complition(.success(.amount))
        }
        
        let dateError = self.checkDate(viewModel?.date)
        
        if dateError != nil {
            complition(.error(.date))
        } else {
            complition(.success(.date))
        }
        
        if nameError == nil,
           amountError == nil,
           dateError == nil {
            complition(.success(.all))
            return true }
        
        return false
    }
}

private extension TransactionDetailsValidator {
    
    func checkName(_ name: String?) -> String? {
        guard let name = name,
              !name.isEmpty
        else { return "Enter name" }
        
        return nil
    }
    
    func checkAmount(_ amount: String?) -> String? {
        guard let amount = amount,
              !amount.isEmpty
        else { return "Enter sum" }
        
        if let _ = UInt(amount) {
            return nil
        }
        
        return "Invalid value"
    }
    
    func checkDate(_ date: String?) -> String? {
        guard let date = date,
              !date.isEmpty else {
            return "Enter category"
        }
        
        if let _ = DateConverter.getDateFrom(string: date) {
            return nil
        }
        
        return "Invalid value"
    }
}
