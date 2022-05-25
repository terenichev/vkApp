//
//  GroupsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 11.05.2022.
//

import UIKit

protocol AddGroupDelegate: AnyObject {
    func addGroup(id: Int, name: String)
}

class GroupsViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var plusBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
       
    var groups: [Group] = []
    let service = GroupsRequests()
    
    var searchGroups: [Group]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchGroups = groups
        loadGroups()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global(qos: .background).async {
            self.loadGroups()
        }
    }
    
    @IBAction func addGroup(_ sender: Any) {
        let allGroupsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllGroupsViewController") as! AllGroupsViewController
        allGroupsVC.delegate = self
        navigationController?.pushViewController(allGroupsVC, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchGroups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupsCell else {
            preconditionFailure("GroupsCell cannot")
        }
        
        let group: Group = groups[indexPath.row]
        let url = URL(string: group.photo100)
        cell.groupImage.image = UIImage(named: "not photo")
        DispatchQueue.global(qos: .default).async {
            self.service.imageLoader(url: url) { image in
                DispatchQueue.main.async {
                    cell.groupImage.image = image
                }
            }
        }
        cell.groupNameLabel.text = group.name
        
        return cell
    }
}

// MARK: - AddGroupDelegate
extension GroupsViewController: AddGroupDelegate {
    ///Добавление выбранной группы в общий групп пользователя
    func addGroup(id: Int, name: String) {
        service.addGroup(idGroup: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if success.response == 1 {
                    self.loadGroups()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Search Bar Config
extension GroupsViewController {
    ///При нажатии на строку поиска скрываем navigationBar с анимацией
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    ///При отмене поиска возвращаем navigationBar с анимацией
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    ///Реализация поиска независимо от введенного регистра
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchGroups = []
        if searchText == "" {
            searchGroups = groups
        }
        else {
            for group in groups {
                let name = group.name
                if name.lowercased().contains(searchText.lowercased()) {
                    searchGroups.append(group)
                }
            }
        }
        self.tableView.reloadData()
    }
}

// MARK: - Load Groups
private extension GroupsViewController {
    ///Загружаем список групп и сохраняем в массив
    func loadGroups() {
        service.loadGroupsList { [weak self] result in
            switch result {
            case .success(let groups):
                self?.groups = groups
                self?.searchGroups = groups
                DispatchQueue.main.async {
                    // перезагрузим данные
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}
