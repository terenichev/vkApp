//
//  FireBaseCommunity.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

//import Firebase
//
//class FirebaseCommunity {
//    let groupName: String
//    let groupId: Int
//
//    let ref: DatabaseReference?
//
//    init(name: String, id: Int) {
//        self.ref = nil
//        self.groupName = name
//        self.groupId = id
//    }
//
//    init?(snapshot: DataSnapshot) {
//        guard
//            let value = snapshot.value as? [String: Any],
//            let id = value["groupId"] as? Int,
//            let name = value["groupName"] as? String
//        else {
//            return nil
//        }
//        self.ref = snapshot.ref
//        self.groupId = id
//        self.groupName = name
//    }
//
//    func toAnyObject() -> [String: Any] {
//        ["groupId": groupId,
//         "groupName": groupName
//        ]
//    }
//}
