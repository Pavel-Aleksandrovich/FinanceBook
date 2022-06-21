//
//  ListNewsTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol ListNewsTableAdapterDelegate: AnyObject {
    func loadImageData(url: String?, complition: @escaping(UIImage?) -> ())
}

protocol IListNewsTableAdapter: AnyObject {
    var delegate: ListNewsTableAdapterDelegate? { get set }
    var tableView: UITableView? { get set }
    var onCellTappedHandler: ((NewsRequest) -> ())? { get set }
    func setNews(_ news: NewsDTO)
    func clearData()
}

final class ListNewsTableAdapter: NSObject {
    
    private var articleArray: [Article] = []
    
    var onCellTappedHandler: ((NewsRequest) -> ())?
    
    weak var delegate: ListNewsTableAdapterDelegate?
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.register(ListNewsCell.self,
                                     forCellReuseIdentifier: ListNewsCell.id)
        }
    }
}

extension ListNewsTableAdapter: IListNewsTableAdapter {
    
    func clearData() {
        self.articleArray.removeAll()
        self.tableView?.reloadData()
    }
    
    func setNews(_ news: NewsDTO) {
        self.articleArray.append(contentsOf: news.articles)
        self.tableView?.reloadData()
    }
}

extension ListNewsTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        articleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListNewsCell.id,
                                                       for: indexPath) as? ListNewsCell
        else { return UITableViewCell() }
        
        let article = articleArray[indexPath.row]
        
        cell.update(article: article)
        self.delegate?.loadImageData(url: article.urlToImage, complition: { image in
            cell.setImage(image)
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articleArray[indexPath.row]
        
        guard let title = article.title,
              let desctiption = article.description,
              let imageUrl = article.urlToImage else { return }
        
        let viewModel = NewsRequest(title: title,
                                                desctiption: desctiption,
                                                imageUrl: imageUrl)
        self.onCellTappedHandler?(viewModel)
    }
}
