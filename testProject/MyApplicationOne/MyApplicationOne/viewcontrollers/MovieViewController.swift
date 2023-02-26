//
//  MovieViewController.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 29.01.2023.
//

import UIKit

final class MovieViewController: UIViewController {

    var apiMovie = ApiMovie()
    var genreList: [Int:String] = [:]
    var allMovieList: [[MovieModel]] = []
    
    
    private let scrollView = UIScrollView()
    private let contentView =  UIView()
    private let categoryList = Category.allCases
    
    
    private lazy var movieSearchBar: UISearchBar = {
       let searchBar = UISearchBar()
        //searchBar.layer.borderWidth = 0.5
        //searchBar.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.3)
        searchBar.layer.cornerRadius = 5
        searchBar.searchBarStyle = .minimal//самого searchBar меняет цвет
        searchBar.placeholder = "Search movies"
        return searchBar
    }()
    
    private lazy var categoryColectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectioView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Idenrifiers.categoryCollectionViewCell)
        //collectioView.layer.borderWidth = 1
       // collectioView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.3)
        collectioView.showsHorizontalScrollIndicator = false//скролл линию убрать
        return collectioView
    }()
    
    private lazy var trendingCollecrionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectioView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Idenrifiers.trendingCollectionViewCell)
       //  collectioView.layer.borderWidth = 1
        // collectioView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.3)
         collectioView.showsHorizontalScrollIndicator = false//скролл линию убрать
        return collectioView
    }()
    
    private lazy var categoryTableView: UITableView = {
        let viewTable = UITableView()
        viewTable.register(CategoryTableViewCell.self, forCellReuseIdentifier: Constants.Idenrifiers.categoryTableViewCell)
        viewTable.isScrollEnabled = false
        viewTable.separatorStyle = .none//линия под ячейками удалили 
        //viewTable.allowsSelection = false//при нажатия ячейке серым становиться
//        viewTable.layer.borderWidth = 1
//        viewTable.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        return viewTable
    }()
        
//    private lazy var testLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0 //numberOfLines безконечно уходил вниз
//        label.font = UIFont.systemFont(ofSize: 50)
//        label.textColor = .label
//        label.text = "AAAAAAAAAA"
//        return label
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        apiMovie.delegate = self
        apiMovie.fetchRequest(.genre)
        apiMovie.fetchRequest(.movie)
       
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        categoryColectionV.dataSource = self
        categoryColectionV.delegate = self
        trendingCollecrionView.dataSource = self
        trendingCollecrionView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        
        setupsViews()
        setupConstrains()
        
    }
    
}

//MARK: - API Caller delegate methods

extension MovieViewController: APICallerDelegate {
    
    func didUpdateAllMovieList(with movieList: [MovieModel]) {
        self.allMovieList.append(movieList)
        DispatchQueue.main.sync {
            self.categoryTableView.reloadData()
            self.trendingCollecrionView.reloadData()
            self.categoryTableView.reloadData()
        }
    }
    func didUpdateGenreList(with genreList: [Int : String]) {
        self.genreList = genreList
        DispatchQueue.main.sync {
            self.categoryTableView.reloadData()
            self.trendingCollecrionView.reloadData()
            self.categoryTableView.reloadData()
        }
    }
}

//MARK: - Collection view data source methods

extension MovieViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryColectionV {
            return categoryList.count
            }
        if allMovieList.isEmpty {
            return 0
        }
        return allMovieList[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryColectionV {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Idenrifiers.categoryCollectionViewCell, for: indexPath) as! CategoryCollectionViewCell
            cell.configure(with: categoryList[indexPath.row].rawValue)
            cell.backgroundColor = .systemGray6
            cell.layer.cornerRadius = 5//закругление ячейкинаходящею под  search bar
            cell.clipsToBounds = true
    //        cell.layer.borderWidth = 0.75
    //        cell.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Idenrifiers.trendingCollectionViewCell, for: indexPath) as! TrendingCollectionViewCell
        cell.configure(with: allMovieList[0][indexPath.item].backdropPath!)///////////
        cell.layer.cornerRadius = 10//закругление ячейкинаходящею под  search bar
        cell.clipsToBounds = true
        return cell
    }
   //https://api.themoviedb.org/3/genre/movie/list?api_key=c8c878f3cd2a96dc155b79483f44b938&language=en-US
}
   
//MARK: - Collection View data delegate methods
    
extension MovieViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryColectionV {
            let label = UILabel()
            label.text = categoryList[indexPath.row].rawValue
            label.font = UIFont.systemFont(ofSize: 15)
            label.sizeToFit()
            return CGSize(width: label.frame.size.width + 30, height: collectionView.frame.size.height - 15)
        }
        let height = collectionView.frame.size.height
        return CGSize(width: view.frame.size.width * 0.75, height: height)
        //return CGSize(width: height * 1.75, height: height) вариант если не было видно половины следущей постера
   }
}
//MARK: - Collection view delegate methods

extension MovieViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == trendingCollecrionView {
            let vc = DetailsViewController()
            vc.apiCaller = self.apiMovie//////////////
            vc.configure(with: allMovieList[0][indexPath.item].id)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - Table view data source methods

extension MovieViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryList.count 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView()
        let title = String(categoryList[section].rawValue.dropFirst())
        view.configure(widht: title, number: 6)
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if allMovieList.count == Constants.Values.urlList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Idenrifiers.categoryTableViewCell, for: indexPath) as! CategoryTableViewCell
            cell.apiCaller = apiMovie
            cell.navigationController = navigationController
           // print(allMovieList.count)
            cell.configure(with: allMovieList[indexPath.section + 1], and: genreList)//.row индекс или item
            return cell
            
        }
        return UITableViewCell()
    }
}

//MARK: - Table view delegate methods

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.3
    }
}

//MARK: - Setup View and constrains methods

extension MovieViewController {
    
    func setupsViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
//        contentView.addSubview(testLabel)
//        contentView.addSubview(testLabel2)
        contentView.addSubview(movieSearchBar)
        contentView.addSubview(categoryColectionV)
        contentView.addSubview(trendingCollecrionView)
        contentView.addSubview(categoryTableView)
    }
    
    func setupConstrains() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalTo(view).inset(15)
        }
//        testLabel.snp.makeConstraints { make in
//            make.leading.trailing.top.equalToSuperview()
//        }
//        testLabel2.snp.makeConstraints { make in
//            make.top.equalTo(testLabel.snp.bottom)
//            make.leading.trailing.bottom.equalToSuperview()
//        }
        movieSearchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.05)//чтобы отделить searchBar от scrollBar
        }
        movieSearchBar.searchTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()//внутренняя часть SearchBar занимает полный серый цвет
        }
        categoryColectionV.snp.makeConstraints { make in
            make.top.equalTo(movieSearchBar.snp.bottom).offset(10)//oтступы  между ячейками что бы было пространство
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.05)
        }
        trendingCollecrionView.snp.makeConstraints { make in
            make.top.equalTo(categoryColectionV.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view).multipliedBy(0.2)
        }
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(trendingCollecrionView.snp.bottom).offset(10)
            make.height.equalTo(view).multipliedBy(1.5)
            make.leading.trailing.bottom.equalToSuperview()
            //make.bottom.equalToSuperview()
            
        }
    }
}

