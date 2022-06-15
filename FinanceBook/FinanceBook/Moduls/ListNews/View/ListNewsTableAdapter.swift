//
//  ListNewsTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol ListNewsTableAdapterDelegate: AnyObject {
    func loadImageData(url: String?, complition: @escaping(Data) -> ())
}

protocol IListNewsTableAdapter: AnyObject {
    var delegate: ListNewsTableAdapterDelegate? { get set }
    var tableView: UITableView? { get set }
    var onCellTappedHandler: ((Article) -> ())? { get set }
    var scrollDidEndHandler: (() -> ())? { get set }
    func setNews(_ news: News)
}

final class ListNewsTableAdapter: NSObject {
    
    private var articleArray: [Article] = []
    var onCellTappedHandler: ((Article) -> ())?
    var scrollDidEndHandler: (() -> ())?
    var delegate: ListNewsTableAdapterDelegate?
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
    
    func setNews(_ news: News) {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
//            self.scrollDidEndHandler?()
//            print(88)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListNewsCell.id,
                                                       for: indexPath) as? ListNewsCell else { return UITableViewCell() }
        
        let article = articleArray[indexPath.row]
        cell.update(article: article)
        self.delegate?.loadImageData(url: article.urlToImage, complition: { imageData in
            cell.setImage(data: imageData)
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articleArray[indexPath.row]
        self.onCellTappedHandler?(article)
    }
}
