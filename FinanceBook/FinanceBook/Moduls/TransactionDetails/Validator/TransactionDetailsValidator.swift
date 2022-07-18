//
//  NewSegmentValidator.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import Foundation

protocol ITransactionDetailsValidator: AnyObject {
    func check(viewModel: HistoryValidateRequest?,
               complition: @escaping(ValidateResult) -> ()) -> Bool
}

final class TransactionDetailsValidator {
    
    private enum Constants {
        static let emptyName = "Enter name"
        
        static let emptyAmount = "Enter sum"
        static let invalidAmount = "Invalid value"
        
        static let emptyDate = "Choose type"
        static let invalidDate = "Invalid value"
    }
}

extension TransactionDetailsValidator: ITransactionDetailsValidator {
    
    func check(viewModel: HistoryValidateRequest?,
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
        else { return Constants.emptyName }
        
        return nil
    }
    
    func checkAmount(_ amount: String?) -> String? {
        guard let amount = amount,
              !amount.isEmpty
        else { return Constants.emptyAmount }
        
        if let _ = UInt(amount) {
            return nil
        }
        
        return Constants.invalidAmount
    }
    
    func checkDate(_ date: String?) -> String? {
        guard let date = date,
              !date.isEmpty else {
            return Constants.emptyDate
        }
        
        if let _ = DateConverter.getDateFrom(string: date) {
            return nil
        }
        
        return Constants.invalidDate
    }
}
