//
//  ViewController.swift
//  Forecast_Test
//
//  Created by Rafael Cunha de Oliveira on 2020-07-14.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

/*
VMMV Architecture, where view controller has only visual assets
*/

class HomeViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    //MARK: Variable
    
    var viewModel = HomeViewModel()

    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }

    //MARK: - Set up

    func registerTableView() {
        tableView.register(UINib(nibName: "ForecastTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "ForecastTableViewCell")
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "NewsTableViewCell")
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "CityTableViewCell")
        tableView.register(UINib(nibName: "NewsHeaderTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "NewsHeaderTableViewCell")
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { // make request after user press search
        self.showLoading()
        print(searchBar.text ?? "")
        searchBar.endEditing(true)
        viewModel.getInfo(searchBar.text ?? "", success: {
            self.tableView.reloadData()
            self.hideLoading()
        }) { (error) in
            self.hideLoading()
            self.showError(error)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = (viewModel.news?.articles?.count ?? 0) > 10 ? 10 :
            viewModel.news?.articles?.count ?? 0
        return (count + 3)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell")
                as? CityTableViewCell else { return UITableViewCell() }
            cell.setUp(name: viewModel.city,
                       maxMinTemp: viewModel.getMaxMinTemp(),
                       current: viewModel.getCurrentTemp(),
                       image: viewModel.getImage(id: viewModel.weather?.weather?.first?.icon ?? "01d"))
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell")
                as? ForecastTableViewCell else { return UITableViewCell() }
            let firstDay = viewModel.getNextDateForecast(.first)
            let secondDay = viewModel.getNextDateForecast(.second)
            let thirdDay = viewModel.getNextDateForecast(.third)
            cell.setUp(firstImage: viewModel.getImage(id: firstDay?.weather?.first?.icon ?? ""),
                       firstTemp: viewModel.formatDateForecast(firstDay?.main?.tempMax ?? 0.0,
                                                               firstDay?.main?.tempMin ?? 0.0),
                       secondImage: viewModel.getImage(id: secondDay?.weather?.first?.icon ?? ""),
                       secondTemp: viewModel.formatDateForecast(secondDay?.main?.tempMax ?? 0.0,
                                                                secondDay?.main?.tempMin ?? 0.0),
                       thirdImage: viewModel.getImage(id: thirdDay?.weather?.first?.icon ?? ""),
                       thirdTemp: viewModel.formatDateForecast(thirdDay?.main?.tempMax ?? 0.0,
                                                               thirdDay?.main?.tempMin ?? 0.0))
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderTableViewCell")
                as? NewsHeaderTableViewCell else { return UITableViewCell() }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell")
                as? NewsTableViewCell else { return UITableViewCell() }
            let article = viewModel.news?.articles?[(indexPath.row - 3)]
            cell.setUp(image: viewModel.getImage(url: article?.urlToImage ?? ""),
                       title: article?.title ?? "",
                       source: "By \(article?.source?.name ?? "")")
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250
        case 1:
            return 200
        case 2:
            return 80
        default:
            return 100
        }
    }
}
