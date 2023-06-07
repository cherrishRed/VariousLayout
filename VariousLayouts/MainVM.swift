//
//  MainVM.swift
//  VariousLayouts
//
//  Created by RED on 2023/06/07.
//

import Foundation

class MainVM {
  var sections: [Section]
  var itemsBySections: [Section: [Item]]
  
  init() {
    self.sections = [.main]
    self.itemsBySections = [.main:
                              [.layoutStyle(.init(name: "Flow Layout 1")), .layoutStyle(.init(name: "Flow Layout 2")),
                               .layoutStyle(.init(name: "Flow Layout 3")),
                               .layoutStyle(.init(name: "Flow Layout 4")),
                               .layoutStyle(.init(name: "Flow Layout 5")),
                               .layoutStyle(.init(name: "Flow Layout 6")),
                               .layoutStyle(.init(name: "Flow Layout 7")),
                               .layoutStyle(.init(name: "Flow Layout 8")),
                               .layoutStyle(.init(name: "Flow Layout 9")),
                               .layoutStyle(.init(name: "Flow Layout 10")),
                               .layoutStyle(.init(name: "Flow Layout 11"))]]
    
  }
}

// Section and item
enum Section {
  case main
}

enum Item: Hashable {
  case layoutStyle(LayoutStyle)
}

struct LayoutStyle: Hashable {
  let name: String
}
