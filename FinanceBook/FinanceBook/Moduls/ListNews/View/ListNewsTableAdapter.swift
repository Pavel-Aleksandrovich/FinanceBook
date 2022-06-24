//
//  ListNewsTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

enum ListNewsState {
    case success([NewsViewModel])
    case loading
}

protocol ListNewsTableAdapterDelegate: AnyObject {
    func loadImageData(url: String, completion: @escaping(UIImage) -> ())
}

protocol IListNewsTableAdapter: AnyObject {
    var delegate: ListNewsTableAdapterDelegate? { get set }
    var tableView: UITableView? { get set }
    var onCellTappedHandler: ((NewsRequest) -> ())? { get set }
    func setNewsState(_ state: ListNewsState)
}

final class ListNewsTableAdapter: NSObject {
    
    private enum Constants {
        static let numberOfRowsForLoading = 1
        static let heightRowForSuccess: CGFloat = 150
    }
    
    private var state: ListNewsState = .loading
    
    var onCellTappedHandler: ((NewsRequest) -> ())?
    
    weak var delegate: ListNewsTableAdapterDelegate?
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
        }
    }
}

extension ListNewsTableAdapter: IListNewsTableAdapter {
    
    func setNewsState(_ state: ListNewsState) {
        self.state = state
        self.tableView?.reloadData()
    }
}

extension ListNewsTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch self.state {
        case .success(let array): return array.count
        case .loading: return Constants.numberOfRowsForLoading
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.state {
        case .success(_): return Constants.heightRowForSuccess
        case .loading: return UIScreen.main.bounds.size.height * 0.8
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.state {
        case .success(let array):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ListNewsCell.id,
                for: indexPath) as? ListNewsCell
            else { return UITableViewCell() }
            
            let article = array[indexPath.row]
            
            cell.update(article: article)
            self.delegate?.loadImageData(url: article.urlToImage,
                                         completion: { image in
                cell.setImage(image)
            })
            
            return cell
        case .loading:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ListNewsLoadingCell.id,
                for: indexPath) as? ListNewsLoadingCell
            else { return UITableViewCell() }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch self.state {
        case .success(let array):
            let article = array[indexPath.row]
            
            let viewModel = NewsRequest(title: article.title,
                                        desctiption: article.description,
                                        imageUrl: article.urlToImage)
            
            self.onCellTappedHandler?(viewModel)
        case .loading: break
        }
    }
}
