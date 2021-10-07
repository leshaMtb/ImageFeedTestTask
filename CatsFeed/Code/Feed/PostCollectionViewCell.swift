//
//  PostCollectionViewCell.swift
//  CatsFeed
//
//  Created by Apple on 06.10.2021.
//

import UIKit
import SDWebImage

class PostCollectionViewCell: UICollectionViewCell {

      weak var viewModel: PostCellViewModelProtocol? {
          willSet(viewModel) {
              guard let viewModel = viewModel else { return }
              descriptionLabel.text = viewModel.description
              guard let url = URL(string: viewModel.imageUrl) else { return }
              photoImageView.sd_setImage(with: url, completed: nil)
          }
      }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

       let photoImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.contentMode = .scaleAspectFill
           imageView.clipsToBounds = true
           imageView.layer.cornerRadius = 7
           return imageView
       }()

       var descriptionLabel: UILabel = {
           var label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.numberOfLines = 3
        label.textColor = .black
           label.textAlignment = .left
           label.font = UIFont.systemFont(ofSize: 14, weight: .light)
           return label
       }()



       override init(frame: CGRect) {
           super.init(frame: frame)
           backgroundColor = .clear
           setupConstraints()
       }



       private func setupConstraints(){
        contentView.layer.cornerRadius = 10
        contentView.addSubview(photoImageView)
        contentView.addSubview(descriptionLabel)
        contentView.backgroundColor = .systemGray6

           NSLayoutConstraint.activate([
               photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
               photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
               photoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
               photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),

               descriptionLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 7),
               descriptionLabel.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -10),
               descriptionLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor, constant: 10)
           ])
       }
   }
