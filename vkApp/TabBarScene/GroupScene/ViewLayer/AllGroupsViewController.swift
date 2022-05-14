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
    
    var searchGroups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        searchBar.delegate = self
    }
    
    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchGroups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "allGroupCell") as? GroupsCell
        else {
            
            return UITableViewCell()
        }
        let group: Group = searchGroups[indexPath.row]
        cell.id = group.id
        cell.name = group.name
        
        let url = URL(string: group.photo50)
        if let data = try? Data(contentsOf: url!)
        {
            cell.groupImage.image = UIImage(data: data)
        }
        cell.groupNameLabel.text = group.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? GroupsCell,
              let id = cell.id,
              let name = cell.name
        else { return }
        
        print("name = ", name)
        print("id = ", id)
    }
}


// MARK: - Search Bar Config
extension AllGroupsViewController {
    
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
        let text = searchText.isEmpty ? " " : searchText
        searchGroups = []
        service.searchGroupsRequest(searchText: text) { [weak self] result in
            switch result {
            case .success(let group):
                self?.searchGroups = group
                DispatchQueue.main.async {
                    // перезагрузим данные
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
            self.tableView.reloadData()
    }
}
