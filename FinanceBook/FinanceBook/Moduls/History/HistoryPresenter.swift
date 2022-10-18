//
//  ChartPresenter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol IHistoryPresenter: AnyObject {
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView)
    func showError(_ error: Error)
    func setHistory(_ history: [HistoryModelResponse])
    func setTitleForDateLabel(dateInterval: DateCollectionAdapter.DateType)
    func setTitleForDateLabel(_ title: String)
}

final class HistoryPresenter {
    
    private weak var view: IHistoryView?
    private weak var controller: IHistoryViewController?
    
    private let mainQueue = DispatchQueue.main
}

extension HistoryPresenter: IHistoryPresenter {
    
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView) {
        self.controller = controller
        self.view = view
    }
    
    func showError(_ error: Error) {
        self.mainQueue.async {
            self.controller?.showError(error.localizedDescription)
        }
    }
    
    //MARK: - TO DO
    //if historyViewModel.isEmpty { showEmptyState() } else { showContent }
    func setHistory(_ history: [HistoryModelResponse]) {
        let historyViewModel = history.map { HistoryModel(model: $0) }
        
        let ar = self.convert(array: historyViewModel)
        print(ar)
        
        self.mainQueue.async {
            self.view?.setImageViewState(!historyViewModel.isEmpty)
            self.view?.setHistory(historyViewModel)
            self.view?.updateChart(ar)
        }
    }
    
    func setTitleForDateLabel(dateInterval: DateCollectionAdapter.DateType) {
        self.view?.setTitleForDateLabel(dateInterval.rawValue)
    }
    
    func setTitleForDateLabel(_ title: String) {
        self.mainQueue.async {
            self.view?.setTitleForDateLabel(title)
        }
    }
}

private extension HistoryPresenter {
    
    func convert(array: [HistoryModel]) -> [[HistoryModel]] {
        var newArray: [[HistoryModel]] = []
        var isAppend = Bool()
        
        for i in 0..<array.count {
            isAppend = false
            for j in 0..<newArray.count {
                if newArray[j].first?.name == array[i].name {
                    newArray[j].append(contentsOf: [array[i]])
                    isAppend = true
                    break
                }
            }
            if isAppend == false {
                newArray.append([array[i]])
            }
        }
        
        return newArray
    }
}
