//
//  NewsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class NewsViewController: UITableViewController {
    
    let service = NewsService()
    private var imageService: ImageService?
    
    var isSeeMore = false
    
    var isNewsLoading = false
    var nextFrom = ""
    var newsResponse: ResponseClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        imageService = ImageService(container: tableView)
        
        setupRefreshControl()
        loadNews()
        
        tableView.register(OwnerNewsCell.nib(), forCellReuseIdentifier: OwnerNewsCell.identifier)
        tableView.register(TextInNewsCell.self, forCellReuseIdentifier: "TextInNewsCell")
        tableView.register(PhotosInNewsCell.self, forCellReuseIdentifier: "PhotosInNewsCell")
        tableView.register(BottomOfNewsCell.nib(), forCellReuseIdentifier: BottomOfNewsCell.identifier)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsResponse?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var currentNewsItem = newsResponse.items[indexPath.section]
        let postOwner = newsResponse.profiles.first(where: { $0.id == currentNewsItem.sourceID })
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerNewsCell", for: indexPath) as? OwnerNewsCell else { preconditionFailure("OwnerNewsCell cannot") }
            cell.selectionStyle = .none
            
            let url = URL(string: postOwner?.photo100 ?? "")
            self.service.imageLoader(url: url) { image in
                DispatchQueue.main.async {
                    cell.configure(with: image, name: (postOwner?.firstName ?? "1name") + " " + (postOwner?.lastName ?? "2name"), dateOfNews: currentNewsItem.getStringDate())
                }
            }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextInNewsCell.identifier, for: indexPath) as? TextInNewsCell else { preconditionFailure("TextInNewsCell cannot") }
            let labelFont = UIFont.systemFont(ofSize: 18)
            cell.configure(currentNewsItem.text, labelHeight: DynamicLabelHeight.height(text: currentNewsItem.text, font: labelFont, width: view.frame.width), vc: self, indexPath: indexPath)
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosInNewsCell", for: indexPath) as? PhotosInNewsCell else { preconditionFailure("PhotosInNewsCell cannot") }
            guard let urlImage = currentNewsItem.photosURL?.last else { return UITableViewCell() }
            let image = imageService?.photo(atIndexPath: indexPath, byUrl: urlImage)
            cell.configureNewsAttachmentsCell(image: (image ?? UIImage(named: "not photo"))!)
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomOfNewsCell.identifier, for: indexPath) as? BottomOfNewsCell else { preconditionFailure("BottomOfNewsCell cannot") }
            cell.selectionStyle = .none
            cell.configure(with: currentNewsItem)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @objc func tapToLike() {
        print("like tapped")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = newsResponse.items[indexPath.section]
        switch indexPath.row {
        case 0:
            return UITableView.automaticDimension
        case 1:
            guard let isTextEmpty = post.text?.isEmpty else { return 0 }
            let font = UIFont.systemFont(ofSize: 18)
            if isTextEmpty {
                return 0
            }
            return post.isTextShowMore ? DynamicLabelHeight.height(text: post.text, font: font, width: view.frame.width) : DynamicLabelHeight.heightTwoLines(text: post.text, font: font, width: view.frame.width)
        case 2:
            guard let urls = newsResponse.items[indexPath.section].photosURL,
                    !urls.isEmpty else { return 0 }
            let width = view.frame.width
            let cellHeight = width * post.aspectRatio
            return cellHeight
        case 3:
            return UITableView.automaticDimension
            
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        
        let separatorView = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.width, height: UIScreen.main.scale))
        separatorView.backgroundColor = .systemGray5
        
        return separatorView
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let separatorView = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.width, height: UIScreen.main.scale))
        separatorView.backgroundColor = .systemGray5

        return separatorView
    }
}

// MARK: - Infinite Scrolling - loading news
extension NewsViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        if maxSection > newsResponse.items.count - 5,
           !isNewsLoading,
           nextFrom != "" {
            self.isNewsLoading = true
            self.service.loadNews(nextFrom: self.nextFrom) { [weak self] result in
                switch result {
                case .failure(let error):
                    print("can not append news", error)
                case .success(let news):
                    guard let self = self else { return }
                    let indexSet = IndexSet(integersIn: self.newsResponse.items.count..<self.newsResponse.items.count + news.items.count)
                    self.newsResponse.items.append(contentsOf: news.items)
                    self.newsResponse.profiles.append(contentsOf: news.profiles)
                    self.nextFrom = news.nextFrom ?? ""
                    self.tableView.insertSections(indexSet, with: .none)
                    self.isNewsLoading = false
                }
            }
        }
    }
}


// MARK: - Private
private extension NewsViewController {
    ///Загрузка массива новостей
    func loadNews() {
        service.loadNews { [weak self] result in
            switch result {
            case .failure(let error):
                print("news error = ", error)
            case .success(let news):
                self?.newsResponse = news
                DispatchQueue.main.async {
                    self?.nextFrom = news.nextFrom ?? ""
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func isLikeCheck(itemId: Int) {
        service.checkIsLike(itemId: itemId) { [weak self] result in
            switch result {
            case .failure(let error):
                print("isLike error = ", error)
            case .success(let isLike):
                var isLikeBool = false
                if isLike.liked == 1 {
                    isLikeBool = true
                }
                DispatchQueue.global().async {
                    
                }
            }
        }
    }
    
    func setupRefreshControl() {
        self.tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .allEvents)
    }
    
    @objc func refreshNews() {
        self.loadNews()
        self.tableView.refreshControl?.endRefreshing()
    }
}
