//
//  ProductsViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 8/7/21.
//

import UIKit

class ProductsViewController: UIViewController {

    
    //OUTLETS
    @IBOutlet weak var tableView: UITableView!

    //Sectioned Array
    private var products = [ProductsByCategory]()
    
    //Sections Row Array
    private var electronics = [ProductsDataModel]()
    private var toys = [ProductsDataModel]()
    private var groceries = [ProductsDataModel]()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Products"

        //Register Custome xib file for tableView Cell
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
     
        loadDummyData()
        
        
    }
    
    
func registerCustomeCell(){
        //Register Custome xib file for tableView Cell
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ReusabelCell")
    }
    
    //Load Static data on table view
    func loadDummyData(){
        
        
        
        
   guard let electronic1 = ProductsDataModel(name: "Playstation 5", category: "Electronic", description: "500GB Gaming Console", imageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/storeProducts/playstation5.png", price: 600.00)
     else{
       fatalError("")
   }
        
        
        guard let electronic2 = ProductsDataModel(name: "11-inch iPad Pro Wi-Fi 128GB Space Grey", category: "Electronic", description: "The new ipad pro with M1 chip", imageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/storeProducts/ipad-pro-11-select-wifi-spacegray-202104.jpg", price: 600.00)else{
            fatalError("")
        }
        
        guard let electronic3 = ProductsDataModel(name: "Magic Keyboard", category: "Electronic", description: "Magic Keyboard delivers a remarkably comfortable and precise typing experience. It’s also wireless and rechargeable, with an incredibly long-lasting internal battery that will power your keyboard for about a month or more between charges.¹ It pairs automatically with your Mac, so you can get to work right away. And it includes a woven USB-C to Lightning Cable that lets you pair and charge by connecting to a USB-C port on your Mac.", imageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/storeProducts/MK2A3.jpg", price: 99.00)else{
            fatalError("")
        }
        
        
        electronics += [electronic1,electronic2,electronic3]
        
        
        
        
        
        guard let toy1 = ProductsDataModel(name: "Celebi Sitting Cuties Plush - 8 In.", category: "Toy", description: "The Celebi Sitting Cuties Plush is weighted with microbeads, so it sits up when you put it on a flat surface. This palm-sized plush is a fun, charming way to show off a favorite Psychic- and Grass-type Mythical Pokémon originally discovered in Johto!", imageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/storeProducts/celebi.jpg", price: 10.99)else{
            fatalError("")
        }
        guard let toy2 = ProductsDataModel(name: "Exploding Kittens Game", category: "Toys", description: "Kittens are super cute, but kittens are also explosive in this Exploding Kittens Game. Backed by Kickstarter, Exploding Kittens is a strategic card game which has only one simple aim - avoid getting blown up by those exploding kittens at all costs. Start the game by putting the cards face down and players take turns drawing cards, until someone draws an exploding kitten card. So, if you like kittens, laser beams and goats, then this deck of cards is sure to keep you occupied for a long time.", imageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/storeProducts/explodingKittens.jpg", price: 19.99)else{
            fatalError()
        }
        toys += [toy1,toy2]
        
        
        guard let grocery1 = ProductsDataModel(name: "Cocoa Puffs Giant Size - 25.8 oz", category: "Grocery", description: "Cocoa Puffs Chocolate Cereal First Ingredient Whole Grain. A whole grain food is made by using all three parts of the grain. All General Mills Big G cereals contain more whole grain than any other single ingredient. 12g whole grain per serving. At least 48 grams recommended daily. No colors from artificial sources and no artificial flavors.", imageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/storeProducts/cocoaPuffs.jpg", price: 4.99)else{
            fatalError("")
        }
        
        groceries += [grocery1]
        
       let electronics = ProductsByCategory(category: "Electronics", items: electronics)
       let toys = ProductsByCategory(category: "Toys", items: toys)
       let groceries = ProductsByCategory(category: "Groceries", items: groceries)
        
       products += [electronics,toys,groceries]
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//
//
//        switch(segue.identifier ?? "") {
//
//        case "ShowProductDetail":
//            guard let productDetailsViewController = segue.destination as? ProductDetails else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//            guard let selectedInvintoryCell = sender as? ProductCell else {
//                fatalError("Unexpected sender: \(String(describing: sender))")
//            }
//            guard let indexPath = tableView.indexPath(for: selectedInvintoryCell) else {
//                fatalError("The selected cell is not being displayed by the table")
//            }
//
//            let name = products[indexPath.section].items[indexPath.row].name
//            let category = products[indexPath.section].items[indexPath.row].category
//            let description = products[indexPath.section].items[indexPath.row].description
//            let imageUrl = products[indexPath.section].items[indexPath.row].imageUrl
//            let price = products[indexPath.section].items[indexPath.row].price
//
//            let item = ProductsDataModel(name: name, category: category, description: description, imageUrl: imageUrl, price: price)
//
////            productDetailsViewController.item = item
//        default:
//            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
//        }
//    }
    
    
    
    
    
    
    
}
//MARK: - UITableViewDataSource
extension ProductsViewController: UITableViewDataSource{
    
    
    //NUMBER OF SECTIONS
    func numberOfSections(in tableView: UITableView) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        products[section].category
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {


        let view = UIView(frame: CGRect( x: 0, y: 0, width: tableView.frame.width,height:40))
        view.backgroundColor = .white
        


        let lable = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.width - 15, height: 20))
        lable.font = lable.font.withSize(20)
        lable.textColor = UIColor(red: 39/255, green: 168/255, blue: 98/255, alpha: 1)
        lable.font = UIFont.boldSystemFont(ofSize: 20.0)
        lable.text = products[section].category
        view.addSubview(lable)

        return view
    }
    
    
    
    //NUMBER OF ROWS IN EACH SECTION
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = products[section]
        let rows = section.items.count
        
        return rows
    }
    
    
    //CELL
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       let cellIdentifier = "ReusableCell"
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProductCell else{
            
            fatalError("The dequeued cell is not an instance of ProductCell")
          
        }
        
        let product = products[indexPath.section].items[indexPath.row]
        let imageURL = product.imageUrl
        let price = "$\(product.price)"
        
        cell.name.text = product.name
        cell.productPrice.text = price
        cell.productImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, context: .none, progress: .none, completed: nil)
        
        
        return cell
    }
    
    
    
    
    
    
    
}
extension ProductsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ProductDetailsVC = Storyboard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
        
        
        let product = products[indexPath.section].items[indexPath.row]
        let name = product.name
        let category = product.category
        let description = product.description
        let imageUrl = product.imageUrl
        let price = product.price
        
        let itemDetails = ProductsDataModel(name: name, category: category, description: description, imageUrl: imageUrl, price: price)
    //Pass the objedct 
        ProductDetailsVC.product = itemDetails!
        
       
        
       
        
       
        self.navigationController?.pushViewController(ProductDetailsVC, animated: true)
    }
    
    
    
}

