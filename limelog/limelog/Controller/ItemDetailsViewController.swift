//
//  ItemDetailsViewController.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 11/3/21.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    
    //OUTLETS
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemCalories: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescriptionTextField: UITextView!
    @IBOutlet weak var smallBtn: UIButton!
    @IBOutlet weak var mediumBtn: UIButton!
    @IBOutlet weak var largBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    @IBOutlet weak var addToOrderBtn: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    //Optional value
    var product: Product?
    var favorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
        //Style Size Button
        setBtnStyle(smallBtn)
        setBtnStyle(mediumBtn)
        setBtnStyle(largBtn)
        
        
        addToOrderBtn.layer.cornerRadius = 2
        
        
        if let product = product {
            itemImage.layer.cornerRadius = itemImage.frame.size.height / 2
            let itemImageUrlString = product.urlImage
            
        
            itemImage.sd_setImage(with: URL(string: itemImageUrlString), placeholderImage: UIImage(systemName: "photo"), options: .continueInBackground, context: .none, progress: .none, completed: nil)
            
            
            itemTitle.text = product.title
            itemCalories.text = "\(String(describing: product.calories)) calories"
            itemPrice.text = "$\(String(describing: product.price))"
            
            itemDescriptionTextField.text = product.description
        }else{
            returnToPreviousView()
        }
       
        
    }
    
    //ACTIONS
    @IBAction func addToFavorite(_ sender: Any) {
       
        
        favorite = !favorite
        print("Button Was Pressed: \(favorite)")
        
        if favorite{
            self.favoriteBtn.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            
        }else{
            self.favoriteBtn.setImage(UIImage(systemName: "suit.heart"), for: .normal)
        }
        
  
       
    }
    
    
    //METHODS
    private func setBtnStyle(_ btn: UIButton){
        btn.layer.cornerRadius = btn.frame.size.height/2
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(red: 55/255.0, green: 124/255.0, blue: 99/255.0, alpha: 1.0).cgColor
    }
    
    private func returnToPreviousView(){
        let alert = UIAlertController(title: "Error!", message: "Couldn't Load Data try Again Later", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }

  
    private func selectBtn(_ btn: UIButton){
        btn.setTitleColor(.white, for: .normal)
        btn.layer.backgroundColor = UIColor(red: 55/255.0, green: 124/255.0, blue: 99/255.0, alpha: 1.0).cgColor
    }
    
    private func deselectBtn(_ btn: UIButton){
        btn.setTitleColor(.init(cgColor: CGColor(red: 55/255.0, green: 124/255.0, blue: 99/255.0, alpha: 1.0)), for: .normal)
        btn.layer.backgroundColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
    }
    
    

    @IBAction func stepper(_ sender: UIStepper) {
        
        quantityLabel.text = "\(Decimal(sender.value))"
        
        if sender.value == 100{
            sender.value = 0
            quantityLabel.text = "\(Decimal(sender.value))"
        }
        
        
        
    }
    
    
    
    
    
    
    @IBAction func toggleBtn(sender: UIButton){
        switch sender {
            case smallBtn:
                
                selectBtn(smallBtn)
                deselectBtn(mediumBtn)
                deselectBtn(largBtn)
                
            case mediumBtn:
                selectBtn(mediumBtn)
                deselectBtn(smallBtn)
                deselectBtn(largBtn)
            case largBtn:
            
                selectBtn(largBtn)
                deselectBtn(mediumBtn)
                deselectBtn(smallBtn)
                
            default:
                break

            }
    }
    
    
    
}
