//
//  EducationCollection.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//


import UIKit

class EducationCollection: UICollectionView {
    let customCellId = "EducationCell"
    let itemsPerRow: CGFloat = 1
    let sectionInserts = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
    let layout = UICollectionViewFlowLayout()
    var boardViewDelegate: MainMenuViewDelegate?
    var coursesVM: [CourseViewModel] = Courses.courses
    var callback: ((Int)->())?
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension EducationCollection {
    private func setup() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
        register(EducationCell.self, forCellWithReuseIdentifier: customCellId)
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
extension EducationCollection: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coursesVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as? EducationCell else { return UICollectionViewCell() }
        cell.update(name: coursesVM[indexPath.row].name, descriptions: coursesVM[indexPath.row].description, color: UIColor(named: coursesVM[indexPath.row].color) ?? .blue, imageName: coursesVM[indexPath.row].imageName, isBlocked: coursesVM[indexPath.row].isBlocked, count: indexPath.row)
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension EducationCollection: UICollectionViewDelegateFlowLayout {
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
extension EducationCollection: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callback?(indexPath.row)
        boardViewDelegate?.openCell(number: indexPath.row)
    }
    
}


