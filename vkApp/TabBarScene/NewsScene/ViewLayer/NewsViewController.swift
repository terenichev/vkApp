//
//  NewsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class NewsViewController: UITableViewController {
    
    let service = NewsService()
    var newsItems: [NewsItem?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.loadNews { [weak self] result in
            switch result {
            case .failure(let error):
                print("news error = ", error)
            case .success(let news):
                print("news = ", news)
                self?.newsItems = news
                self?.tableView.reloadData()
            }
        }
        
        tableView.register(OwnerNewsCell.nib(), forCellReuseIdentifier: OwnerNewsCell.identifier)
        tableView.register(TextInNewsCell.nib(), forCellReuseIdentifier: TextInNewsCell.identifier)
        tableView.register(PhotosInNewsCell.nib(), forCellReuseIdentifier: PhotosInNewsCell.identifier)
        tableView.register(BottomOfNewsCell.nib(), forCellReuseIdentifier: BottomOfNewsCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsItems.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerNewsCell", for: indexPath) as? OwnerNewsCell else { preconditionFailure("OwnerNewsCell cannot") }
            
            cell.configure(with: UIImage(named: "not photo")!, name: "\(String(describing: newsItems[indexPath.section]?.sourceID))", dateOfNews: "\(String(describing: newsItems[indexPath.section]?.date))")
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextInNewsCell.identifier, for: indexPath) as? TextInNewsCell else { preconditionFailure("TextInNewsCell cannot") }
            cell.configure(with: "\(String(describing: newsItems[indexPath.section]?.text))")
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosInNewsCell.identifier, for: indexPath) as? PhotosInNewsCell else { preconditionFailure("PhotosInNewsCell cannot") }
            
//            let url = URL(string: (newsItems.last?.attachments?.last?.photo?.sizes.last?.url)!)
            let image = UIImage(named: "not photo")!
            let url = URL(string: "https://sun9-west.userapi.com/sun9-67/s/v1/if2/WY3XOHFWzIceQYgnNcpB8ux91RnZgCmIjZUcmsh4LIhuyURRXxPlmieoukeZDQ33Q4XYG1Rj-OBMNvMklOD14lVE.jpg?size=124x130&quality=96&type=album")
            DispatchQueue.global(qos: .default).async {
                self.service.imageLoader(url: url) { image in
                    DispatchQueue.main.async {
                        cell.configure(with: image)
                    }
                }
            }
            cell.configure(with: image)
//            cell.configure(with: UIImage(named: "not photo")!)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomOfNewsCell.identifier, for: indexPath) as? BottomOfNewsCell else { preconditionFailure("BottomOfNewsCell cannot") }
            cell.configure(with: "5", comments: "6", reposts: "7")
            return cell
        }
    }
}


//extension NewsViewController {
//
//
//newswer =  [vkApp.NewsItem(sourceID: Optional(-57551138),
//                        date: Optional(1653669430),
//                        canDoubtCategory: Optional(false),
//                        canSetCategory: Optional(false),
//                        isFavorite: Optional(false),
//                        postType: Optional("post"),
//                        text: Optional("Я буду очень сильно переживать во время боя Дацика и Алекса, ведь я собираюсь поставить крупную сумму на поражение моего брата нокаутом. \n \n© Емель"),
//                        markedAsAds: Optional(0),
//                        attachments: Optional([vkApp.Attachment(type: Optional(vkApp.TypeEnum.photo),
//                                                                photo: Optional(vkApp.NewsPhoto(albumID: Optional(-7),
//                                                                                                date: Optional(1653669430),
//                                                                                                id: Optional(457374933),
//                                                                                                ownerID: Optional(-57551138),
//                                                                                                accessKey: Optional("88e8c719901c573d0c"),
//                                                                                                sizes: [vkApp.NewsPhotoSize(height: Optional(48),
//                                                                                                                            url: Optional("https://sun9-east.userapi.com/sun9-42/s/v1/if2/ikrW_XV9XFuu0512EDJVC09dz0yGbVoQB60ZKEU4Tfh7U3vEl0vcO8473JgDquU-iBc26PPrj7B8CLWxSFX9hPn5.jpg?size=75x48&quality=96&type=album"),
//                                                                                                                            type: Optional("s"),
//                                                                                                                            width: Optional(75)),
//                                                                                                        vkApp.NewsPhotoSize(height: Optional(340),
//                                                                                                                            url: Optional("https://sun9-east.userapi.com/sun9-42/s/v1/if2/4w3uazvc_0o1d9_ghQLfznGHoU-iSEEm_MmPbk7PkonhOhSSC6ZwCM-uJ95zuBLkEC2j5p6odfdzMYTljd5HTjvW.jpg?size=510x340&quality=96&crop=27,0,1125,750&type=album"),
//                                                                                                                            type: Optional("r"),
//                                                                                                                            width: Optional(510))],
//                                                                                                text: Optional(""),
//                                                                                                userID: Optional(100),
//                                                                                                hasTags: Optional(false),
//                                                                                                postID: Optional(1409281))))]),
//                        postSource: Optional(vkApp.PostSource(type: Optional("vk"))),
//                        comments: Optional(vkApp.Comments(canPost: Optional(1),
//                                                          count: Optional(1),
//                                                          groupsCanPost: nil)),
//                        likes: Optional(vkApp.Likes(canLike: Optional(1),
//                                                    count: Optional(4),
//                                                    userLikes: Optional(0),
//                                                    canPublish: Optional(1))),
//                        reposts: Optional(vkApp.Reposts(count: Optional(1),
//                                                        userReposted: Optional(0))),
//                        views: Optional(vkApp.Views(count: Optional(225))),
//                        donut: Optional(vkApp.Donut(isDonut: Optional(false))),
//                        shortTextRate: Optional(0.8),
//                        carouselOffset: nil,
//                        postID: Optional(1409281),
//                        type: Optional("post"),
//                        copyHistory: nil)
//
//
//            newsItems[0].attachments?.last.photo?.sizes.last?.url
//
//}
