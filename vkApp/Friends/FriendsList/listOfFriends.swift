//
//  listOfFriends.swift
//  vkApp
//
//  Created by Денис Тереничев on 26.02.2022.
//

import Foundation
import UIKit


var tonyStark: Friend = Friend(id: 0, mainImage: UIImage(named: "Тони"), name: "Тони Старк", images: [
    UIImage(named: "Тони1"),
    UIImage(named: "Тони2"),
    UIImage(named: "Тони3"),
    UIImage(named: "Тони4"),
    UIImage(named: "Тони")
    ], statusText: "Я - Железный Человек")

let thor: Friend = Friend(id: 0, mainImage: UIImage(named: "Тор"), name: "Тор Бог Грома", images: [
    UIImage(named: "Тор1"),
    UIImage(named: "Тор2"),
    UIImage(named: "Тор3"),
    UIImage(named: "Тор")
    ], statusText: "Подать мне Таноса!")

let strange: Friend = Friend(id: 0, mainImage: UIImage(named: "Стрендж"), name: "Доктор Стрендж", images: [
    UIImage(named: "Стрендж1"),
    UIImage(named: "Стрендж2"),
    UIImage(named: "Стрендж3"),
    UIImage(named: "Стрендж")
    ], statusText: "У нас сил немерено")
