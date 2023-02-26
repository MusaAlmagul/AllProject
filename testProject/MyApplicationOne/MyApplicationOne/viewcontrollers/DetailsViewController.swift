//
//  DetailedViewController.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 19.02.2023.
//

import UIKit

 final class DetailsViewController: UIViewController {

     var apiCaller: ApiMovie?
     private var movieId: Int?
     private var detailedMovieModel: DetailedMovieModel?
     
    // private let screenHeight = UIScreen.main.bounds.height
     
     private lazy var mainTableView: UITableView = {
         let tableView = UITableView(frame: .zero, style: .grouped)
         //tableView.backgroundColor = .systemPink
//         let headerView = DetailsHeaderView()
//         tableView.tableHeaderView = headerView
         return tableView
     }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        apiCaller?.delegate = self
        apiCaller?.fetchRequest(with: movieId ?? 1)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        setupsViews()
        setupConstrains()
    }
     
     func configure(with id: Int) {
        movieId = id
     }
}
//MARK: - APICaller delegate methods

extension DetailsViewController: APICallerDelegate {
    func didUpdateDetailedModel(with model: DetailedMovieModel) {
        self.detailedMovieModel = model
        print(detailedMovieModel?.title ?? "Nothing!!!")
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}

//MARK: - Table view data source and delegate methods

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  let detailedMovieModel, indexPath.row == 0 {
            let cell = PosterTableViewCell()
            cell.configure(with: detailedMovieModel)
    //        cell.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    //        cell.layer.borderWidth = 2
            return cell
        }
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Values.screenHeight * 0.25
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = DetailsHeaderView()
        if let detailedMovieModel {
            view.configure(wiwth: detailedMovieModel)
            
        }
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.Values.screenHeight * 0.25
    }
}

//MARK: - Setup View and constrains methods

extension DetailsViewController {
    
    func setupsViews() {
        view.addSubview(mainTableView)
    }
    
    func setupConstrains() {
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

