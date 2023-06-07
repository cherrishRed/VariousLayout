//
//  FlowLayoutVM.swift
//  VariousLayouts
//
//  Created by RED on 2023/06/08.
//

import Foundation

class FlowLayoutVM {
  var sections: [Section]
  var itemsBySections: [Section: [Item]]
  
  init() {
    self.sections = [.face, .animal, .heart]
    self.itemsBySections = [
        .face: [
            .face(Face(emoji: "😀")),
            .face(Face(emoji: "😊")),
            .face(Face(emoji: "😃")),
            .face(Face(emoji: "😄")),
            .face(Face(emoji: "😍")),
            .face(Face(emoji: "🥰")),
            .face(Face(emoji: "😎")),
            .face(Face(emoji: "🤩")),
            .face(Face(emoji: "😆")),
            .face(Face(emoji: "😇"))
        ],
        .animal: [
            .animal(Animal(emoji: "🐶")),
            .animal(Animal(emoji: "🐱")),
            .animal(Animal(emoji: "🐼")),
            .animal(Animal(emoji: "🐷")),
            .animal(Animal(emoji: "🐵")),
            .animal(Animal(emoji: "🐰")),
            .animal(Animal(emoji: "🐶")),
            .animal(Animal(emoji: "🐱")),
            .animal(Animal(emoji: "🐼")),
            .animal(Animal(emoji: "🐷"))
        ],
        .heart: [
            .haert(Haert(emoji: "❤️")),
            .haert(Haert(emoji: "💖")),
            .haert(Haert(emoji: "💕")),
            .haert(Haert(emoji: "💘")),
            .haert(Haert(emoji: "💝")),
            .haert(Haert(emoji: "💓")),
            .haert(Haert(emoji: "💞")),
            .haert(Haert(emoji: "💗")),
            .haert(Haert(emoji: "💟")),
            .haert(Haert(emoji: "💜"))
        ]
    ]
    
  }
  // Section and item
  enum Section {
    case face
    case animal
    case heart
  }

  enum Item: Hashable {
    case face(Face)
    case animal(Animal)
    case haert(Haert)
  }

  struct Face: Hashable {
    let emoji: String
  }
  
  struct Animal: Hashable {
    let emoji: String
  }
  
  struct Haert: Hashable {
    let emoji: String
  }

}
