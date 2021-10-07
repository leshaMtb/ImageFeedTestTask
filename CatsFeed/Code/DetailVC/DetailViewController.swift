//
//  DetailViewController.swift
//  CatsFeed
//
//  Created by Apple on 07.10.2021.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    var post: Post? {
        didSet {
            //sd_setImage позволяет отображать картинку ассинхронно и не останавливает UI процессы. При скролле ленты по уже загруженным картинкам расход трафика не происходит
            photoImageView.sd_setImage(with: URL(string: post!.urls.regular), completed: nil)
            descLabel.text = post!.description ?? "No description"
        }
    }

    var timeOfDownload: String? {
        didSet {
            dateLabel.text = " " + timeOfDownload!
        }
    }

    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    var dateOfDownloadPhotoLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date of download photo:"
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    var dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
        return label
    }()

    var descLabelUpper: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description:"
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    var descLabel: UITextView = {
        var label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
        return label
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()

    }

    func setupViews() {
        view.addSubview(photoImageView)
        view.addSubview(dateOfDownloadPhotoLabel)
        view.addSubview(descLabel)
        view.addSubview(dateLabel)
        view.addSubview(descLabelUpper)

        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            photoImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            photoImageView.heightAnchor.constraint(equalToConstant: view.frame.width),

            dateOfDownloadPhotoLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10),
            dateOfDownloadPhotoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            dateOfDownloadPhotoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            dateOfDownloadPhotoLabel.heightAnchor.constraint(equalToConstant: 20),

            dateLabel.topAnchor.constraint(equalTo: dateOfDownloadPhotoLabel.bottomAnchor, constant: 0),
            dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),

            descLabelUpper.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            descLabelUpper.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            descLabelUpper.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            descLabelUpper.heightAnchor.constraint(equalToConstant: 15),

            descLabel.topAnchor.constraint(equalTo: descLabelUpper.bottomAnchor, constant: 0),
            descLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            descLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            descLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
        ])
    }
}
