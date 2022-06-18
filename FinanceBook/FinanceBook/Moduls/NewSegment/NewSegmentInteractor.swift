//
//  NewSegmentInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol INewSegmentInteractor: AnyObject {
    func onViewAttached(controller: INewSegmentViewController,
                        view: INewSegmentView)
    func createChart(_ segment: Segment)
}

final class NewSegmentInteractor {
    
    private let presenter: INewSegmentPresenter
    private let dataManager: IChartDataManager
    
    init(presenter: INewSegmentPresenter,
         dataManager: IChartDataManager) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

extension NewSegmentInteractor: INewSegmentInteractor {
    
    func createChart(_ segment: Segment) {
        let chart = ChartRequest(segments: segment)
        self.dataManager.create(segment: chart) { [ weak self ] result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    print("success")
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
                
            }
        }
    }
    
    func onViewAttached(controller: INewSegmentViewController,
                        view: INewSegmentView) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view)
    }
}
