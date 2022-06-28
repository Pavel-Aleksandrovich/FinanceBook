//
//  ListNewsTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

enum ListNewsState {
    case success
    case loading
    case noInternet
}

protocol ListNewsTableAdapterDelegate: AnyObject {
    func loadImageData(url: String, completion: @escaping(UIImage) -> ())
}

protocol IListNewsTableAdapter: AnyObject {
    var delegate: ListNewsTableAdapterDelegate? { get set }
    var tableView: UITableView? { get set }
    var onCellTappedHandler: ((NewsRequest) -> ())? { get set }
    func setState(_ state: ListNewsState)
    func setData(_ array: [NewsViewModel])
}

final class ListNewsTableAdapter: NSObject {
    
    private enum Constants {
        static let numberOfRowsForLoading = 1
        static let heightRowForSuccess: CGFloat = 150
    }
    
    private var dataArray: [NewsViewModel] = []
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
    
    func setData(_ array: [NewsViewModel]) {
        switch self.state {
        case .success:
            self.dataArray.append(contentsOf: array)
        case .loading:
            self.state = .success
            self.dataArray.append(contentsOf: array)
        case .noInternet:
            self.state = .success
        }
        
        self.tableView?.reloadData()
    }
    
    func setState(_ state: ListNewsState) {
        self.state = state
        self.tableView?.reloadData()
    }
}

extension ListNewsTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if case .noInternet = state {
            return 2
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch self.state {
        case .success: return self.dataArray.count
        case .loading: return Constants.numberOfRowsForLoading
        case .noInternet:
            switch section {
            case 0: return self.dataArray.count
            case 1: return 1
            default: return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.state {
        case .success: return Constants.heightRowForSuccess
        case .loading: return UIScreen.main.bounds.size.height * 0.8
        case .noInternet: return Constants.heightRowForSuccess
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.state {
        case .success:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ListNewsCell.id,
                for: indexPath) as? ListNewsCell
            else { return UITableViewCell() }
            
            let article = self.dataArray[indexPath.row]
            
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
            
            cell.startLoading()
            
            return cell
        case .noInternet:
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ListNewsCell.id,
                    for: indexPath) as? ListNewsCell
                else { return UITableViewCell() }
                
                let article = self.dataArray[indexPath.row]
                
                cell.update(article: article)
                self.delegate?.loadImageData(url: article.urlToImage,
                                             completion: { image in
                    cell.setImage(image)
                })
                
                return cell
            case 1:
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ListNewsInternetCell.id,
                    for: indexPath) as? ListNewsInternetCell
                else { return UITableViewCell() }
                
                return cell
            default: return UITableViewCell()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch self.state {
        case .success:
            let article = self.dataArray[indexPath.row]
            
            let viewModel = NewsRequest(title: article.title,
                                        desctiption: article.description,
                                        imageUrl: article.urlToImage)
            
            self.onCellTappedHandler?(viewModel)
        case .loading: break
        case .noInternet: break
        }
    }
}
