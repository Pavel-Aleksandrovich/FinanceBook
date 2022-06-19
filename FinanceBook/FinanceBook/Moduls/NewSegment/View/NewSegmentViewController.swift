//
//  NewSegmentViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol INewSegmentViewController: AnyObject {
    func showError(_ error: String)
    func showSuccess()
}

final class NewSegmentViewController: UIViewController {
    
    private let mainView = NewSegmentView()
    private let interactor: INewSegmentInteractor
    private let router: INewSegmentRouter
    
    init(interactor: INewSegmentInteractor,
         router: INewSegmentRouter) {
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
        self.setSaveButtonTappedHandler()
        self.navigationController?.navigationBar.tintColor = MainAttributs.color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension NewSegmentViewController: INewSegmentViewController {
    
    func showError(_ error: String) {
        func showError(_ error: String) {
            self.router.showErrorAlert(error)
        }
    }
    
    func showSuccess() {
        self.router.showSuccessAlert { [ weak self ] in
            self?.router.popToRoot()
        }
    }
}

private extension NewSegmentViewController {
    
    func setSaveButtonTappedHandler() {
        self.mainView.saveButtonTappedHandler = { [ weak self ] segment in
            self?.interactor.createChart(segment)
//            self?.router.dismiss()
        }
    }
}
