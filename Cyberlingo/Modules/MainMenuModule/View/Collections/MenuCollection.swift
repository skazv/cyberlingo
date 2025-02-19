//
//  MenuCollection.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 30.01.25.
//


import UIKit

class MenuCollection: UICollectionView {
    let customCellId = "MenuCell"
    let itemsPerRow: CGFloat = 1 //?
    let sectionInserts = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
    let layout = UICollectionViewFlowLayout()
    var boardViewDelegate: MainMenuViewDelegate?//MainMenuViewDelegate? 
    var menuVM: [MenuViewModel] = []
    var callback: ((Int)->())? // ?
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension MenuCollection {
    private func setup() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
        register(MenuCell.self, forCellWithReuseIdentifier: customCellId)
        dataSource = self
        delegate = self
        isEditing = false
        showsHorizontalScrollIndicator = true
    }
    
    private func giveItemWidth() -> CGFloat {
        var itemWidth: CGFloat
        itemWidth = frame.width
        return itemWidth
    }
    
}
//"multiplyBlendMode"
//MARK: - UICollectionViewDataSource
extension MenuCollection: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as? MenuCell else { return UICollectionViewCell() }
        cell.update(name: menuVM[indexPath.row].name, description: menuVM[indexPath.row].description, color: menuVM[indexPath.row].color, imageName: menuVM[indexPath.row].imageName, blendMode: menuVM[indexPath.row].blendMode, isBlocked: menuVM[indexPath.row].isBlocked, count: indexPath.row, progress: menuVM[indexPath.row].progress, progressCount: menuVM[indexPath.row].progressCount)
        if indexPath.last == menuVM.count - 1 {
            cell.isGame()
        }
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MenuCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = giveItemWidth()
        return CGSize(width: width * 0.9, height: width * 0.33)
        //return CGSize(width: width * 0.9, height: width * 0.36)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: sectionInserts.left, left: sectionInserts.left, bottom: sectionInserts.left, right: sectionInserts.right)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.top//sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
}

//MARK: - UICollectionViewDelegate
extension MenuCollection: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callback?(indexPath.row)
        boardViewDelegate?.openCell(number: indexPath.row)
    }
    
}



