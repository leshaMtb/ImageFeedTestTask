//
//  FeedViewController.swift
//  CatsFeed
//
//  Created by Apple on 06.10.2021.
//

import UIKit

class FeedViewController: UIViewController {

    private var viewModel = FeedViewModel()

    let networkDataFetcher = DataFetcher.shared

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        //скачивание фото
        download()

        title = "TestApp"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        view.addSubview(collectionView)

        configCollectionView()
        constraintLayout()
        collectionView.reloadData()
    }

    func download() {
        viewModel.download { [self] in
            collectionView.reloadData()
        }
    }

    func configCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        collectionView.register( PostCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PostCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func constraintLayout() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width - 32
        let height: CGFloat = width + 60
        return CGSize(width: width, height: height)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //когда мы находимся "за три" ячейки до конца страницы(10 постов),то вызывается дополнительная загрузка фото. Подгружаются новые страницы которые отображаются ниже
        if indexPath.item == viewModel.numberOfRows() - 3 {
            viewModel.downloadMore {
                collectionView.reloadData()
            }
        }
    }
}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        present(detailVC, animated: true)
        detailVC.post = viewModel.posts[indexPath.item]
        detailVC.timeOfDownload = viewModel.timeOfDownloadArray[indexPath.item/10]
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PostCollectionViewCell.self), for: indexPath) as! PostCollectionViewCell
        let cellViewModel = viewModel.cellViewModel(indexPath: indexPath)
        cell.viewModel = cellViewModel
        return cell
    }
}




