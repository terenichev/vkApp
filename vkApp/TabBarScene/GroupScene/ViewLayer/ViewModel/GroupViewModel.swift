//
//  GroupViewModel.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.08.2022.
//

import Foundation
import UIKit

struct GroupViewModel {
    let groupImage: UIImage
    let groupName: String
}

final class GroupViewModelFactory {
    
    let service = GroupsRequests()
    
    func constructViewModels(from groups: [Group]) -> [GroupViewModel] {
        return groups.compactMap(self.viewModel)
    }
    private func viewModel(from group: Group) -> GroupViewModel {
        
        let groupName = group.name
        let groupImageURL = group.photo100
        
        let groupImage: UIImage = {
            var groupImage = UIImage()
            let url = URL(string: groupImageURL)
            print("loading")
            DispatchQueue.global(qos: .default).async {
                self.service.imageLoader(url: url) { image in
                    DispatchQueue.main.async {
                        groupImage = image
                    }
                }
            }
            return groupImage
        }()
        
        
        return GroupViewModel(groupImage: groupImage, groupName: groupName)
    }
}
