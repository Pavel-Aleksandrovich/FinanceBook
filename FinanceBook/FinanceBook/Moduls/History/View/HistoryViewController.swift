//
//  HistoryViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

protocol IHistoryViewController: AnyObject {
    func showError(_ error: String)
}

final class HistoryViewController: UIViewController {
    
    private let mainView = HistoryView()
    private let interactor: IHistoryInteractor
    private let router: IHistoryRouter
    
    init(interactor: IHistoryInteractor,
         router: IHistoryRouter) {
        self.interactor = interactor
        self.router = router
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
                                       view: self.mainView)
        self.router.setupViewController(self)
        self.createAddTransactionBarButton()
        self.setHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yy"
        
        let dateString = dateFormatter.string(from: Date())
        let date = dateFormatter.date(from: dateString)

        guard let date = date else { return }
        
        self.interactor.setSelectedDate(date)
    }
}

extension HistoryViewController: IHistoryViewController {
    
    func showError(_ error: String) {
        self.router.showAlert(error)
    }
}

// MARK: - Set Handlers
private extension HistoryViewController {
    
    func setHandlers() {
        self.setOnCellDeleteHandler()
        self.setCollectionAdapterHandler()
        self.setDateCollectionAdapterHandler()
        self.setOnDateViewTappedHandler()
    }
    
    func setOnCellDeleteHandler() {
        self.mainView.onCellDeleteHandler = { [ weak self ] id in
            self?.interactor.deleteHistoryBy(id: id)
        }
    }
    
    func setCollectionAdapterHandler() {
        self.mainView.onCellTappedHandler = { [ weak self ] type in
            self?.interactor.setProfitState(type)
        }
    }
    
    func setDateCollectionAdapterHandler() {
        self.mainView.onDateCellTappedHandler = { [ weak self ] type in
            self?.interactor.setDateState(type)
        }
    }
    
    func setOnDateViewTappedHandler() {
        self.mainView.onDateViewTappedHandler = { [ weak self ] state in
            switch state {
            case .leftArrow:
                self?.interactor.leftArrowTapped()
            case .rightArrow:
                self?.interactor.rightArrowTapped()
            case .dateLabel:
                self?.showCalendar()
            }
        }
    }
    
    func showCalendar() {
        let vc = CalendarPickerViewController(baseDate: Date()) { date in
            
            self.interactor.setSelectedDate(date)
        }
        self.present(vc, animated: true)
    }
}

private extension HistoryViewController {
    
    func createAddTransactionBarButton() {
        let item = UIBarButtonItem(barButtonSystemItem: .add,
                                   target: self,
                                   action: #selector
                                   (self.addTransactionButtonTapped))
        item.tintColor = MainAttributs.color
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func addTransactionButtonTapped() {
        self.router.showAddTransactionModul()
    }
}
