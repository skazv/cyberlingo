//
//  lessonsTools.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 18.02.25.
//

import UIKit

//protocol CourseCollectionCellDelegate {
//    func cellTaped(number: Int)
//}

class ToolsCollection: UICollectionView {
    let customCellId = "CourseCell"
    let itemsPerRow: CGFloat = 1
    let sectionInserts = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
    let layout = UICollectionViewFlowLayout()
    var courseCollectionCellDelegate: CourseCollectionCellDelegate?
    var lessons: [LessonViewModel]?
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension ToolsCollection {
    private func setup() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 20
        
        translatesAutoresizingMaskIntoConstraints = false
        register(CourseCell.self, forCellWithReuseIdentifier: customCellId)
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

//MARK: - UICollectionViewDataSource
extension ToolsCollection: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let lessons = lessons else { return 0 }
        return lessons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as? CourseCell else { return UICollectionViewCell() }
        guard let lessons = lessons else { return cell }
        cell.update(name: lessons[indexPath.row].name, descriptions: lessons[indexPath.row].description, color: UIColor().hexStringToUIColor(hex: lessons[indexPath.row].color), imageName: lessons[indexPath.row].imageName, isBlocked: lessons[indexPath.row].isBlocked)
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ToolsCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = giveItemWidth()
        return CGSize(width: width * 0.9, height: width * 0.28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: sectionInserts.left, left: sectionInserts.left, bottom: sectionInserts.left, right: sectionInserts.right)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
    
}

//MARK: - UICollectionViewDelegate
extension ToolsCollection: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        courseCollectionCellDelegate?.cellTaped(number: indexPath.row)
    }
    
}
