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
    
    var newsResponse: ResponseClass!
    
    var newsOwner = User(id: 0, photo200_Orig: "", hasMobile: 0, isFriend: 0, about: "", status: "", lastSeen: .init(platform: 0, time: 0), followersCount: 0, online: 0, firstName: "", lastName: "", canAccessClosed: true, isClosed: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageService = ImageService(container: tableView)
        
        loadNews()
        
        tableView.register(OwnerNewsCell.nib(), forCellReuseIdentifier: OwnerNewsCell.identifier)
        tableView.register(TextInNewsCell.nib(), forCellReuseIdentifier: TextInNewsCell.identifier)
        tableView.register(PhotosInNewsCell.self, forCellReuseIdentifier: "PhotosInNewsCell")
        tableView.register(BottomOfNewsCell.nib(), forCellReuseIdentifier: BottomOfNewsCell.identifier)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsResponse?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentNewsItem = newsResponse.items[indexPath.section]
        let postOwner = newsResponse.profiles.first(where: { $0.id == currentNewsItem.sourceID })
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerNewsCell", for: indexPath) as? OwnerNewsCell else { preconditionFailure("OwnerNewsCell cannot") }
            let url = URL(string: postOwner?.photo100 ?? "")
                self.service.imageLoader(url: url) { image in
                    DispatchQueue.main.async {
                        cell.configure(with: image, name: (postOwner?.firstName ?? "1name") + " " + (postOwner?.lastName ?? "2name"), dateOfNews: currentNewsItem.getStringDate())
                    }
                }
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextInNewsCell.identifier, for: indexPath) as? TextInNewsCell else { preconditionFailure("TextInNewsCell cannot") }
            cell.configure(with: "\(currentNewsItem.text ?? "")")
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosInNewsCell", for: indexPath) as? PhotosInNewsCell else { preconditionFailure("PhotosInNewsCell cannot") }
            
            guard let urlImage = currentNewsItem.photosURL?.first else { return UITableViewCell() }
            let image = imageService?.photo(atIndexPath: indexPath, byUrl: urlImage)
            cell.configureNewsAttachmentsCell(image: (image ?? UIImage(named: "not photo"))!)
            
            return cell
            
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomOfNewsCell.identifier, for: indexPath) as? BottomOfNewsCell else { preconditionFailure("BottomOfNewsCell cannot") }
            cell.configure(with: "\(currentNewsItem.likes?.count ?? 0)", comments: "\(currentNewsItem.comments?.count ?? 0)", reposts: "\(currentNewsItem.views?.count ?? 0)")
            return cell
            
        default:
            return UITableViewCell()
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
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
