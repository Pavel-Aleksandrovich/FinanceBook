//
//  FavoriteNewsTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

enum FavoriteNewsState {
    case success([FavoriteNewsViewModel])
    case empty
}

protocol IFavoriteNewsTableAdapter: AnyObject {
    var tableView: UITableView? { get set }
    var onCellDeleteHandler: ((FavoriteNewsRequest) -> ())? { get set }
    func setFavoriteNewsState(_ state: FavoriteNewsState)
}

final class FavoriteNewsTableAdapter: NSObject {
    
    private enum Constants {
        static let numberOfRows = 1
        static let heightRow: CGFloat = 150
    }
    
    private var state: FavoriteNewsState = .empty
    
    var onCellDeleteHandler: ((FavoriteNewsRequest) -> ())?
    
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
        }
    }
}

extension FavoriteNewsTableAdapter: IFavoriteNewsTableAdapter {
    
    func setFavoriteNewsState(_ state: FavoriteNewsState) {
        self.state = state
        self.tableView?.reloadData()
    }
}

extension FavoriteNewsTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch self.state {
        case .success(let array): return array.count
        case .empty: return Constants.numberOfRows
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.state {
        case .success(_): return Constants.heightRow
        case .empty: return UIScreen.main.bounds.size.height * 0.8
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.state {
        case .success(let array):
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FavoriteNewsCell.id,
                for: indexPath) as? FavoriteNewsCell
            else { return UITableViewCell() }
            
            let news = array[indexPath.row]
            cell.update(article: news)
            
            return cell
        case .empty:
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FavoriteNewsDefaultCell.id,
                for: indexPath) as? FavoriteNewsDefaultCell
            else { return UITableViewCell() }
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool {
        switch self.state {
        case .success(_): return true
        case .empty: return false
        }
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        switch self.state {
        case .success(let array):
            if editingStyle == .delete {
                let news = array[indexPath.row]
                let request = FavoriteNewsRequest(viewModel: news)
                self.onCellDeleteHandler?(request)
            }
        case .empty: break
        }
    }
}
