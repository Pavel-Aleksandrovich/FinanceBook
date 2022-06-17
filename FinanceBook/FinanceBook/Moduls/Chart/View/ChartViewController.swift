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
        createAddSegmentBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let segment = Segment(color: #colorLiteral(red: 1.0, green: 0.121568627, blue: 0.28627451, alpha: 1.0), name: "Red", value: 57.56)
//        self.mainView.updateChart(segment: segment)
//        self.interactor.createChart()
        self.interactor.loadData()
        
    }
}

extension ChartViewController: IChartViewController {}

private extension ChartViewController {
    
    func createAddSegmentBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addSegmentButtonTapped))
    }
    
    @objc func addSegmentButtonTapped() {
        self.router.showAddSegmentModul()
    }
}
