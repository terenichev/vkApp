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
            DispatchQueue.global(qos: .default).async {
                self.service.imageLoader(url: url) { image in
                    DispatchQueue.main.async {
                        cell.configure(with: image, name: (postOwner?.firstName ?? "1name") + " " + (postOwner?.lastName ?? "2name"), dateOfNews: "\(String(describing: currentNewsItem.date))")
                    }
                }
            }
//            cell.configure(with: imageEmpty, name: "", dateOfNews: "")
            return cell
            
        case 1:
            if currentNewsItem.text != nil{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TextInNewsCell.identifier, for: indexPath) as? TextInNewsCell else { preconditionFailure("TextInNewsCell cannot") }
                cell.configure(with: "\(currentNewsItem.text ?? "")")
                return cell
            } else {
                return UITableViewCell()
            }
                
            
        case 2:
            if newsResponse.items[indexPath.section].attachments?.first?.photo?.sizes?.last!.url != nil {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosInNewsCell.identifier, for: indexPath) as? PhotosInNewsCell else { preconditionFailure("PhotosInNewsCell cannot") }
                
                let url = URL(string: (currentNewsItem.attachments?.last?.photo?.sizes?.last?.url) ?? "")
                DispatchQueue.global(qos: .userInteractive).async {
                    self.service.imageLoader(url: url) { image in
                        DispatchQueue.main.async {
                            cell.configure(with: image, height: currentNewsItem.attachments?.last?.photo?.sizes?.last?.height, width: currentNewsItem.attachments?.last?.photo?.sizes?.last?.width)
                        }
                    }
                }
                return cell
            } else if currentNewsItem.attachments?.first?.video?.image?.last?.url != nil {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosInNewsCell.identifier, for: indexPath) as? PhotosInNewsCell else { preconditionFailure("PhotosInNewsCell cannot") }
                
                let url = URL(string: (currentNewsItem.attachments?.last?.video?.image?.last?.url) ?? "")
                DispatchQueue.global(qos: .userInteractive).async {
                    self.service.imageLoader(url: url) { image in
                        DispatchQueue.main.async {
                            cell.configure(with: image, height: currentNewsItem.attachments?.last?.video?.height, width: currentNewsItem.attachments?.last?.video?.width)
                        }
                    }
                }
                return cell
            } else {
                return UITableViewCell()
            }
                       
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomOfNewsCell.identifier, for: indexPath) as? BottomOfNewsCell else { preconditionFailure("BottomOfNewsCell cannot") }
            cell.configure(with: "\(newsResponse.items[indexPath.section].likes?.count ?? 0)", comments: "\(currentNewsItem.comments?.count ?? 0)", reposts: "\(currentNewsItem.views?.count ?? 0)")
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
                DispatchQueue.main.async {
                    self?.newsResponse = news
                    self?.tableView.reloadData()
                }
            }
        }
    }
}



//NewsItem(
//    sourceID: Optional(316135728),
//    date: Optional(1654292368),
//    canDoubtCategory: Optional(false),
//    canSetCategory: Optional(false),
//    isFavorite: Optional(false),
//    postType: Optional(vkApp.PostTypeEnum.post),
//    text: Optional(""),
//    copyHistory: Optional([
//        vkApp.CopyHistory(id: Optional(110618),
//                          ownerID: Optional(-173666224),
//                          fromID: Optional(-173666224),
//                          date: Optional(1653617356),
//                          postType: Optional(vkApp.PostTypeEnum.post),
//                          text: Optional("Смотри и учись - Мастерская подскажет 🛠\n\n#Мастерская\n\n...\n⚠Оcoбeннocти пилoк для элeктpолобзика! Ηе зaбудьте сохpaнить!"),
//                          attachments: Optional([vkApp.CopyHistoryAttachment(
//                            type: Optional(vkApp.AttachmentType.photo),
//                            photo: Optional(vkApp.AttachmentPhoto(
//                                albumID: Optional(-7),
//                                date: Optional(1653545302),
//                                id: Optional(457284911),
//                                ownerID: Optional(-173666224),
//                                postID: Optional(110557),
//                                sizes: Optional([vkApp.PhotoSize(
//                                    height: Optional(130),
//                                    url: Optional("https://sun9-north.userapi.com/sun9-79/s/v1/if2/GTM6vcHuU5LrvlB_IqLgOoTO4bi-lQlmsZc-rnTQampNKx1dPAJr2QuWPwEm151fMwfyl04qoXipVwSrfIC6_eHr.jpg?size=88x130&quality=96&type=album"),
//                                    type: Optional(vkApp.SizeType.m),
//                                    width: Optional(88),
//                                    withPadding: nil), vkApp.PhotoSize(
//                                        height: Optional(192),
//                                        url: Optional("https://sun9-north.userapi.com/sun9-79/s/v1/if2/SIhxVFCOhheNMJ2DfdxhbIXttPV03sZCbihnnJlhPLVH7B84TqL9CP6fzhx72ic6fcS9X_3OdogHsZGPB2MSwBDd.jpg?size=130x192&quality=96&type=album"),
//                                        type: Optional(vkApp.SizeType.o),
//                                        width: Optional(130),
//                                        withPadding: nil),
//                                                 vkApp.PhotoSize(
//                                                    height: Optional(295),
//                                                    url: Optional("https://sun9-north.userapi.com/sun9-79/s/v1/if2/GHmqATdTyvFr7yXf5ZtBtDGaO-192jVWZ9PbQjQ_gS9ByudFT7F6mzkI3EXro9Thx_U2HfinAZ7i3By4PyN2IGDU.jpg?size=200x295&quality=96&type=album"),
//                                                    type: Optional(vkApp.SizeType.p),
//                                                    width: Optional(200),
//                                                    withPadding: nil),
//                                ]),
//                                text: Optional(""),
//                                hasTags: Optional(false),
//                                accessKey: Optional("4b5631e088750b730e"),
//                                lat: nil,
//                                long: nil,
//                                userID: Optional(100))),
//                            video: nil,
//                            link: nil,
//                            audio: nil)]),
//                          postSource: Optional(vkApp.CopyHistoryPostSource(
//                            platform: nil,
//                            type: Optional(vkApp.PostSourceType.api))),
//                          signerID: nil,
//                          isDeleted: nil,
//                          deletedReason: nil,
//                          deletedDetails: nil)]),
//    postSource: Optional(vkApp.ItemPostSource(
//        platform: Optional(vkApp.Platform.android),
//        type: Optional(vkApp.PostSourceType.api),
//        data: nil)),
//    comments: Optional(vkApp.Comments(
//        canPost: Optional(0),
//        count: Optional(0),
//        groupsCanPost: Optional(true))),
//    likes: Optional(vkApp.Likes(
//        canLike: Optional(1),
//        count: Optional(0),
//        userLikes: Optional(0),
//        canPublish: Optional(0))),
//    reposts: Optional(vkApp.Reposts(
//        count: Optional(0),
//        userReposted: Optional(0))),
//    donut: Optional(vkApp.Donut(
//        isDonut: Optional(false))),
//    shortTextRate: Optional(0.8),
//    postID: Optional(596),
//    type: Optional(vkApp.PostTypeEnum.post),
//    views: Optional(vkApp.Views(count: Optional(2))),
//    attachments: nil,
//    carouselOffset: nil,
//    topicID: nil)
