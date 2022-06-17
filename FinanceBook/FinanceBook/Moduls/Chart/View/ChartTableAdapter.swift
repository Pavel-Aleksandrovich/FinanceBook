//
//  ChartTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol ChartTableAdapterDelegate: AnyObject {
    func loadImageData(url: String?, complition: @escaping(Data) -> ())
}

protocol IChartTableAdapter: AnyObject {
    var delegate: ChartTableAdapterDelegate? { get set }
    var tableView: UITableView? { get set }
    var onCellTappedHandler: ((NewsResponse) -> ())? { get set }
    var onCellDeleteHandler: ((NewsResponse) -> ())? { get set }
    func setCharts(_ chart: [ChartDTO])
}

final class ChartTableAdapter: NSObject {
    
    private var articleArray: [ChartDTO] = []
    var onCellTappedHandler: ((NewsResponse) -> ())?
    var onCellDeleteHandler: ((NewsResponse) -> ())?
    weak var delegate: ChartTableAdapterDelegate?
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.register(ChartCell.self,
                                     forCellReuseIdentifier: ChartCell.id)
        }
    }
}

extension ChartTableAdapter: IChartTableAdapter {

    func setCharts(_ chart: [ChartDTO]) {
        self.articleArray = chart
        self.tableView?.reloadData()
    }
}

extension ChartTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        articleArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChartCell.id,
                                                       for: indexPath) as? ChartCell else { return UITableViewCell() }
        
        let news = articleArray[indexPath.row]
        cell.update(article: news)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articleArray[indexPath.row]
//        self.onCellTappedHandler?(article)
    }
    
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let employeeRequest = EmployeeRequest(employee: employeeArray[indexPath.row])
//            self.onCellDeleteHandler?(articleArray[indexPath.row])
        }
    }
}
