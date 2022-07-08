//
//  CategoryViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import UIKit

protocol ListCategoryViewControllerDelegate: AnyObject {
    func setData(_ model: CategoryType)
}

protocol IListCategoryViewController: AnyObject {
    func buttonTappedSuccess(_ model: CategoryType)
}

final class ListCategoryViewController: UIViewController {
    
    private let mainView = ListCategoryView()
    private let interactor: IListCategoryInteractor
    private let router: IListCategoryRouter
    
    private weak var delegate: ListCategoryViewControllerDelegate?
    
    init(interactor: IListCategoryInteractor,
         router: IListCategoryRouter,
         delegate: ListCategoryViewControllerDelegate) {
        self.interactor = interactor
        self.router = router
        self.delegate = delegate
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
        self.setHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension ListCategoryViewController: IListCategoryViewController {
    
    func buttonTappedSuccess(_ model: CategoryType) {
        self.delegate?.setData(model)
        self.router.popToRoot()
    }
}

private extension ListCategoryViewController {
    
    func setHandlers() {
        self.setSaveButtonTappedHandler()
        self.setOnCellTappedHandler()
    }
    
    func setSaveButtonTappedHandler() {
        self.mainView.saveButtonTappedHandler = { [ weak self ] in
            let model = self?.mainView.getViewModel()
            self?.interactor.saveButtonTapped(model)
        }
    }
    
    func setOnCellTappedHandler() {
        self.mainView.onCellTappedHandler = { [ weak self ] model in
            self?.interactor.check(model)
        }
    }
}
