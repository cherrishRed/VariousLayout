//
//  FlowLayoutVC.swift
//  VariousLayouts
//
//  Created by 박세리 on 2023/06/07.
//

import UIKit
import SnapKit

class FlowLayoutVC: UIViewController {
  var collectionView: UICollectionView!
  var viewModel: FlowLayoutVM = FlowLayoutVM()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemYellow
    
    // 컬렉션 뷰의 레이아웃을 설정합니다. (예시로 FlowLayout을 사용합니다)
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 50, height: 50) // 각 셀의 크기
    layout.minimumInteritemSpacing = 10 // 셀 사이의 수평 간격
    layout.minimumLineSpacing = 10 // 셀 사이의 수직 간격
    layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10) // 색션 인셋
    
    collectionView = UICollectionView(frame: .init(origin: .zero, size: .zero), collectionViewLayout: layout)
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    // 셀등록
    let nib = UINib(nibName: "BasicCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: "BasicCell")
    
    collectionView.backgroundColor = .lightGray
  }
}

// data source
extension FlowLayoutVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // 각 아이템에 대한 셀을 반환합니다.
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCell", for: indexPath) as? BasicCell else {
      return UICollectionViewCell()
    }
    print("indexPath flow \(indexPath)")
    
    let section = viewModel.sections[indexPath.section]
    let items = viewModel.itemsBySections[section] ?? []
    let item = items[indexPath.row]
    
    switch item {
      case .face(let face):
        cell.titleLabel.text = face.emoji
      case .animal(let animal):
        cell.titleLabel.text = animal.emoji
      case .haert(let haert):
        cell.titleLabel.text = haert.emoji
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let currentSection = viewModel.sections[section]
    let items = viewModel.itemsBySections[currentSection]
    print("section \(currentSection)")
    return items?.count ?? 0
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return viewModel.sections.count
  }
}

extension FlowLayoutVC: UICollectionViewDelegate {
  
}
