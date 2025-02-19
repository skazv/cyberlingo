//
//  UserCourseCollection.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 03.02.25.
//


import UIKit
protocol UserCourseCCDelegate {
    func openUserCours(with userCourseVM: CourseTopicViewModel)
}

class UserCourseCollection: UICollectionView {
    let customCellId = "UserCourseCell"
    let itemsPerRow: CGFloat = 1
    let sectionInserts = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
    let layout = UICollectionViewFlowLayout()
    var userCourseCCDelegate: UserCourseCCDelegate?
    var callback: (()->())?
    var userCourseArr: [CourseTopicViewModel] = Courses.coursesByTopic
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods
extension UserCourseCollection {
    private func setup() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 20
        
        translatesAutoresizingMaskIntoConstraints = false
        register(UserCourseCell.self, forCellWithReuseIdentifier: customCellId)
        dataSource = self
        delegate = self
        isEditing = false
        showsHorizontalScrollIndicator = true
        layout.scrollDirection = .horizontal
    }

    private func giveItemWidth() -> CGFloat {
        var itemWidth: CGFloat
        itemWidth = frame.width
        return itemWidth
    }
    
    
}

//MARK: - UICollectionViewDataSource
extension UserCourseCollection: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userCourseArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellId, for: indexPath) as? UserCourseCell else { return UICollectionViewCell() }
        cell.update(name: userCourseArr[indexPath.row].name, descriptions: userCourseArr[indexPath.row].description, color: UIColor(named: userCourseArr[indexPath.row].color) ?? .blue, imageName: userCourseArr[indexPath.row].imageName, isBlocked: userCourseArr[indexPath.row].isBlocked, count: indexPath.row)
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension UserCourseCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = giveItemWidth()
        return CGSize(width: width * 0.35, height: width * 0.4)
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
extension UserCourseCollection: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == userCourseArr.count - 1 {
            callback?()
        } else {
            userCourseCCDelegate?.openUserCours(with: userCourseArr[indexPath.row])
        }
    }
    
}


