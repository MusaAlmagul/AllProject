//
//  CategoryTableViewCell.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 05.02.2023.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {

    
    var apiCaller: ApiMovie?
    var navigationController: UINavigationController?
    
    private var movieList: [MovieModel] = []
    private var genreList: [Int:String] = [:]
    
    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Idenrifiers.movieCollectionViewCell)
//        collectionView.layer.borderWidth = 1
//        collectionView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        
        setupsViews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with movieList: [MovieModel], and genreList: [Int:String]) {
        self.movieList = movieList
        self.genreList = genreList
        DispatchQueue.main.async {
            self.movieCollectionView.reloadData()
        }
    }
}
//MARK: - Collection view data source and delegate methods

extension CategoryTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Idenrifiers.movieCollectionViewCell, for: indexPath) as! MovieCollectionViewCell
        //cell.backgroundColor = .systemCyan
        cell.clipsToBounds = true
       // cell.layer.cornerRadius = 10
        cell.configure(with: movieList[indexPath.row], and: genreList)
        return cell
    }
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        return CGSize(width: height/2, height: height)
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = DetailsViewController()
            vc.apiCaller = self.apiCaller//////////////
            vc.configure(with: movieList[indexPath.item].id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
//MARK: - Setup View and constrains methods

extension CategoryTableViewCell {
    
    func setupsViews() {
        contentView.addSubview(movieCollectionView)
        
    }
    
    func setupConstrains() {
        movieCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

