//
//  CategoryView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import UIKit

protocol IListCategoryView: AnyObject {
    func getViewModel() -> CategoryType?
    func updateSaveButtonState(_ state: Bool)
    func showShakeAnimation()
}

final class ListCategoryView: UIView {
    
    private enum Constants {
    }
    
    private let saveButton = UIButton()
    private let tableView = UITableView()
    private let categoryTableAdapter = ListCategoryTableAdapter()
    private let profitLayout = UICollectionViewFlowLayout()
    private let profitCollectionAdapter = ProfitCollectionAdapter()
    
    private lazy var profitCollectionView = UICollectionView(frame: .zero,
                                                             collectionViewLayout: self.profitLayout)
    
    var saveButtonTappedHandler: (() -> ())?
    var onCellTappedHandler: ((CategoryType?) -> ())?
    
    init() {
        super.init(frame: .zero)
        self.configAppearance()
        self.makeConstraints()
        self.setHandlers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCategoryView: IListCategoryView {
    
    func getViewModel() -> CategoryType? {
        return self.categoryTableAdapter.model
    }
    
    func updateSaveButtonState(_ state: Bool) {
        switch state {
        case true:
            self.saveButton.alpha = 1
        case false:
            self.saveButton.alpha = 0.3
        }
    }
    
    func showShakeAnimation() {
        self.createShakeAnimation()
    }
}

// MARK: - Config Appearance
private extension ListCategoryView {
    
    func configAppearance() {
        self.configProfitLayout()
        self.configProfitCollectionView()
        self.configView()
        self.configTableView()
        self.configSaveButton()
    }
    
    func configView() {
        self.backgroundColor = .white
    }
    
    func configSaveButton() {
        self.saveButton.alpha = 0.3
        self.saveButton.backgroundColor = .gray
        self.saveButton.layer.cornerRadius = 10
        self.saveButton.backgroundColor = MainAttributs.color
        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.setTitleColor(.white, for: .normal)
        self.saveButton.clipsToBounds = true
        self.saveButton.addTarget(self,
                                  action: #selector(self.saveButtonTapped),
                                  for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        self.saveButtonTappedHandler?()
    }
    
    func configProfitLayout() {
        self.profitLayout.minimumInteritemSpacing = 0
        self.profitLayout.minimumLineSpacing = 0
        self.profitLayout.scrollDirection = .horizontal
    }
    
    func configProfitCollectionView() {
        self.profitCollectionView.backgroundColor = .clear
        self.profitCollectionView.showsHorizontalScrollIndicator = false
        self.profitCollectionView.register(ProfitCollectionCell.self,
                                           forCellWithReuseIdentifier: ProfitCollectionCell.id)
        self.profitCollectionView.dataSource = self.profitCollectionAdapter
        self.profitCollectionView.delegate = self.profitCollectionAdapter
        self.profitCollectionView.selectItem(at: [0, 0],
                                             animated: true,
                                             scrollPosition: [])
    }
    
    func configTableView() {
        self.tableView.delegate = self.categoryTableAdapter
        self.tableView.dataSource = self.categoryTableAdapter
        self.tableView.register(ListCategoryCell.self,
                                forCellReuseIdentifier: ListCategoryCell.id)
    }
}

// MARK: - Make Constraints
private extension ListCategoryView {
    
    func makeConstraints() {
        self.makeProfitCollectionViewConstraints()
        self.makeSaveButtonConstraints()
        self.makeTableViewConstraints()
    }
    
    func makeProfitCollectionViewConstraints() {
        self.addSubview(self.profitCollectionView)
        self.profitCollectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
    
    func makeSaveButtonConstraints() {
        self.addSubview(self.saveButton)
        self.saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(50)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
    }
    
    func makeTableViewConstraints() {
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.saveButton.snp.top).inset(-10)
            make.top.equalTo(self.profitCollectionView.snp.bottom).inset(-10)
        }
    }
}

// MARK: - Set Handlers
private extension ListCategoryView {
    
    func setHandlers() {
        self.onProfitCollectionAdapterCellTapped()
        self.setOnCellTappedHandler()
    }
    
    func onProfitCollectionAdapterCellTapped() {
        self.profitCollectionAdapter.didSelectState { result in
            self.categoryTableAdapter.didSelectType(result)
            self.tableView.reloadData()
        }
    }
    
    func setOnCellTappedHandler() {
        self.categoryTableAdapter.setStateListener { model in
            self.onCellTappedHandler?(model)
        }
    }
}

private extension ListCategoryView {
    
    func createShakeAnimation() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shakeAnimation.values = [0, -15, 15, -15, 15, 0]
        shakeAnimation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        shakeAnimation.duration = 0.4
        shakeAnimation.isAdditive = true
        self.saveButton.layer.add(shakeAnimation, forKey: nil)
    }
}
