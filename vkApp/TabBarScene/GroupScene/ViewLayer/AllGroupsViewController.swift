//
//  AllGroupsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 13.05.2022.
//

import UIKit

class AllGroupsViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let service = GroupsRequests()
    
//    var searchGroups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "allGroupCell") as? AllGroupsCell
        else {
            return UITableViewCell()
        }
//        let group: Group = searchGroups[indexPath.row]
//        
//        
//        let url = URL(string: group.photo50)
//        
//        if let data = try? Data(contentsOf: url!)
//        {
//            cell.allGroupImage.image = UIImage(data: data)
//        }
//        
//        cell.allGroupLabel.text = group.name
        
        return cell
    }
}

// MARK: - Search Bar Config

extension AllGroupsViewController {
    
    //При нажатии на строку поиска скрываем navigationBar с анимацией
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        UIView.animate(withDuration: 0.3) {
//            self.navigationController?.setNavigationBarHidden(true, animated: true)
//        }
//        searchBar.setShowsCancelButton(true, animated: true)
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        UIView.animate(withDuration: 0.3) {
//            self.navigationController?.setNavigationBarHidden(false, animated: true)
//        }
//        searchBar.setShowsCancelButton(false, animated: true)
//        searchBar.resignFirstResponder()
//    }
    
    
    
    //Реализация поиска независимо от введенного регистра
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        let text = searchText.isEmpty ? " " : searchText
//        searchGroups = []
//
//        service.searchGroupsRequest(searchText: text) { [weak self] result in
//            switch result {
//                // если запрос успешен то в потоке майн запишем в константу гроуп результат запроса
//            case .success(let group):
//                self?.searchGroups = group
//                DispatchQueue.main.async {
//                    // перезагрузим данные
//                    self?.tableView.reloadData()
//                }
//                // при не удачном запросе вернуть ошибку
//            case .failure(let error):
//                print("\(error)")
//            }
//        }
//        self.tableView.reloadData()
//    }
}
