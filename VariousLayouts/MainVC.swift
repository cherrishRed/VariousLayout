//
//  MainVC.swift
//  VariousLayouts
//
//  Created by 박세리 on 2023/06/02.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  var viewModel: MainVM = MainVM()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.topItem?.title = "Varous Layout "
    navigationController?.title = "Various Layout Style"
    // 컬렉션 뷰의 delegate와 dataSource를 현재 뷰 컨트롤러로 설정합니다.
    collectionView.delegate = self
    collectionView.dataSource = self
    
    // 셀등록
    let nib = UINib(nibName: "BasicCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: "BasicCell")
    
    collectionView.backgroundColor = .lightGray
    
    // 컬렉션 뷰의 레이아웃을 설정합니다. (예시로 FlowLayout을 사용합니다)
    let layout = UICollectionViewFlowLayout()
    let cellWidth: CGFloat = UIScreen.main.bounds.size.width - 20
    layout.itemSize = CGSize(width: cellWidth, height: 100) // 각 셀의 크기
    layout.minimumInteritemSpacing = 10 // 셀 사이의 수평 간격
    layout.minimumLineSpacing = 10 // 셀 사이의 수직 간격
    
    collectionView.collectionViewLayout = layout
    
  }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let currentSection = viewModel.sections[section]
    let items = viewModel.itemsBySections[currentSection]
    return items?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    // 각 아이템에 대한 셀을 반환합니다.
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCell", for: indexPath) as? BasicCell else {
      return UICollectionViewCell()
    }
    print("indexPath \(indexPath.row)")
    
    let section = viewModel.sections[indexPath.section]
    let items = viewModel.itemsBySections[section] ?? []
    let item = items[indexPath.row]
    
    switch item {
      case .layoutStyle(let style):
        cell.titleLabel.text = style.name
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("clicked \(indexPath)")
    
    switch indexPath.row {
      case 0:
        print("row == 0")
        let flowLayoutVC = FlowLayoutVC()
        navigationController?.show(flowLayoutVC, sender: nil)
      default:
        break
    }
  }
}
