//
//  MenuViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 7/26/21.
//

import Foundation
import UIKit
import SDWebImage


class NewsFeedViewController: UIViewController, Loadable{
    

    //OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    
    
    //Static Image array to test Collection view slider
    
    var sampleImageArrayString = ["promo", "promo2", "sweepstakes"]
    
    
    //Array to store news feed
    private var newsFeed: [Feed] = []
    
    //News Feed Data Source Manager
    var newsFeedManager = NewsFeedManager()
    
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Display Store Logo on the Title
        setLogoOnTabBarTitle()
        
        
      
        tableView.delegate = self
        tableView.dataSource = self
        
        //Fetch News Feed from api
        fetchFeed()
        
        //Refresh the table view upon scroll
        configureRefreshControl()
        
        
        //Register Custome xib file
        tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil),
                           forCellReuseIdentifier: "PostReusableCell")   
    }
    
    func configureRefreshControl() {
       // Add the refresh control to your UIScrollView object.
        
       tableView.refreshControl = UIRefreshControl()
       tableView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
       // Update your content…
       fetchFeed()
       // Dismiss the refresh control.
       DispatchQueue.main.async {
          self.tableView.refreshControl?.endRefreshing()
       }
    }

    
   func  fetchFeed(){
    //Show loading HUD
    showLoadingView()
    
    newsFeedManager.getNewsFeed(url: constant.newsFeedUrl, expecting: [Feed].self)
        {[weak self] result in
        
        switch result{
        case.success(let feeds):
            
            
            DispatchQueue.main.async {
                self?.newsFeed = feeds
                self?.tableView.reloadData()
            }
            DispatchQueue.main.async {
                self?.hideLoadingView()
            }
        case.failure(let error):
        switch error{
        
        
        case .invalidURL:
                print("url error")
                
        case.requestFailed:
            
            DispatchQueue.main.async {
                Alert.showBasicAlert(on: self!, with:"", message: "Couldn't connect to the server.")
                self?.hideLoadingView()
            }
    
            DispatchQueue.main.async {
                self?.hideLoadingView()
            }
            
            print("Network Error")
            case.responseFailed:
            print("Error 400")
            case.jsonDecodingFailed:
                print("Decoding problem")
           case .invalidImageURL:
            print("URL Image Error!")
        }
        }
        
    }
    
        
    }
    
    
private func setLogoOnTabBarTitle(){
        let navController = tabBarController!
        let image = UIImage(named: "foodBazaarLogo") //Your logo url here
        let imageView = UIImageView(image: image)
        let bannerWidth = navController.tabBar.frame.size.width
        let bannerHeight = navController.tabBar.frame.size.height
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
    
        tabBarController?.navigationItem.titleView = imageView
    
  
    }
    
    
}
//MARK: - Table View Data Source
extension NewsFeedViewController: UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return newsFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostReusableCell", for: indexPath)
        as! NewsFeedCell
        
        
        let imageBannerUrlString = newsFeed[indexPath.row].storeImageURL
        let imageUrlString = newsFeed[indexPath.row].imageURL
        
        
        cell.companyImageView.sd_setImage(with:URL(string: imageBannerUrlString), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, context: .none, progress: .none, completed: nil)

 
        cell.CompanyImagePostView.sd_setImage(with: URL(string: imageUrlString), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, context: .none, progress: .none, completed: nil)

        
        cell.companyNameLabel.text = newsFeed[indexPath.row].storeName
        cell.companyPostTitleLabel.text = newsFeed[indexPath.row].title
        cell.companyPostDetailsLabel.text = newsFeed[indexPath.row].description

        return cell
    }
    
    
    
    
    
    
    
}

//MARK: - Table View Delegate
extension NewsFeedViewController: UITableViewDelegate{
    
    
    
    
    
}


//MARK: - Collection View Data Source and Delegate

extension NewsFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sampleImageArrayString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DataCollectionViewCell
        
        
        cell?.imageBanner.image = UIImage(named:
                                            sampleImageArrayString[indexPath.row])
        
        
        
        
        return cell!
    }
    
    
    
    
    
    
    
}
