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
  
  //item width
  var itemSizeWidthTitle: UILabel!
  var itemSizeWidthSlider: UISlider!
  var itemWidthMinValueLabel: UILabel!
  var itemWidthMaxValueLabel: UILabel!
  var itemWidthCurrentValueLabel: UILabel!
  //item height
  var itemSizeHeightTitle: UILabel!
  var itemSizeHeightSlider: UISlider!
  var itemHeightMinValueLabel: UILabel!
  var itemHeightMaxValueLabel: UILabel!
  var itemHeightCurrentValueLabel: UILabel!
  
  //minimumInteritemSpacing
  var minimumInteritemSpacingTitle: UILabel!
  var minimumInteritemSpacingSlider: UISlider!
  var minimumInteritemSpacingMinValueLabel: UILabel!
  var minimumInteritemSpacingMaxValueLabel: UILabel!
  var minimumInteritemSpacingCurrentValueLabel: UILabel!
  
  //minimumLineitemSpacing
  var minimumLineSpacingTitle: UILabel!
  var minimumLineSpacingSlider: UISlider!
  var minimumLineSpacingMinValueLabel: UILabel!
  var minimumLineSpacingMaxValueLabel: UILabel!
  var minimumLineSpacingCurrentValueLabel: UILabel!
  
  // section inset vertical slider
  var sectionInsetVerticalTitle: UILabel!
  var sectionInsetVerticalSlider: UISlider!
  var sectionInsetVerticalMinValueLabel: UILabel!
  var sectionInsetVerticalMaxValueLabel: UILabel!
  var sectionInsetVerticalCurrentValueLabel: UILabel!
  
  // section inset horizontal slider
  var sectionInsetHorizontalTitle: UILabel!
  var sectionInsetHorizontalSlider: UISlider!
  var sectionInsetHorizontalMinValueLabel: UILabel!
  var sectionInsetHorizontalMaxValueLabel: UILabel!
  var sectionInsetHorizontalCurrentValueLabel: UILabel!
  
  var viewModel: FlowLayoutVM = FlowLayoutVM()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemYellow
    
    setUpItemWidthSlider()
    setUpItemHeightSlider()
    setUpMinimumInteritemSpacingSlider()
    setUpMinimumLineSpacingSlider()
    setUpSectionInsetVerticalSlider()
    setUpSectionInsetHorizontalSlider()

    // 컬렉션 뷰의 레이아웃을 설정합니다. (예시로 FlowLayout을 사용합니다)
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: CGFloat(itemSizeWidthSlider.value), height: 50) // 초기 아이템 크기
    layout.minimumInteritemSpacing = CGFloat(minimumInteritemSpacingSlider.value) // 셀 사이의 수평 간격
    layout.minimumLineSpacing =  CGFloat(minimumLineSpacingSlider.value) // 셀 사이의 수직 간격
    layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0) // 색션 인셋
    
    collectionView = UICollectionView(frame: .init(origin: .zero, size: .zero), collectionViewLayout: layout)
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(sectionInsetHorizontalSlider.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    // 셀등록
    let nib = UINib(nibName: "BasicCell", bundle: nil)
    collectionView.register(nib, forCellWithReuseIdentifier: "BasicCell")
    
    collectionView.backgroundColor = .lightGray
  }
  
  @objc func itemSizeWidthSliderValueChanged(_ sender: UISlider) {
    let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    layout?.itemSize.width = CGFloat(sender.value)
    collectionView.collectionViewLayout.invalidateLayout()
    itemWidthCurrentValueLabel.text = "\(Int(sender.value))"
  }
  
  @objc func itemSizeHeightSliderValueChanged(_ sender: UISlider) {
    let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    layout?.itemSize.height = CGFloat(sender.value)
    collectionView.collectionViewLayout.invalidateLayout()
    itemHeightCurrentValueLabel.text = "\(Int(sender.value))"
  }
  
  @objc func minimumInteritemSpacingSliderValueChanged(_ sender: UISlider) {
    let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    layout?.minimumInteritemSpacing = CGFloat(sender.value)
    collectionView.collectionViewLayout.invalidateLayout()
    minimumInteritemSpacingCurrentValueLabel.text = "\(Int(sender.value))"
  }
  
  @objc func minimumLineSpacingSliderValueChanged(_ sender: UISlider) {
    let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    layout?.minimumLineSpacing = CGFloat(sender.value)
    collectionView.collectionViewLayout.invalidateLayout()
    minimumLineSpacingCurrentValueLabel.text = "\(Int(sender.value))"
  }
  
  @objc func sectionInsetVerticalSliderValueChanged(_ sender: UISlider) {
    let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    let sectionInset = layout?.sectionInset
    let top: CGFloat = sectionInset?.top ?? 0.0
    let bottom: CGFloat = sectionInset?.bottom ?? 0.0
    layout?.sectionInset = .init(top: top, left: CGFloat(sender.value), bottom: bottom, right: CGFloat(sender.value))
    collectionView.collectionViewLayout.invalidateLayout()
    sectionInsetVerticalCurrentValueLabel.text = "\(Int(sender.value))"
  }
  
  @objc func sectionInsetHorizontalSliderValueChanged(_ sender: UISlider) {
    let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    let sectionInset = layout?.sectionInset
    let left: CGFloat = sectionInset?.left ?? 0.0
    let right: CGFloat = sectionInset?.right ?? 0.0
    layout?.sectionInset = .init(top: CGFloat(sender.value), left: left, bottom:  CGFloat(sender.value), right: right)
    collectionView.collectionViewLayout.invalidateLayout()
    sectionInsetHorizontalCurrentValueLabel.text = "\(Int(sender.value))"
  }
  
  func setUpItemWidthSlider() {
      // item slider
      itemSizeWidthSlider = UISlider()
      itemSizeWidthSlider.minimumValue = 10
      itemSizeWidthSlider.maximumValue = 300
      itemSizeWidthSlider.addTarget(self, action: #selector(itemSizeWidthSliderValueChanged(_:)), for: .valueChanged)
      
      itemSizeWidthTitle = UILabel()
      itemSizeWidthTitle.text = "item width : "
      itemSizeWidthTitle.font = .systemFont(ofSize: 20, weight: .bold)
      itemSizeWidthTitle.textAlignment = .left
      
      itemWidthMinValueLabel = UILabel()
      itemWidthMinValueLabel.text = "\(itemSizeWidthSlider.minimumValue)"
      itemWidthMinValueLabel.textAlignment = .center
      
      itemWidthMaxValueLabel = UILabel()
      itemWidthMaxValueLabel.text = "\(itemSizeWidthSlider.maximumValue)"
      itemWidthMaxValueLabel.textAlignment = .center
      
      itemWidthCurrentValueLabel = UILabel()
      itemWidthCurrentValueLabel.textAlignment = .left
      
      view.addSubview(itemSizeWidthTitle)
      view.addSubview(itemWidthMinValueLabel)
      view.addSubview(itemWidthMaxValueLabel)
      view.addSubview(itemWidthCurrentValueLabel)
      view.addSubview(itemSizeWidthSlider)
      
      itemSizeWidthTitle.snp.makeConstraints { make in
          make.top.equalToSuperview().inset(100)
          make.leading.equalToSuperview().inset(20)
      }
      
      itemWidthMinValueLabel.snp.makeConstraints { make in
          make.top.equalTo(itemSizeWidthTitle.snp.bottom)
          make.leading.equalToSuperview().inset(20)
      }
      
      itemWidthMaxValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(itemWidthMinValueLabel)
          make.trailing.equalToSuperview().inset(20)
      }
      
      itemSizeWidthSlider.snp.makeConstraints { make in
          make.centerY.equalTo(itemWidthMinValueLabel)
          make.leading.equalTo(itemWidthMinValueLabel.snp.trailing).inset(-10)
          make.trailing.equalTo(itemWidthMaxValueLabel.snp.leading).inset(-10)
      }
      
      itemWidthCurrentValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(itemSizeWidthTitle)
          make.leading.equalTo(itemSizeWidthTitle.snp.trailing)
          make.trailing.equalToSuperview()
      }
  }
  
  func setUpItemHeightSlider() {
      // item height slider
      itemSizeHeightSlider = UISlider()
      itemSizeHeightSlider.minimumValue = 10
      itemSizeHeightSlider.maximumValue = 300
      itemSizeHeightSlider.addTarget(self, action: #selector(itemSizeHeightSliderValueChanged(_:)), for: .valueChanged)
      
      itemSizeHeightTitle = UILabel()
      itemSizeHeightTitle.text = "Item Height: "
      itemSizeHeightTitle.font = .systemFont(ofSize: 20, weight: .bold)
      itemSizeHeightTitle.textAlignment = .left
      
      itemHeightMinValueLabel = UILabel()
      itemHeightMinValueLabel.text = "\(itemSizeHeightSlider.minimumValue)"
      itemHeightMinValueLabel.textAlignment = .center
      
      itemHeightMaxValueLabel = UILabel()
      itemHeightMaxValueLabel.text = "\(itemSizeHeightSlider.maximumValue)"
      itemHeightMaxValueLabel.textAlignment = .center
      
      itemHeightCurrentValueLabel = UILabel()
      itemHeightCurrentValueLabel.textAlignment = .left
      
      view.addSubview(itemSizeHeightTitle)
      view.addSubview(itemHeightMinValueLabel)
      view.addSubview(itemHeightMaxValueLabel)
      view.addSubview(itemHeightCurrentValueLabel)
      view.addSubview(itemSizeHeightSlider)
      
      itemSizeHeightTitle.snp.makeConstraints { make in
          make.top.equalTo(itemSizeWidthSlider.snp.bottom).offset(20)
          make.leading.equalToSuperview().inset(20)
      }
      
      itemHeightMinValueLabel.snp.makeConstraints { make in
          make.top.equalTo(itemSizeHeightTitle.snp.bottom)
          make.leading.equalToSuperview().inset(20)
      }
      
      itemHeightMaxValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(itemHeightMinValueLabel)
          make.trailing.equalToSuperview().inset(20)
      }
      
      itemSizeHeightSlider.snp.makeConstraints { make in
          make.centerY.equalTo(itemHeightMinValueLabel)
          make.leading.equalTo(itemHeightMinValueLabel.snp.trailing).inset(-10)
          make.trailing.equalTo(itemHeightMaxValueLabel.snp.leading).inset(-10)
      }
      
      itemHeightCurrentValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(itemSizeHeightTitle)
          make.leading.equalTo(itemSizeHeightTitle.snp.trailing)
          make.trailing.equalToSuperview()
      }
  }
  
  func setUpMinimumInteritemSpacingSlider() {
      // minimum interitem spacing slider
      minimumInteritemSpacingSlider = UISlider()
      minimumInteritemSpacingSlider.minimumValue = 0
      minimumInteritemSpacingSlider.maximumValue = 50
      minimumInteritemSpacingSlider.addTarget(self, action: #selector(minimumInteritemSpacingSliderValueChanged(_:)), for: .valueChanged)
      
      minimumInteritemSpacingTitle = UILabel()
      minimumInteritemSpacingTitle.text = "Minimum Interitem Spacing: "
      minimumInteritemSpacingTitle.font = .systemFont(ofSize: 20, weight: .bold)
      minimumInteritemSpacingTitle.textAlignment = .left
      
      minimumInteritemSpacingMinValueLabel = UILabel()
      minimumInteritemSpacingMinValueLabel.text = "\(minimumInteritemSpacingSlider.minimumValue)"
      minimumInteritemSpacingMinValueLabel.textAlignment = .center
      
      minimumInteritemSpacingMaxValueLabel = UILabel()
      minimumInteritemSpacingMaxValueLabel.text = "\(minimumInteritemSpacingSlider.maximumValue)"
      minimumInteritemSpacingMaxValueLabel.textAlignment = .center
      
      minimumInteritemSpacingCurrentValueLabel = UILabel()
      minimumInteritemSpacingCurrentValueLabel.textAlignment = .left
      
      view.addSubview(minimumInteritemSpacingTitle)
      view.addSubview(minimumInteritemSpacingMinValueLabel)
      view.addSubview(minimumInteritemSpacingMaxValueLabel)
      view.addSubview(minimumInteritemSpacingCurrentValueLabel)
      view.addSubview(minimumInteritemSpacingSlider)
      
      minimumInteritemSpacingTitle.snp.makeConstraints { make in
          make.top.equalTo(itemSizeHeightSlider.snp.bottom).offset(20)
          make.leading.equalToSuperview().inset(20)
      }
      
      minimumInteritemSpacingMinValueLabel.snp.makeConstraints { make in
          make.top.equalTo(minimumInteritemSpacingTitle.snp.bottom)
          make.leading.equalToSuperview().inset(20)
      }
      
      minimumInteritemSpacingMaxValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(minimumInteritemSpacingMinValueLabel)
          make.trailing.equalToSuperview().inset(20)
      }
      
      minimumInteritemSpacingSlider.snp.makeConstraints { make in
          make.centerY.equalTo(minimumInteritemSpacingMinValueLabel)
          make.leading.equalTo(minimumInteritemSpacingMinValueLabel.snp.trailing).inset(-10)
          make.trailing.equalTo(minimumInteritemSpacingMaxValueLabel.snp.leading).inset(-10)
      }
      
      minimumInteritemSpacingCurrentValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(minimumInteritemSpacingTitle)
          make.leading.equalTo(minimumInteritemSpacingTitle.snp.trailing)
          make.trailing.equalToSuperview()
      }
  }
  
  func setUpMinimumLineSpacingSlider() {
      // minimum line spacing slider
      minimumLineSpacingSlider = UISlider()
      minimumLineSpacingSlider.minimumValue = 0
      minimumLineSpacingSlider.maximumValue = 50
      minimumLineSpacingSlider.addTarget(self, action: #selector(minimumLineSpacingSliderValueChanged(_:)), for: .valueChanged)
      
      minimumLineSpacingTitle = UILabel()
      minimumLineSpacingTitle.text = "Minimum Line Spacing: "
      minimumLineSpacingTitle.font = .systemFont(ofSize: 20, weight: .bold)
      minimumLineSpacingTitle.textAlignment = .left
      
      minimumLineSpacingMinValueLabel = UILabel()
      minimumLineSpacingMinValueLabel.text = "\(minimumLineSpacingSlider.minimumValue)"
      minimumLineSpacingMinValueLabel.textAlignment = .center
      
      minimumLineSpacingMaxValueLabel = UILabel()
      minimumLineSpacingMaxValueLabel.text = "\(minimumLineSpacingSlider.maximumValue)"
      minimumLineSpacingMaxValueLabel.textAlignment = .center
      
      minimumLineSpacingCurrentValueLabel = UILabel()
      minimumLineSpacingCurrentValueLabel.textAlignment = .left
      
      view.addSubview(minimumLineSpacingTitle)
      view.addSubview(minimumLineSpacingMinValueLabel)
      view.addSubview(minimumLineSpacingMaxValueLabel)
      view.addSubview(minimumLineSpacingCurrentValueLabel)
      view.addSubview(minimumLineSpacingSlider)
      
      minimumLineSpacingTitle.snp.makeConstraints { make in
          make.top.equalTo(minimumInteritemSpacingSlider.snp.bottom).offset(20)
          make.leading.equalToSuperview().inset(20)
      }
      
      minimumLineSpacingMinValueLabel.snp.makeConstraints { make in
          make.top.equalTo(minimumLineSpacingTitle.snp.bottom)
          make.leading.equalToSuperview().inset(20)
      }
      
      minimumLineSpacingMaxValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(minimumLineSpacingMinValueLabel)
          make.trailing.equalToSuperview().inset(20)
      }
      
      minimumLineSpacingSlider.snp.makeConstraints { make in
          make.centerY.equalTo(minimumLineSpacingMinValueLabel)
          make.leading.equalTo(minimumLineSpacingMinValueLabel.snp.trailing).inset(-10)
          make.trailing.equalTo(minimumLineSpacingMaxValueLabel.snp.leading).inset(-10)
      }
      
      minimumLineSpacingCurrentValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(minimumLineSpacingTitle)
          make.leading.equalTo(minimumLineSpacingTitle.snp.trailing)
          make.trailing.equalToSuperview()
      }
  }
  
  func setUpSectionInsetVerticalSlider() {
      // section inset vertical slider
      sectionInsetVerticalSlider = UISlider()
      sectionInsetVerticalSlider.minimumValue = 0
      sectionInsetVerticalSlider.maximumValue = 50
      sectionInsetVerticalSlider.addTarget(self, action: #selector(sectionInsetVerticalSliderValueChanged(_:)), for: .valueChanged)
      
      sectionInsetVerticalTitle = UILabel()
      sectionInsetVerticalTitle.text = "Section Inset Vertical: "
      sectionInsetVerticalTitle.font = .systemFont(ofSize: 20, weight: .bold)
      sectionInsetVerticalTitle.textAlignment = .left
      
      sectionInsetVerticalMinValueLabel = UILabel()
      sectionInsetVerticalMinValueLabel.text = "\(sectionInsetVerticalSlider.minimumValue)"
      sectionInsetVerticalMinValueLabel.textAlignment = .center
      
      sectionInsetVerticalMaxValueLabel = UILabel()
      sectionInsetVerticalMaxValueLabel.text = "\(sectionInsetVerticalSlider.maximumValue)"
      sectionInsetVerticalMaxValueLabel.textAlignment = .center
      
      sectionInsetVerticalCurrentValueLabel = UILabel()
      sectionInsetVerticalCurrentValueLabel.textAlignment = .left
      
      view.addSubview(sectionInsetVerticalTitle)
      view.addSubview(sectionInsetVerticalMinValueLabel)
      view.addSubview(sectionInsetVerticalMaxValueLabel)
      view.addSubview(sectionInsetVerticalCurrentValueLabel)
      view.addSubview(sectionInsetVerticalSlider)
      
      sectionInsetVerticalTitle.snp.makeConstraints { make in
          make.top.equalTo(minimumLineSpacingSlider.snp.bottom).offset(20)
          make.leading.equalToSuperview().inset(20)
      }
      
      sectionInsetVerticalMinValueLabel.snp.makeConstraints { make in
          make.top.equalTo(sectionInsetVerticalTitle.snp.bottom)
          make.leading.equalToSuperview().inset(20)
      }
      
      sectionInsetVerticalMaxValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(sectionInsetVerticalMinValueLabel)
          make.trailing.equalToSuperview().inset(20)
      }
      
      sectionInsetVerticalSlider.snp.makeConstraints { make in
          make.centerY.equalTo(sectionInsetVerticalMinValueLabel)
          make.leading.equalTo(sectionInsetVerticalMinValueLabel.snp.trailing).inset(-10)
          make.trailing.equalTo(sectionInsetVerticalMaxValueLabel.snp.leading).inset(-10)
      }
      
      sectionInsetVerticalCurrentValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(sectionInsetVerticalTitle)
          make.leading.equalTo(sectionInsetVerticalTitle.snp.trailing)
          make.trailing.equalToSuperview()
      }
  }

  func setUpSectionInsetHorizontalSlider() {
      // section inset horizontal slider
      sectionInsetHorizontalSlider = UISlider()
      sectionInsetHorizontalSlider.minimumValue = 0
      sectionInsetHorizontalSlider.maximumValue = 50
      sectionInsetHorizontalSlider.addTarget(self, action: #selector(sectionInsetHorizontalSliderValueChanged(_:)), for: .valueChanged)
      
      sectionInsetHorizontalTitle = UILabel()
      sectionInsetHorizontalTitle.text = "Section Inset Horizontal: "
      sectionInsetHorizontalTitle.font = .systemFont(ofSize: 20, weight: .bold)
      sectionInsetHorizontalTitle.textAlignment = .left
      
      sectionInsetHorizontalMinValueLabel = UILabel()
      sectionInsetHorizontalMinValueLabel.text = "\(sectionInsetHorizontalSlider.minimumValue)"
      sectionInsetHorizontalMinValueLabel.textAlignment = .center
      
      sectionInsetHorizontalMaxValueLabel = UILabel()
      sectionInsetHorizontalMaxValueLabel.text = "\(sectionInsetHorizontalSlider.maximumValue)"
      sectionInsetHorizontalMaxValueLabel.textAlignment = .center
      
      sectionInsetHorizontalCurrentValueLabel = UILabel()
      sectionInsetHorizontalCurrentValueLabel.textAlignment = .left
      
      view.addSubview(sectionInsetHorizontalTitle)
      view.addSubview(sectionInsetHorizontalMinValueLabel)
      view.addSubview(sectionInsetHorizontalMaxValueLabel)
      view.addSubview(sectionInsetHorizontalCurrentValueLabel)
      view.addSubview(sectionInsetHorizontalSlider)
      
      sectionInsetHorizontalTitle.snp.makeConstraints { make in
          make.top.equalTo(sectionInsetVerticalSlider.snp.bottom).offset(20)
          make.leading.equalToSuperview().inset(20)
      }
      
      sectionInsetHorizontalMinValueLabel.snp.makeConstraints { make in
          make.top.equalTo(sectionInsetHorizontalTitle.snp.bottom)
          make.leading.equalToSuperview().inset(20)
      }
      
      sectionInsetHorizontalMaxValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(sectionInsetHorizontalMinValueLabel)
          make.trailing.equalToSuperview().inset(20)
      }
      
      sectionInsetHorizontalSlider.snp.makeConstraints { make in
          make.centerY.equalTo(sectionInsetHorizontalMinValueLabel)
          make.leading.equalTo(sectionInsetHorizontalMinValueLabel.snp.trailing).inset(-10)
          make.trailing.equalTo(sectionInsetHorizontalMaxValueLabel.snp.leading).inset(-10)
      }
      
      sectionInsetHorizontalCurrentValueLabel.snp.makeConstraints { make in
          make.centerY.equalTo(sectionInsetHorizontalTitle)
          make.leading.equalTo(sectionInsetHorizontalTitle.snp.trailing)
          make.trailing.equalToSuperview()
      }
  }



}

// bulid slider


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
