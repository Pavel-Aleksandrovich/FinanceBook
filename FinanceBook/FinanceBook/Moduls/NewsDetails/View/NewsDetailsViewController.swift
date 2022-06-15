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
    
    private let mainView = NewsDetailsView()
    private let interactor: INewsDetailsInteractor
    private let router: INewsDetailsRouter

    init(interactor: INewsDetailsInteractor,
         router: INewsDetailsRouter) {
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
//        self.setOnCellTappedHandler()
//        self.setRightBarButton()
//        self.interactor.loadNews()
//        self.setScrollDidEndHandler()
//        self.tableAdapter.delegate = self
        self.createExitBarButton()
    }
}

extension NewsDetailsViewController: INewsDetailsViewController {
    
    func showError(_ error: String) {
        
    }
}

private extension NewsDetailsViewController {
    
    func createExitBarButton() {
        let image = UIImage(systemName: "xmark.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(exitButtonTapped))
    }
    
    @objc func exitButtonTapped() {
        self.router.dismiss()
//        dismiss(animated: true)
    }
}
