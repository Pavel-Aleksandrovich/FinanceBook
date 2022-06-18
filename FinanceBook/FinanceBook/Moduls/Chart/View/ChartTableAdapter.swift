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
    var onCellDeleteHandler: ((ChartDTO ,SegmentDTO) -> ())? { get set }
    func setCharts(_ chart: [ChartDTO])
}

final class ChartTableAdapter: NSObject {
    
    private var articleArray: [ChartDTO] = []
    var onCellTappedHandler: ((NewsResponse) -> ())?
    var onCellDeleteHandler: ((ChartDTO ,SegmentDTO) -> ())?
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
//        onCellDeleteHandler?(articleArray[2])
    }
}

extension ChartTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.articleArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        articleArray[section].segment.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        articleArray[indexPath.section].expanded ? 40 : 0
    }
    
    func tableView(_ tableView: UITableView,
                            heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChartCell.id,
                                                       for: indexPath) as? ChartCell else { return UITableViewCell() }
        
        let news = articleArray[indexPath.section].segment[indexPath.row]
        cell.update(article: news)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articleArray[indexPath.row]
        print(indexPath.section)
        print(indexPath.row)
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
            let chart = articleArray[indexPath.section]
            let segment = chart.segment[indexPath.row]
            self.onCellDeleteHandler?(chart, segment)
        }
    }
    
    func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        print(#function)
        let header = ChartHeaderView()
        let amount = articleArray[section].amount
        
        header.setup(withTitle: "\(amount)",section: section, delegate: self)
        return header
    }
}

extension ChartTableAdapter: ChartHeaderViewDelegate {
    
    func toggleSection(header: ChartHeaderView, section: Int) {
        
        articleArray[section].expanded = !articleArray[section].expanded
        
        tableView?.beginUpdates()
        for row in 0..<articleArray[section].segment.count {
            tableView?.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        tableView?.endUpdates()
    }
}
