//
//  HistoryView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit
import SnapKit

protocol IHistoryView: AnyObject {
    func setHistory(_ chart: [HistoryModel])
    func setImageViewState(_ state: Bool)
    func setTitleForDateLabel(_ title: String)
    func updateChart(_ chart: [[HistoryModel]])
}

final class HistoryView: UIView {
    
    private enum Constants {
        static let chartMultiplied = 0.8
    }
    
    private let switchTableStateButton = UIButton()
    private let pieChartView = HistoryChart()
    private let tableView = UITableView()
    private let defaultView = DefaultHistoryView()
    private let scrollView = UIScrollView()
    private let layout = UICollectionViewFlowLayout()
    
    private let dateLayout = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: self.layout)
    private lazy var dateCollectionView = UICollectionView(frame: .zero,
                                                           collectionViewLayout: self.dateLayout)
    private lazy var selectedDateView = DateView { type in self.onDateViewTappedHandler?(type) }
    
    private lazy var dateCollectionAdapter = DateCollectionAdapter { type in
        self.onDateCellTappedHandler?(type) }
    
    private lazy var tableAdapter = TableAdapter { id in
        self.onCellDeleteHandler?(id) }
    
    private lazy var historyTableAdapter = HistoryTableAdapter { id in
        print("")
    }
    
    private lazy var collectionAdapter = ProfitCollectionAdapter { type in
        self.onCellTappedHandler?(type) }
    
    var onCellDeleteHandler: ((UUID) -> ())?
    var onCellTappedHandler: ((Profit) -> ())?
    var onDateCellTappedHandler: ((DateCollectionAdapter.DateType) -> ())?
    var onDateViewTappedHandler: ((DateView.TapState) -> ())?
    var onButtonTappedHandler: (() -> ())?
    
    init() {
        super.init(frame: .zero)
        self.configAppearance()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryView: IHistoryView {
    
    func setHistory(_ history: [HistoryModel]) {
        self.tableAdapter.setHistory(history)
        self.tableView.reloadData()
    }
    
    func updateChart(_ chart: [[HistoryModel]]) {
        self.pieChartView.updateChart(chart)
        self.historyTableAdapter.setHistory(chart)
    }
    
    func setImageViewState(_ state: Bool) {
        self.defaultView.isHidden = state
    }
    
    func setTitleForDateLabel(_ title: String) {
        self.selectedDateView.setTitleForDateLabel(title)
    }
}

// MARK: - Config Appearance
private extension HistoryView {
    
    func configAppearance() {
        self.configView()
        self.configSwitchTableStateButton()
        self.configTableView()
        self.configScrollView()
        self.configLayout()
        self.configCollectionView()
        self.configDateLayout()
        self.configDateCollectionView()
    }
    
    func configView() {
        self.backgroundColor = .white
    }
    
    func configSwitchTableStateButton() {
        self.switchTableStateButton.backgroundColor = .gray
        self.switchTableStateButton.layer.cornerRadius = 25
        self.switchTableStateButton.clipsToBounds = true
        self.switchTableStateButton.addTarget(self,
                                              action: #selector
                                              (self.onButtonTapped),
                                              for: .touchUpInside)
    }
    
    @objc func onButtonTapped() {
        self.onButtonTappedHandler?()
        
        self.tableView.delegate = self.historyTableAdapter
        self.tableView.dataSource = self.historyTableAdapter
        self.tableView.register(HistoryCell.self,
                                forCellReuseIdentifier: HistoryCell.id)
        self.tableView.reloadData()
    }
    
    func configTableView() {
        self.tableView.allowsSelection = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self.tableAdapter
        self.tableView.dataSource = self.tableAdapter
        self.tableView.register(TableAdapterCell.self,
                                forCellReuseIdentifier: TableAdapterCell.id)
    }
    
    func configScrollView() {
        self.scrollView.showsVerticalScrollIndicator = false
    }
    
    func configLayout() {
        self.layout.minimumInteritemSpacing = 0
        self.layout.minimumLineSpacing = 0
        self.layout.scrollDirection = .horizontal
    }
    
    func configCollectionView() {
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(ProfitCollectionCell.self,
                                     forCellWithReuseIdentifier: ProfitCollectionCell.id)
        self.collectionView.dataSource = self.collectionAdapter
        self.collectionView.delegate = self.collectionAdapter
        self.collectionView.selectItem(at: [0, 0],
                                       animated: true,
                                       scrollPosition: [])
    }
    
    func configDateLayout() {
        self.dateLayout.minimumInteritemSpacing = 0
        self.dateLayout.minimumLineSpacing = 0
        self.dateLayout.scrollDirection = .horizontal
    }
    
    func configDateCollectionView() {
        self.dateCollectionView.backgroundColor = .clear
        self.dateCollectionView.showsHorizontalScrollIndicator = false
        self.dateCollectionView.register(DateCollectionCell.self,
                                         forCellWithReuseIdentifier: DateCollectionCell.id)
        self.dateCollectionView.dataSource = self.dateCollectionAdapter
        self.dateCollectionView.delegate = self.dateCollectionAdapter
        self.dateCollectionView.selectItem(at: [0, 0],
                                           animated: true,
                                           scrollPosition: [])
    }
}

// MARK: - Make Constraints
private extension HistoryView {
    
    func makeConstraints() {
        self.makeScrollViewConstraints()
        self.makeCollectionViewConstraints()
        self.makeDateCollectionViewConstraints()
        self.makeSelectedDateViewConstraints()
        self.makeChartConstraints()
        self.makeSwitchTableStateButtonConstraints()
        self.makeTableViewConstraints()
        self.makeDefaultViewConstraints()
    }
    
    func makeScrollViewConstraints() {
        self.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func makeCollectionViewConstraints() {
        self.scrollView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
    
    func makeDateCollectionViewConstraints() {
        self.scrollView.addSubview(self.dateCollectionView)
        self.dateCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.collectionView.snp.bottom).inset(-10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.centerX.equalTo(self.scrollView.snp.centerX)
        }
    }
    
    func makeSelectedDateViewConstraints() {
        self.scrollView.addSubview(self.selectedDateView)
        self.selectedDateView.snp.makeConstraints { make in
            make.top.equalTo(self.dateCollectionView.snp.bottom).inset(-10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.centerX.equalTo(self.scrollView.snp.centerX)
        }
    }
    
    func makeChartConstraints() {
        self.scrollView.addSubview(self.pieChartView)
        self.pieChartView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.selectedDateView.snp.bottom).inset(-20)
            make.width.equalTo(self.snp.width).multipliedBy(Constants.chartMultiplied)
            make.height.equalTo(self.pieChartView.snp.width)
        }
    }
    
    func makeSwitchTableStateButtonConstraints() {
        self.scrollView.addSubview(self.switchTableStateButton)
        self.switchTableStateButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(self.pieChartView.snp.bottom).inset(-10)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(50)
        }
    }
    
    func makeTableViewConstraints() {
        self.scrollView.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.switchTableStateButton.snp.bottom).inset(-10)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height - 200)
        }
    }
    
    func makeDefaultViewConstraints() {
        self.addSubview(self.defaultView)
        self.defaultView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.selectedDateView.snp.bottom)
        }
    }
}
