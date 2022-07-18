//
//  ChartInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol IHistoryInteractor: AnyObject {
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView)
    func deleteHistoryBy(id: UUID)
    func setSelectedDate(_ date: Date)
    func setDateState(_ state: DateCollectionAdapter.DateType)
    func setProfitState(_ state: Profit)
    func leftArrowTapped()
    func rightArrowTapped()
}

final class HistoryInteractor {
    
    private let presenter: IHistoryPresenter
    private let dataManager: IHistoryDataManager
    
    private var profitType: Profit = .income
    private var selectedDate = Date() {
        didSet {
            self.switchForEachDateState()
        }
    }
    private var dateType: DateCollectionAdapter.DateType = .day
    
    private let calendar = Calendar.current
    
    init(presenter: IHistoryPresenter,
         dataManager: IHistoryDataManager) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

extension HistoryInteractor: IHistoryInteractor {
    
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view)
    }
    
    func deleteHistoryBy(id: UUID) {
        self.dataManager.deleteHistoryBy(id: id) { [ weak self ] result in
            guard let self = self else { return }
            
            switch result {
            case .success():
                self.loadHistoryForChooseDate()
            case .failure(let error):
                self.presenter.showError(error)
            }
        }
    }
    
    func setSelectedDate(_ date: Date) {
        self.selectedDate = date
        self.switchForEachDateState()
    }
    
    func setProfitState(_ state: Profit) {
        self.profitType = state
        self.switchForEachDateState()
    }
    
    func setDateState(_ state: DateCollectionAdapter.DateType) {
        self.dateType = state
        
        self.switchForEachDateState()
    }
    
    func leftArrowTapped() {
        switch self.dateType {
        case .day:
            self.selectedDate = self.calendar.date(byAdding: .day,
                                     value: -1,
                                     to: self.selectedDate) ?? Date()
        case .month:
            self.selectedDate = self.calendar.date(byAdding: .month,
                                     value: -1,
                                     to: self.selectedDate) ?? Date()
        case .year:
            self.selectedDate = self.calendar.date(byAdding: .year,
                                     value: -1,
                                     to: self.selectedDate) ?? Date()
        case .all: break
        }
    }
    
    func rightArrowTapped() {
        switch self.dateType {
        case .day:
            self.selectedDate = self.calendar.date(byAdding: .day,
                                     value: +1,
                                     to: self.selectedDate) ?? Date()
        case .month:
            self.selectedDate = self.calendar.date(byAdding: .month,
                                     value: +1,
                                     to: self.selectedDate) ?? Date()
        case .year:
            self.selectedDate = self.calendar.date(byAdding: .year,
                                     value: +1,
                                     to: self.selectedDate) ?? Date()
        case .all: break
        }
    }
}

private extension HistoryInteractor {
    
    func loadAllHistory() {
        self.dataManager.getHistory(profit: self.profitType.name)
        { [ weak self ] result in
            switch result {
            case .success(let historyResponse):
                self?.presenter.setHistory(historyResponse)
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func loadHistoryForDateInterval(fromDate: Date,
                                    toDate: Date) {
        self.dataManager.getHistory(fromDate: fromDate,
                                    toDate: toDate,
                                    profit: self.profitType.name)
        { [ weak self ] result in
            switch result {
            case .success(let historyResponse):
                self?.presenter.setHistory(historyResponse)
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func loadHistoryForChooseDate() {
        self.dataManager.getHistory(profit: self.profitType.name,
                                    date: self.selectedDate)
        { [ weak self ] result in
            switch result {
            case .success(let historyResponse):
                self?.presenter.setHistory(historyResponse)
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func switchForEachDateState() {
        switch self.dateType {
        case .day:
            self.loadHistoryForDateInterval(fromDate: self.selectedDate,
                                            toDate: self.selectedDate)
        case .month:
            self.loadHistoryForDateInterval(
                fromDate: self.generateDateFirstDayInMonth(),
                toDate: self.generateDateLastDayInMonth())
        case .year:
            self.loadHistoryForDateInterval(
                fromDate: self.generateDateStartOfYear(),
                toDate: self.generateDateEndOfYear())
        case .all:
            self.loadAllHistory()
        }
    }
}

private extension HistoryInteractor {
    
    func generateDateFirstDayInMonth() -> Date {
        let calendar = Calendar.current
        
        let firstDayOfMonth = calendar.date(
            from: calendar.dateComponents([.year, .month],
                                          from: self.selectedDate))
        
        guard let firstDayOfMonth = firstDayOfMonth else { return Date() }
        
        print("153 - \(firstDayOfMonth)")
        
        print("min - \(generateDateStartOfYear())")
        print("max - \(generateDateEndOfYear())")
        
        return firstDayOfMonth
    }
    
    func generateDateLastDayInMonth() -> Date {
        let calendar = Calendar.current
        
        let firstDayOfMonth = calendar.date(
            from: calendar.dateComponents([.year, .month], from: self.selectedDate)) ?? Date()
        
        let dateMax = calendar.date(byAdding: DateComponents(month: 1, day: -1),
                                    to: firstDayOfMonth)
        
        guard let dateMax = dateMax else { return Date() }
        
        return dateMax
    }
    
    func generateDateEndOfYear() -> Date {
        let calendar = Calendar.current
        
        let firstMonth = calendar.date(
            from: calendar.dateComponents([.year],
                                          from: self.selectedDate))
        
        guard let firstMonth = firstMonth else { return Date() }
        
        let dateMax = calendar.date(byAdding: DateComponents(year: 1, day: -1),
                                    to: firstMonth)
        
        guard let dateMax = dateMax else { return Date() }
        print(dateMax)
        
        return dateMax
    }
    
    func generateDateStartOfYear() -> Date {
        let calendar = Calendar.current
        
        let firstMonth = calendar.date(
            from: calendar.dateComponents([.year],
                                          from: self.selectedDate))
        
        guard let firstMonth = firstMonth else { return Date() }
        
        return firstMonth
    }
}
