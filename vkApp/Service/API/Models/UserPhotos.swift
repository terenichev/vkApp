//
//  UserPhotos.swift
//  vkApp
//
//  Created by Денис Тереничев on 16.04.2022.
//

import Foundation

enum ParsePhoto {
    struct Responce<T: Decodable>:Decodable {
        let response: PhotosInAlbum<T>
    }
    
    
    struct PhotosInAlbum<T:Decodable>: Decodable {
        let count: Int
        let photos: [T]
    }
    
    enum Photos {
        struct Photo: Codable {
            let sizes: [Size]
        }
        
        
        struct Size: Codable {
            let url: String
        }
    }
}
