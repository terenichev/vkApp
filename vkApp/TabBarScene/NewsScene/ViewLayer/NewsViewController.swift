//
//  NewsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class NewsViewController: UITableViewController {
    
    let service = NewsService()
    var newsResponse: ResponseClass!
    
    var newsOwner = User(id: 0, photo200_Orig: "", hasMobile: 0, isFriend: 0, about: "", status: "", lastSeen: .init(platform: 0, time: 0), followersCount: 0, online: 0, firstName: "", lastName: "", canAccessClosed: true, isClosed: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNews()
        
        
        tableView.register(OwnerNewsCell.nib(), forCellReuseIdentifier: OwnerNewsCell.identifier)
        tableView.register(TextInNewsCell.nib(), forCellReuseIdentifier: TextInNewsCell.identifier)
        tableView.register(PhotosInNewsCell.nib(), forCellReuseIdentifier: PhotosInNewsCell.identifier)
        tableView.register(BottomOfNewsCell.nib(), forCellReuseIdentifier: BottomOfNewsCell.identifier)
    }

    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView,
//               heightForRowAt indexPath: IndexPath) -> CGFloat {
//      if indexPath.row == 2 {
//          return 600
//       }
//       return UITableView.automaticDimension
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsResponse?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // общую новость на конкретный индексПас, чтоб не писать 4 раза
        // проверка есть ли фото, есть ли текст, чтобы не создавать пустую ячейку(вызов ячеек не иф а свитч?)
        // ЮАй значки нижней части, значок онлайн??, преобразование даты поста в читабельный вид
        // реализовать все в читабельном виде, побольше функций, которые по очередям потом раскидать и 2 дз готова
        // сохранение токена, без повторного запроса если он есть
        
        
        let postOwner = newsResponse.profiles.first(where: { $0.id == newsResponse.items[indexPath.section].sourceID })
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerNewsCell", for: indexPath) as? OwnerNewsCell else { preconditionFailure("OwnerNewsCell cannot") }
            let url = URL(string: postOwner?.photo100 ?? "")
            let image = UIImage(named: "not photo")!
            DispatchQueue.global(qos: .default).async {
                self.service.imageLoader(url: url) { image in
                    DispatchQueue.main.async {
                        cell.configure(with: image, name: (postOwner?.firstName ?? "1name") + " " + (postOwner?.lastName ?? "2name"), dateOfNews: "\(self.newsResponse.items[indexPath.section].date)")
                    }
                }
            }
            cell.configure(with: image, name: "", dateOfNews: "")
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextInNewsCell.identifier, for: indexPath) as? TextInNewsCell else { preconditionFailure("TextInNewsCell cannot") }
            cell.configure(with: "\(newsResponse.items[indexPath.section].text ?? "")")
            return cell
        case 2:
            if newsResponse.items[indexPath.section].attachments?.first?.photo?.sizes?.last!.url != nil {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosInNewsCell.identifier, for: indexPath) as? PhotosInNewsCell else { preconditionFailure("PhotosInNewsCell cannot") }
                
                let url = URL(string: (newsResponse.items[indexPath.section].attachments?.last?.photo?.sizes?.last?.url) ?? "")
                let image = UIImage(named: "not photo")!
                DispatchQueue.global(qos: .userInteractive).async {
                    self.service.imageLoader(url: url) { image in
                        DispatchQueue.main.async {
                            cell.configure(with: image)
                        }
                    }
                }
//                cell.configure(with: image)
                
                return cell
            } else { return UITableViewCell() }
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomOfNewsCell.identifier, for: indexPath) as? BottomOfNewsCell else { preconditionFailure("BottomOfNewsCell cannot") }
            cell.configure(with: "\(newsResponse.items[indexPath.section].likes?.count ?? 0)", comments: "\(newsResponse.items[indexPath.section].comments?.count ?? 0)", reposts: "\(newsResponse.items[indexPath.section].views?.count ?? 0)")
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}

private extension NewsViewController {
    func loadNews() {
        service.loadNews { [weak self] result in
            switch result {
            case .failure(let error):
                print("news error = ", error)
            case .success(let news):
                print("news = ", news)
                self?.newsResponse = news
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
