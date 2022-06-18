//
//  ChartViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

protocol IChartViewController: AnyObject {}

final class ChartViewController: UIViewController {
    
    private let mainView = ChartView()
    private let tableAdapter: IChartTableAdapter
    private let interactor: IChartInteractor
    private let router: IChartRouter

    init(interactor: IChartInteractor,
         router: IChartRouter,
         tableAdapter: IChartTableAdapter) {
        self.interactor = interactor
        self.router = router
        self.tableAdapter = tableAdapter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor.onViewAttached(controller: self,
                                       view: self.mainView,
                                       tableAdapter: self.tableAdapter)
        self.createAddSegmentBarButton()
        self.setOnCellDeleteHandler()
//        tableAdapter.delete = { chart in
//            self.interactor.deleteChart(chart: chart)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.interactor.loadData()
    }
}

extension ChartViewController: IChartViewController {}

private extension ChartViewController {
    
    func setOnCellDeleteHandler() {
        self.tableAdapter.onCellDeleteHandler = { [ weak self ] chart, segment in
            self?.interactor.deleteSegment(segment, from: chart)
        }
    }
    
    func createAddSegmentBarButton() {
        let item = UIBarButtonItem(barButtonSystemItem: .add,
                                   target: self,
                                   action: #selector(self.addSegmentButtonTapped))
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func addSegmentButtonTapped() {
        self.router.showAddSegmentModul()
    }
}
