//
//  listOfFriends.swift
//  vkApp
//
//  Created by Денис Тереничев on 26.02.2022.
//

import Foundation
import UIKit


var tonyStark: Friend = Friend(id: 0, mainImage: UIImage(named: "Тони"), name: "Тони Старк", images: [
//    UIImage(named: "Тони1"),
//    UIImage(named: "Тони2"),
//    UIImage(named: "Тони3"),
//    UIImage(named: "Тони4"),
//    UIImage(named: "Тони")
    ], statusText: "Я - Железный Человек")

let thor: Friend = Friend(id: 0, mainImage: UIImage(named: "Тор"), name: "Тор Бог Грома", images: [
    UIImage(named: "Тор1"),
    UIImage(named: "Тор2"),
    UIImage(named: "Тор3"),
    UIImage(named: "Тор")
    ], statusText: "Подать мне Таноса!")

let vandaMaksimov: Friend = Friend(id: 0, mainImage: UIImage(named: "Ванда"), name: "Ванда Максимов", images: [
    UIImage(named: "Ванда1"),
    UIImage(named: "Ванда2"),
    UIImage(named: "Ванда3"),
    UIImage(named: "Ванда")
    ], statusText: "Несправедливо")

let karolDenvers: Friend = Friend(id: 0, mainImage: UIImage(named: "Кэрол"), name: "Кэрол Дэнверс", images: [
    UIImage(named: "Кэрол1"),
    UIImage(named: "Кэрол2"),
    UIImage(named: "Кэрол3"),
    UIImage(named: "Кэрол4"),
    ], statusText: "Пока недоступна")

let steeve: Friend = Friend(id: 0, mainImage: UIImage(named: "Стив"), name: "Стив Роджерс", images: [
    UIImage(named: "Стив1"),
    UIImage(named: "Стив2"),
    UIImage(named: "Стив3"),
    UIImage(named: "Стив")
    ], statusText: "Мы не торгуем жизнями")

let strange: Friend = Friend(id: 0, mainImage: UIImage(named: "Стрендж"), name: "Доктор Стрендж", images: [
    UIImage(named: "Стрендж1"),
    UIImage(named: "Стрендж2"),
    UIImage(named: "Стрендж3"),
    UIImage(named: "Стрендж")
    ], statusText: "У нас сил немерено")

let scott: Friend = Friend(id: 0, mainImage: UIImage(named: "Скотт"), name: "Скотт Лэнг", images: [
    UIImage(named: "Скотт1"),
    UIImage(named: "Скотт2"),
    UIImage(named: "Скотт"),
    UIImage(named: "Скотт1")
    ], statusText: "Мой размер тебя поразит")

let tom: Friend = Friend(id: 0, mainImage: UIImage(named: "Том"), name: "Том Паркер", images: [
    UIImage(named: "Том1"),
    UIImage(named: "Том2"),
    UIImage(named: "Том3"),
    UIImage(named: "Том")
    ], statusText: "Сниму квартиру в Нью-Йорке")

let andrew: Friend = Friend(id: 0, mainImage: UIImage(named: "Эндрю"), name: "Эндрю Паркер", images: [
    UIImage(named: "Эндрю1"),
    UIImage(named: "Эндрю2"),
    UIImage(named: "Эндрю3"),
    UIImage(named: "Эндрю")
    ], statusText: "❤️")

let url = URL(string: "https://sun1-85.userapi.com/s/v1/ig2/fTt0ALDWn4KP2-W_wZvAgk8g9JlwtZVb9cXeYVrtK71qcmAQv0Ei5GhoqtHAGGJAFt8XDTUX8UPPJfw7PgJxW8Vg.jpg?size=400x400&quality=96&crop=0,552,1607,1607&ava=1")
let data = try? Data(contentsOf: url!)


var tobbie: Friend = Friend(id: 0, mainImage: UIImage(named: "Тоби"), name: "Тоби Паркер", images: [
    UIImage(named: "Тоби1"),
    UIImage(named: "Тоби2"),
    UIImage(named: "Тоби3"),
    UIImage(data: data!),
    UIImage(named: "Тоби")
    ], statusText: "Жаль гоблина")


    
    
