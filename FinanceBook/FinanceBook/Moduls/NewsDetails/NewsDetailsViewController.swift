//
//  NewsDetailsViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol INewsDetailsViewController: AnyObject {
    func showError(_ error: String)
}

final class NewsDetailsViewController: UIViewController {
    
    private enum Constants {
        static let barButtonTitle = "Add Company"
    }
    
    private let mainView = ListNewsView()
//    private let tableAdapter: IListNewsTableAdapter
//    private let interactor: IListNewsInteractor
//    private let router: IListNewsRouter

//    init(interactor: IListNewsInteractor,
//         router: IListNewsRouter,
//         tableAdapter: IListNewsTableAdapter) {
//        self.interactor = interactor
//        self.router = router
//        self.tableAdapter = tableAdapter
//        super.init(nibName: nil, bundle: nil)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.interactor.onViewAttached(controller: self,
//                                       view: self.mainView,
//                                       tableAdapter: self.tableAdapter)
//        self.setOnCellTappedHandler()
//        self.setRightBarButton()
//        self.interactor.loadNews()
//        self.setScrollDidEndHandler()
//        self.tableAdapter.delegate = self
    }
}
