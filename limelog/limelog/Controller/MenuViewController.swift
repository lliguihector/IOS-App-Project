//
//  MenuViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 10/24/21.
//

import UIKit

class MenuViewController: UIViewController {

    //OUTLETS
    @IBOutlet weak var tableView: UITableView!
   
    
    //Hold all the food Menue category
    private var foodMenu = [ProductCategory]()
    

    
    //drink
    private var drinks = [category]()
    //All drinks
    private var coffees = [Product]()
    private var sodas = [Product]()
    
    
    //Food
    private var foods = [category]()
    
    
    //All Foods
    private var breakfast = [Product]()
    private var lunch = [Product]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        loadSampleData()
        
        
        tableView.delegate = self
        tableView.dataSource = self

        //Register Cell
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil),
                           forCellReuseIdentifier: "categoryReusableCell")
        
    }
    

    
    
   
    
    
    func loadSampleData(){
        
        
        
        guard let cappuccino = Product(title: "Cappuccino", upc: "1234", description: "Dark, rich expresso lies in wait under a smoothed and stretched layer of thick milk foam. An alchemy of barista artistry and craft.", urlImage: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryItems/cappuccino.jpg", calories: 140, size: "M", price: 5.00)else{
            fatalError("")
        }
        
        guard let icedCoffee = Product(title: "Iced Coffee", upc: "12345", description: "Freshly brewed Starbucks Iced Coffee Blend served chilled and sweetend over ice. An absolutely, seriously, refreshing lift to any day.", urlImage: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryItems/icedCoffee.jpg", calories: 80, size: "M", price: 3.00)else{
            fatalError("")
        }
        
        coffees += [cappuccino,icedCoffee]
        
        
        guard let drink1 = category(categoryTitle: "Coffee", categoryImageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryImages/hotCoffee.jpg", products: coffees)else{
            fatalError("")
        }
        
        guard let dietPepsi = Product(title: "Diet Pepsi", upc: "1234", description: "Dark, rich expresso lies in wait under a smoothed and stretched layer of thick milk foam. An alchemy of barista artistry and craft.", urlImage: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryItems/diet+pepsi.jpeg", calories: 0, size: "M", price: 2.00)else{
            fatalError("")
        }
        
        guard let cokeZero = Product(title: "Coke Zero", upc: "12345", description: "Freshly brewed Starbucks Iced Coffee Blend served chilled and sweetend over ice. An absolutely, seriously, refreshing lift to any day.", urlImage: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryItems/cockeZero.jpg", calories: 0, size: "M", price: 2.00)else{
            fatalError("")
        }
        
        sodas += [dietPepsi,cokeZero]
        

        guard let drink2 = category(categoryTitle: "Sodas", categoryImageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryImages/sodas.jpg", products: sodas)else{
            
            fatalError("")
        }
        
        
        drinks += [drink1,drink2]
        
        let drinkList = ProductCategory(categorySectionTitle: "Drinks", categoriesList: drinks)
        
        
        guard let b1 = Product(title: "Sausage, Cheddar & Egg Sandwich", upc: "1234", description: "A savory patty, fluffy eggs and aged Cheddar cheese served on a perfectly toasty English muffin. An icoonic sandwitch that reminds you why you love breakfast.", urlImage: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryItems/saussageEggSandwitch.jpg", calories: 480, size: "M", price: 6.00)else{
            fatalError("")
        }
        
        guard let b2 = Product(title: "Spinach, Feta & Egg White Wrap", upc: "12345", description: "Some Breakfast Wrap.", urlImage: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryItems/spinachfettaEggWrap.jpg", calories: 290, size: "M", price: 6.00)else{
            fatalError("")
        }
        
        
        breakfast += [b1,b2]
        
        guard let food1 = category(categoryTitle: "BreakFast", categoryImageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryImages/breakfast.jpg", products: breakfast)else{
            fatalError("")
        }
        
        
        
        guard let l1 = Product(title: "Tuna Melt", upc: "1234", description: "A savory patty, fluffy eggs and aged Cheddar cheese served on a perfectly toasty English muffin. An icoonic sandwitch that reminds you why you love breakfast.", urlImage: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryItems/tunaMelt.jpg", calories: 480, size: "M", price: 6.00)else{
            fatalError("")
        }
        
        guard let l2 = Product(title: "Delux Hamburgar Meal", upc: "12345", description: "Some Breakfast Wrap.", urlImage: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryItems/chesseBurgar.jpg", calories: 680, size: "M", price: 6.00)else{
            fatalError("")
        }
        
        
        lunch += [l1,l2]
        
        
        guard let food2 = category(categoryTitle: "Lunch", categoryImageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryImages/lunch.jpg", products: lunch)else{
            fatalError("")
        }
        
        
        
        
        
//        guard let food3 = category(categoryTitle: "Dinner", categoryImageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryImages/dinner.jpg")else{
//            fatalError("")
//        }
//
//        guard let food4 = category(categoryTitle: "Deserts", categoryImageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryImages/desserts.jpg")else{
//            fatalError("")
//        }
//
//        guard let food5 = category(categoryTitle: "Ice Cream", categoryImageUrl: "https://iosapplication.s3.us-east-2.amazonaws.com/categoryImages/icecream.jpg")else{
//            fatalError("")
//        }
        
        foods += [food1,food2]
        
        
        let foodList = ProductCategory(categorySectionTitle: "Food", categoriesList: foods)
        
        
        foodMenu += [drinkList,foodList]
        
        
    }
    
    
 
}

//MARK: -
extension MenuViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
       foodMenu.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        let section = foodMenu[section]
        let rows = section.categoriesList.count
        
        return rows
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryReusableCell", for: indexPath) as! CategoryCell
 
    
//        let foodCategory = foodMenu[indexPath.section].products[indexPath.row]
//
        
        let categoryImageURLString = foodMenu[indexPath.section].categoriesList[indexPath.row].categoryImageUrl
        
        cell.categoryTitle.text = foodMenu[indexPath.section].categoriesList[indexPath.row].categoryTitle
        
        cell.categoryImage.sd_setImage(with: URL(string: categoryImageURLString), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, context: .none, progress: .none, completed: nil)
            

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        
        
        foodMenu[section].categorySectionTitle
    }
    
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 266, height: 30)
    view.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        
       let label = UILabel()
    
        label.textColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.frame = CGRect(x: 15, y: 0, width: view.frame.size.width, height: 24)
        
        view.addSubview(label)

    label.text = self.foodMenu[section].categorySectionTitle
    return view
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
   
}



//MARK: -
extension MenuViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let CategoryListVC =  Storyboard.instantiateViewController(identifier: "CategoryListViewController") as! CategoryListViewController
        
        
        let categoryImageURLString = foodMenu[indexPath.section].categoriesList[indexPath.row].categoryImageUrl
        
        
        let categoryTitle = foodMenu[indexPath.section].categoriesList[indexPath.row].categoryTitle
        
        //Hold all Product items in an array
        let products = foodMenu[indexPath.section].categoriesList[indexPath.row].products
        
    
        CategoryListVC.products = products
        CategoryListVC.categoryTitle = categoryTitle
        CategoryListVC.categoryImageUrlString = categoryImageURLString
        
  
        self.navigationController?.pushViewController(CategoryListVC, animated: true)
 
    }
    
    
    
    
 
    
}

