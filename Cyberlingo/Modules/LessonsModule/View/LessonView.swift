//
//  LessonView.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 02.02.25.
//

import UIKit
import WebKit

class LessonView: UIView {
    let headerFont = FontLib.fontWithSize(font: .unboundedSemiBold, size: 18)
    let descriptionFont = UIFont(name: "Arial Light", size: 14)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = headerFont
        label.textColor = .label
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .natural
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var youtubeWebView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.layer.cornerRadius = 25
        webView.layer.masksToBounds = true
        return webView
    }()
    
    let cardView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var nameLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = headerFont
        label.textColor = .label
        return label
    }()
    
    lazy var descriptionLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .natural
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LocalisationManager.next, for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor().hexStringToUIColor(hex: "466CFF")
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
        loadYouTubeVideo(videoID: "dQw4w9WgXcQ")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadYouTubeVideo(videoID: String) {
        //https://youtu.be/2OPVViV-GQk?si=1Aouir17Mgt1T4ye
        let embedHTML = """
        <iframe width="100%" height="100%" src="https://www.youtube.com/embed/\(videoID)?playsinline=1" frameborder="0" allowfullscreen></iframe>
        """
        youtubeWebView.loadHTMLString(embedHTML, baseURL: nil)
    }
}

// MARK: - Private methods
extension LessonView {
    private func setupView() {
        backgroundColor = .secondarySystemBackground
        
        addSubview(scrollView)
        addSubview(nextButton)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(views: [
            imageView,
            cardView,
            youtubeWebView,
            cardView2,
        ])
        
        cardView.addSubviews(views: [
            nameLabel,
            descriptionLabel
        ])
        
        cardView2.addSubviews(views: [
            descriptionLabel2,
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            
            cardView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
            
            youtubeWebView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 10),
            youtubeWebView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            youtubeWebView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            youtubeWebView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.56), // 16:9
            
            cardView2.topAnchor.constraint(equalTo: youtubeWebView.bottomAnchor, constant: 10),
            cardView2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardView2.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel2.topAnchor.constraint(equalTo: cardView2.topAnchor, constant: 10),
            descriptionLabel2.leadingAnchor.constraint(equalTo: cardView2.leadingAnchor, constant: 10),
            descriptionLabel2.trailingAnchor.constraint(equalTo: cardView2.trailingAnchor, constant: -10),
            descriptionLabel2.bottomAnchor.constraint(equalTo: cardView2.bottomAnchor, constant: -10),
            
            cardView2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),

            nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
