//
//  ListNewsTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol ListNewsTableAdapterDelegate: AnyObject {
    func loadImageData(url: String?, completion: @escaping(UIImage?) -> ())
}

protocol IListNewsTableAdapter: AnyObject {
    var delegate: ListNewsTableAdapterDelegate? { get set }
    var tableView: UITableView? { get set }
    var onCellTappedHandler: ((NewsRequest) -> ())? { get set }
    func setNewsState(_ state: NewsState)
}
enum NewsState {
    case success([Article])
    case error(String)
}
final class ListNewsTableAdapter: NSObject {
    
    var onCellTappedHandler: ((NewsRequest) -> ())?
    
    weak var delegate: ListNewsTableAdapterDelegate?
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
        }
    }
    
    private var state: NewsState = .error("loading loading loading")
}

extension ListNewsTableAdapter: IListNewsTableAdapter {
    
    func setNewsState(_ state: NewsState) {
        self.state = state
        self.tableView?.reloadData()
    }
}

extension ListNewsTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch self.state {
        case .success(let array):
            return array.count
        case .error(_):
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.state {
        case .success(_):
            return 150
        case .error(_):
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.state {
        case .success(let array):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListNewsCell.id,
                                                           for: indexPath) as? ListNewsCell
            else { return UITableViewCell() }
            
            let article = array[indexPath.row]
            
            cell.update(article: article)
            self.delegate?.loadImageData(url: article.urlToImage, completion: { image in
                cell.setImage(image)
            })
            
            return cell
        case .error(let error):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListNewsErrorCell.id,
                                                           for: indexPath) as? ListNewsErrorCell
            else { return UITableViewCell() }
            
            cell.update(error: error)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch self.state {
        case .success(let array):
            let article = array[indexPath.row]
            
            guard let title = article.title,
                  let desctiption = article.description,
                  let imageUrl = article.urlToImage else { return }
            
            let viewModel = NewsRequest(title: title,
                                        desctiption: desctiption,
                                        imageUrl: imageUrl)
            
            self.onCellTappedHandler?(viewModel)
        case .error(_): break
        }
        
    }
}
