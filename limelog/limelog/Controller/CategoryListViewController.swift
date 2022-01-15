//
//  CategoryListViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 11/3/21.
//

import UIKit

class CategoryListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryLabelTitle: UILabel!
    @IBOutlet weak var imageBannerView: UIImageView!
    
    var products: [Product]?
    var categoryTitle: String?
    var categoryImageUrlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
           self.navigationController!.navigationBar.shadowImage = UIImage()
           self.navigationController!.navigationBar.isTranslucent = true
        if let categoryImageUrlString = categoryImageUrlString{
            
        imageBannerView.sd_setImage(with: URL(string: categoryImageUrlString), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, context: .none, progress: .none, completed: nil)
            
            
            
        }else{
            print("CategoryImageUrlString is nil couldnt load image to banner View")
        }
        
        
        if let categoryTitle = categoryTitle{
            self.categoryLabelTitle.text = categoryTitle
        }else{
            print("Fatal Error")
            self.categoryLabelTitle.text = "Fattal Error!"
        }
            

        //Register Cell
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil),
                           forCellReuseIdentifier: "categoryReusableCell")
    
    }
    

    

}
//MARK: - Table View Data Source
extension CategoryListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        products!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cellIdentifier = "categoryReusableCell"
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoryCell else{
            fatalError("The dequeued cell is not an instance of ProductCell")
        }
        
    
        let itemImageUrlString = products![indexPath.row].urlImage
        
        
        cell.categoryTitle.text = products![indexPath.row].title
        
        
        
        cell.categoryImage.sd_setImage(with: URL(string: itemImageUrlString), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, context: .none, progress: .none, completed: nil)
        
        
        
        
        return cell
    }
    
    
    
    
    
    
}

//MARK:- Table View Delegate
extension CategoryListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ProductDetailsVC = Storyboard.instantiateViewController(withIdentifier: "ItemDetailsView") as! ItemDetailsViewController
        
        
        let product = products![indexPath.row]

        ProductDetailsVC.product = product
            
            
            
        self.navigationController?.pushViewController(ProductDetailsVC, animated: true)
        
        
        
    }
    
}
