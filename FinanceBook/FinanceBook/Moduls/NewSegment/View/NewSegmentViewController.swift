//
//  NewSegmentViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol INewSegmentViewController: AnyObject {
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
        self.createExitBarButton()
        self.setSaveButtonTappedHandler()
    }
}

extension NewSegmentViewController: INewSegmentViewController {
}

private extension NewSegmentViewController {
    
    func setSaveButtonTappedHandler() {
        self.mainView.saveButtonTappedHandler = {
            print("save tapped")
            self.router.dismiss()
        }
    }
    
    func createExitBarButton() {
        let image = UIImage(systemName: "xmark.circle")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(exitButtonTapped))
    }
    
    @objc func exitButtonTapped() {
        self.router.dismiss()
    }
}
