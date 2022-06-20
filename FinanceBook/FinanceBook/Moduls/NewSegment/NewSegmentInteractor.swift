//
//  NewSegmentInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol INewSegmentInteractor: AnyObject {
    func onViewAttached(controller: INewSegmentViewController,
                        view: INewSegmentView)
    func createChart(_ viewModel: ViewModelRequest?)
    func checkTextFields(viewModel: ViewModelRequest)
}

final class NewSegmentInteractor {
    
    private let presenter: INewSegmentPresenter
    private let dataManager: IChartDataManager
    private let validator: ISegmentValidator
    
    init(presenter: INewSegmentPresenter,
         dataManager: IChartDataManager,
         validator: ISegmentValidator) {
        self.presenter = presenter
        self.dataManager = dataManager
        self.validator = validator
    }
}

extension NewSegmentInteractor: INewSegmentInteractor {
    
    func createChart(_ viewModel: ViewModelRequest?) {
        let result = self.validator.check(viewModel: viewModel) { [ weak self ] result in
            self?.presenter.setValidateResult(result)
        }
        
        if result == true {
            let chartRequest = ChartRequest(viewModel: viewModel)
            guard let chartRequest = chartRequest else { return }
            self.save(chart: chartRequest)
        }
    }
    
    func checkTextFields(viewModel: ViewModelRequest) {
        let _ = self.validator.check(viewModel: viewModel) { [ weak self ] result in
            self?.presenter.setValidateResult(result)
        }
    }
    
    func onViewAttached(controller: INewSegmentViewController,
                        view: INewSegmentView) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view)
    }
}

private extension NewSegmentInteractor {
    
    func save(chart: ChartRequest) {
        self.dataManager.create(segment: chart) { [ weak self ] result in
            switch result {
            case .success():
                    self?.presenter.showSuccess()
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
}
