//
//  ProductGrid.swift
//  nopcommerce app
//
//  Created by Sandipan on 18/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class ProductGrid: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate , UITableViewDataSource , UIActionSheetDelegate , FloatRatingViewDelegate
{
    var strID = String()
    
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var viewFilterListGrid: UIView!
    @IBOutlet var btnFilter: UIButton!
    @IBOutlet var btnSort: UIButton!
    
    @IBOutlet var CollectionTable: UICollectionView!
    var reuseIdentifier = "STCell"
    
    @IBOutlet var tableLine: UITableView!
    
    var loadingCircle = UIView()
    var circle = UIView()
    
    var arrMProducts = NSMutableArray()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
        //btnListGrid.tag = 1
        //btnListGrid.setImage(UIImage(named: "list"), for: .normal)
        tableLine.isHidden = true
        CollectionTable.isHidden = false
        CollectionTable.reloadData()
    }
    
    // MARK: - viewDidAppear Method
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        //let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let layout = CollectionTable.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 170, height: 210)
        CollectionTable.register(UINib(nibName: "STCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        
        self.tableLine.register(UINib(nibName: "STCellTABLE", bundle: nil), forCellReuseIdentifier: "STCellTABLE")
        self.tableLine.separatorStyle = .singleLine
        
        
        print(strID)
        self.getproductbycategorylist(strID: strID)
      }
    
    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrMProducts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! STCell
        cell.contentView.backgroundColor = UIColor.white
        
        /*cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.cornerRadius = 0.0
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.layer.masksToBounds = true*/
   
        let dictemp: NSDictionary = arrMProducts[indexPath.item] as! NSDictionary
        
        //let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        let  strName = String(format: "%@", dictemp.value(forKey: "Name") as! CVarArg)
        //let  strShortDescription = String(format: "%@", dictemp.value(forKey: "FullDescription") as! CVarArg)
        
        let dicProductPrice: NSDictionary = dictemp.value(forKey: "ProductPrice") as! NSDictionary
        let  strPrice = String(format: "%@", dicProductPrice.value(forKey: "Price") as! CVarArg)
        //let  strDisableWishlistButton = String(format: "%@", dicProductPrice.value(forKey: "DisableWishlistButton") as! CVarArg)
        
        let dicDefaultPictureModel: NSDictionary = dictemp.value(forKey: "DefaultPictureModel") as! NSDictionary
        let  strImageUrl = String(format: "%@", dicDefaultPictureModel.value(forKey: "ImageUrl") as! CVarArg)
        
        let dicReviewOverviewModel: NSDictionary = dictemp.value(forKey: "ReviewOverviewModel") as! NSDictionary
        let  strRatingSum = dicReviewOverviewModel.value(forKey: "RatingSum")
        //let  strTotalReviews = String(format: "%@", dicReviewOverviewModel.value(forKey: "TotalReviews") as! CVarArg)
        print(strRatingSum as Any)
        
        let  strisAddedToWishList = String(format: "%@", dictemp.value(forKey: "isAddedToWishList") as! CVarArg)
        
        cell.lbl1.text = strPrice
        cell.lbl2.text = strName
        
        cell.imgvProduct.imageFromURL(urlString: strImageUrl)
        cell.btnFav.addTarget(self, action: #selector(pressFavAdd), for: .touchUpInside)
        if strisAddedToWishList == "0" {
            cell.btnFav.setImage(UIImage(named: "favdeselected"), for: .normal)
        }
        else{
            cell.btnFav.setImage(UIImage(named: "favselected"), for: .normal)
        }
        
        cell.floatRatingView.backgroundColor = UIColor.clear
        cell.floatRatingView.delegate = self
        cell.floatRatingView.contentMode = UIView.ContentMode.center
        cell.floatRatingView.type = .floatRatings
        cell.floatRatingView.rating = strRatingSum as! Double
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dictemp: NSDictionary = arrMProducts[indexPath.item] as! NSDictionary
        let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        
        let storyBoard = UIStoryboard(name: "SectionTwo6S", bundle: nil)
        let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
        ProductDetails.strID = strid
        self.navigationController?.pushViewController(ProductDetails, animated: true)
        
        
       /* let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
        }
        else if (screenSize.height == 480.0){
        }
        else if(screenSize.height == 667.0){
            let storyBoard = UIStoryboard(name: "SectionTwo6S", bundle: nil)
            let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
            ProductDetails.strID = strid
            self.navigationController?.pushViewController(ProductDetails, animated: true)
        }
        else if(screenSize.height == 736.0){
            let storyBoard = UIStoryboard(name: "SectionTwo6SPlus", bundle: nil)
            let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
            ProductDetails.strID = strid
            self.navigationController?.pushViewController(ProductDetails, animated: true)
        }
        else if(screenSize.height == 812.0){
            let storyBoard = UIStoryboard(name: "SectionTwoXS", bundle: nil)
            let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
            ProductDetails.strID = strid
            self.navigationController?.pushViewController(ProductDetails, animated: true)
        }
        else{
            let storyBoard = UIStoryboard(name: "SectionTwoXSMAX", bundle: nil)
            let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
            ProductDetails.strID = strid
            self.navigationController?.pushViewController(ProductDetails, animated: true)
        }*/
    }
    @objc func pressFavAdd() -> Void
    {
    }
    
    // MARK: - tableView delegate and datasoruce Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMProducts.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 110.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "STCellTABLE", for: indexPath) as! STCellTABLE
        
        let rowimagename = "\(arrMProducts[indexPath.row])"
        
        cell.imgvProduct.image = UIImage(named: rowimagename)
        cell.lblname.text = "Saloman"
        cell.lblCategory.text = "Fresh Fish | Oman"
        cell.lblPrice.text = "47.00 AED"
        
        cell.btnAddFav.addTarget(self, action: #selector(pressFavAddTable), for: .touchUpInside)
        
        cell.floatRatingView.backgroundColor = UIColor.clear
        cell.floatRatingView.delegate = self
        cell.floatRatingView.contentMode = UIView.ContentMode.scaleAspectFit
        cell.floatRatingView.type = .floatRatings
        cell.floatRatingView.rating = 3.3
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictemp: NSDictionary = arrMProducts[indexPath.row] as! NSDictionary
        let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        
        let storyBoard = UIStoryboard(name: "SectionTwo6S", bundle: nil)
        let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
        ProductDetails.strID = strid
        self.navigationController?.pushViewController(ProductDetails, animated: true)
        
       /* let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
        }
        else if (screenSize.height == 480.0){
        }
        else if(screenSize.height == 667.0){
            let storyBoard = UIStoryboard(name: "SectionTwo6S", bundle: nil)
            let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
            ProductDetails.strID = strid
            self.navigationController?.pushViewController(ProductDetails, animated: true)
        }
        else if(screenSize.height == 736.0){
            let storyBoard = UIStoryboard(name: "SectionTwo6SPlus", bundle: nil)
            let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
            ProductDetails.strID = strid
            self.navigationController?.pushViewController(ProductDetails, animated: true)
        }
        else if(screenSize.height == 812.0){
            let storyBoard = UIStoryboard(name: "SectionTwoXS", bundle: nil)
            let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
            ProductDetails.strID = strid
            self.navigationController?.pushViewController(ProductDetails, animated: true)
        }
        else{
            let storyBoard = UIStoryboard(name: "SectionTwoXSMAX", bundle: nil)
            let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
            ProductDetails.strID = strid
            self.navigationController?.pushViewController(ProductDetails, animated: true)
        }*/
    }
    @objc func pressFavAddTable() -> Void
    {
    }
    
    
    // MARK: - press ListGrid Method
    /*@IBAction func pressListGrid(_ sender: Any)
    {
        if btnListGrid.tag == 1
        {
            //list shown
            btnListGrid.tag = 2
            btnListGrid.setImage(UIImage(named: "grid"), for: .normal)
            tableLine.isHidden = false
            CollectionTable.isHidden = true
            tableLine.reloadData()
        }
        else if btnListGrid.tag == 2
        {
            //Grid shown
            btnListGrid.tag = 1
            btnListGrid.setImage(UIImage(named: "list"), for: .normal)
            tableLine.isHidden = true
            CollectionTable.isHidden = false
            CollectionTable.reloadData()
        }
    }*/
    
//    // MARK: - press Sort Method
//    @IBAction func pressSort(_ sender: Any)
//    {
//        let alert = UIAlertController(title: "", message: "Choose option", preferredStyle: .actionSheet)
//
//        alert.addAction(UIAlertAction(title: "Top rated", style: .default , handler:{ (UIAlertAction)in
//            print("User click top rated")
//        }))
//
//        alert.addAction(UIAlertAction(title: "Low to high", style: .default , handler:{ (UIAlertAction)in
//            print("User click Low to high")
//        }))
//
//        alert.addAction(UIAlertAction(title: "High to low", style: .default , handler:{ (UIAlertAction)in
//            print("User click High to low")
//        }))
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive , handler:{ (UIAlertAction)in
//            print("User click Cancel")
//        }))
//
//        self.present(alert, animated: true, completion: {
//            print("completion block")
//        })
//    }
//
//    // MARK: - press Filter Method
//    @IBAction func pressFilter(_ sender: Any)
//    {
//
//    }
    
    
    //MARK: - get productcategorylist method
    func getproductbycategorylist(strID:String)
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"LanguageId":1,"CustomerId":strcustomerid as Any,"CurrencyId":1,"CategoryId":strID,"CatalogPagingResponse":["PageNumber":1,"PageSize":10,"OrderBy":0,"ViewMode":"grid"]] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/GetProductByCategory")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "POST"
        request.setValue(strapikey, forHTTPHeaderField: "apiSecretKey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData : NSData = try! JSONSerialization.data(withJSONObject: parameters) as NSData
        let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
        print("json string = \(jsonString)")
        request.httpBody = jsonData as Data
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
            guard error == nil && data != nil else
            {
                //check for fundamental networking error
                self.hideLoadingMode()
                print("Error=\(String(describing: error))")
                return
            }
            do{
                if let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                {
                    self.hideLoadingMode()
                    
                    let arrm1 :NSArray =  json.value(forKey: "products") as! NSArray
                    self.arrMProducts = NSMutableArray(array: arrm1)
                    print("self.arrMProducts --->",self.arrMProducts)
                    
                    
                    OperationQueue.main.addOperation {
                        self.CollectionTable.reloadData()
                    }
                }
            }
            catch {
                //check for internal server data error
                self.hideLoadingMode()
                print("Error -> \(error)")
            }
        }
        task.resume()
    }
    
    
    // MARK: - showLoadingMode Method
    func showLoadingMode()
    {
        loadingCircle.removeFromSuperview()
        loadingCircle = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        loadingCircle.backgroundColor = UIColor.black
        loadingCircle.alpha = 0.6
        
        circle = UIView ()
        circle.backgroundColor = UIColor.white
        circle.alpha = 1.0
        let size = 60
        let size1 = 60
        var frame = circle.frame
        frame.size.width = CGFloat(size)
        frame.size.height = CGFloat(size1)
        frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
        frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
        circle.frame = frame
        circle.center = self.view.center
        circle.layer.cornerRadius = 30.0
        circle.layer.borderWidth = 1.0
        circle.layer.borderColor=UIColor.white.cgColor
        circle.layer.masksToBounds = true
        
        /*let imgvLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
         imgvLogo.backgroundColor = UIColor.clear
         imgvLogo.image = UIImage(named:"productlogo")
         circle.addSubview(imgvLogo)*/
        
        let  animatedImageView =  UIImageView(frame: circle.bounds)
        animatedImageView.animationImages = NSArray(objects:UIImage(named: "frame-0.png")!,
                                                    UIImage(named: "frame-1.png")!,
                                                    UIImage(named: "frame-2.png")!,
                                                    UIImage(named: "frame-3.png")!,
                                                    UIImage(named: "frame-4.png")!,
                                                    UIImage(named: "frame-5.png")!,
                                                    UIImage(named: "frame-6.png")!,
                                                    UIImage(named: "frame-7.png")!,
                                                    UIImage(named: "frame-8.png")!,
                                                    UIImage(named: "frame-9.png")!,
                                                    UIImage(named: "frame-10.png")!,
                                                    UIImage(named: "frame-11.png")!,
                                                    UIImage(named: "frame-12.png")!,
                                                    UIImage(named: "frame-13.png")!,
                                                    UIImage(named: "frame-14.png")!,
                                                    UIImage(named: "frame-15.png")!,
                                                    UIImage(named: "frame-16.png")!,
                                                    UIImage(named: "frame-17.png")!,
                                                    UIImage(named: "frame-18.png")!,
                                                    UIImage(named: "frame-19.png")!,
                                                    UIImage(named: "frame-20.png")!,
                                                    UIImage(named: "frame-21.png")!,
                                                    UIImage(named: "frame-22.png")!,
                                                    UIImage(named: "frame-23.png")!,
                                                    UIImage(named: "frame-24.png")!,
                                                    UIImage(named: "frame-25.png")!,
                                                    UIImage(named: "frame-26.png")!,
                                                    UIImage(named: "frame-27.png")!,
                                                    UIImage(named: "frame-28.png")!,
                                                    UIImage(named: "frame-29.png")!) as? [UIImage]
        
        animatedImageView.animationDuration = 9
        animatedImageView.animationRepeatCount = 0
        animatedImageView.startAnimating()
        circle.addSubview(animatedImageView)
        circle.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2)
        
        self.view.addSubview(circle)
        self.view.addSubview(loadingCircle)
        self.view.bringSubviewToFront(circle)
        
        
    }
    func hideLoadingMode()
    {
        OperationQueue.main.addOperation {
            self.loadingCircle.removeFromSuperview()
            self.circle.removeFromSuperview()
        }
    }
}
