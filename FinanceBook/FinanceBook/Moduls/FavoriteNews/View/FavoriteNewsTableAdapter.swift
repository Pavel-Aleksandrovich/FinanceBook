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
    var onCellTappedHandler: ((Article) -> ())? { get set }
    var scrollDidEndHandler: (() -> ())? { get set }
    func setNews(_ news: News)
}

final class FavoriteNewsTableAdapter: NSObject {
    
    private var isLoading = false
    private var articleArray: [Article] = [Article(title: "Article")]
    var onCellTappedHandler: ((Article) -> ())?
    var scrollDidEndHandler: (() -> ())?
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
    
    func setNews(_ news: News) {
        self.articleArray.append(contentsOf: news.articles)
        self.tableView?.reloadData()
    }
}

extension FavoriteNewsTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        articleArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteNewsCell.id,
                                                       for: indexPath) as? FavoriteNewsCell else { return UITableViewCell() }
        
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
