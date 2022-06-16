//
//  FavoriteNewsTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

protocol FavoriteNewsTableAdapterDelegate: AnyObject {
    func loadImageData(url: String?, complition: @escaping(Data) -> ())
}

protocol IFavoriteNewsTableAdapter: AnyObject {
    var delegate: FavoriteNewsTableAdapterDelegate? { get set }
    var tableView: UITableView? { get set }
    var onCellTappedHandler: ((NewsResponse) -> ())? { get set }
    var onCellDeleteHandler: ((NewsResponse) -> ())? { get set }
    func setFavoriteNews(_ news: [NewsResponse])
    func deleteNewsAt(_ id: UUID)
}

final class FavoriteNewsTableAdapter: NSObject {
    
    private var articleArray: [NewsResponse] = []
    var onCellTappedHandler: ((NewsResponse) -> ())?
    var onCellDeleteHandler: ((NewsResponse) -> ())?
    weak var delegate: FavoriteNewsTableAdapterDelegate?
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.register(FavoriteNewsCell.self,
                                     forCellReuseIdentifier: FavoriteNewsCell.id)
        }
    }
}

extension FavoriteNewsTableAdapter: IFavoriteNewsTableAdapter {
    
    func deleteNewsAt(_ id: UUID) {
        let index = self.articleArray.firstIndex { $0.id == id }
        if let index = index {
            self.articleArray.remove(at: index)
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView?.deleteRows(at: [indexPath], with: .fade)
            self.tableView?.reloadData()
        }
    }
    
    func setFavoriteNews(_ news: [NewsResponse]) {
        self.articleArray = news
        self.tableView?.reloadData()
    }
}

extension FavoriteNewsTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        articleArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteNewsCell.id,
                                                       for: indexPath) as? FavoriteNewsCell else { return UITableViewCell() }
        
        let news = articleArray[indexPath.row]
        cell.update(article: news)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articleArray[indexPath.row]
        self.onCellTappedHandler?(article)
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
            self.onCellDeleteHandler?(articleArray[indexPath.row])
        }
    }
}
