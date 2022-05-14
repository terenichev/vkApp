//
//  GroupsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 11.05.2022.
//

import UIKit
import RealmSwift

class GroupsViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var groups: [Group] {
        do {
            let realm = try Realm()
            let group = realm.objects(Group.self)
            let groupsFromRealm = Array(group)
            return groupsFromRealm
        } catch {
            print(error)
            return []
        }
    }
    
    let service = GroupsRequests()
    
    let realm = RealmCacheService()
    private var notificationToken: NotificationToken?
    private var groupRespons: Results<Group>? {
        realm.read(Group.self)
    }
    
    var searchGroups: [Group]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        searchGroups = groups
        createNotificationToken()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupRespons?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupsCell else {
            preconditionFailure("GroupsCell cannot")
        }
        if let groups = groupRespons {
            let group: Group = groups[indexPath.row]
            let url = URL(string: group.photo100)
            cell.groupImage.image = UIImage(named: "not photo")
            DispatchQueue.global(qos: .utility).async {
                let imageFromUrl = self.service.imageLoader(url: url)
                DispatchQueue.main.async {
                    cell.groupImage.image = imageFromUrl
                }
            }
            cell.groupNameLabel.text = group.name
        }
        return cell
    }
}


// MARK: - Search Bar Config
extension GroupsViewController {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
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

// MARK: - Realm Notification Token
private extension GroupsViewController {
    func createNotificationToken() {
        notificationToken = groupRespons?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(let groupsData):
                print("\(groupsData.count)")
            case .update(_,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                let deletionsIndexpath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexpath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexpath = modifications.map { IndexPath(row: $0, section: 0) }
                
                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: deletionsIndexpath, with: .automatic)
                    self.tableView.insertRows(at: insertionsIndexpath, with: .automatic)
                    self.tableView.reloadRows(at: modificationsIndexpath, with: .automatic)
                    self.tableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
        }
    }
}
