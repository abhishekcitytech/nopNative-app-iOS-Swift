//
//  ProductDetails.swift
//  nopcommerce app
//
//  Created by Sandipan on 24/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class ProductDetails: UIViewController,UIScrollViewDelegate
{
    var strID = String()
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var btnFav: UIButton!
    @IBOutlet var btnShare: UIButton!
    
    @IBOutlet var scrollOverAll: UIScrollView!
    
    @IBOutlet var viewGallery: UIView!
    @IBOutlet var scrollGallery: UIScrollView!
    
    @IBOutlet var viewMiddle: UIView!
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!
    
    @IBOutlet var viewMiddle1: UIView!
    @IBOutlet var lbl4: UILabel!
    @IBOutlet var txtVDescription: UITextView!
    
    @IBOutlet var viewBottom1: UIView!
    @IBOutlet var btnAddtoCart: UIButton!
    @IBOutlet var lblPrice: UILabel!
    
    var loadingCircle = UIView()
    var circle = UIView()
    
    var pageControl = UIPageControl()
    var  arrMBanners = NSMutableArray()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
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
        
        //scrollOverAll.contentSize = CGSize(width: scrollOverAll.frame.size.width, height: scrollOverAll.frame.size.height + 100)
        
        lbl3.layer.cornerRadius = 4.0
        lbl3.layer.masksToBounds = true
        
       
        scrollOverAll.isHidden = true
        viewBottom1.isHidden = true
        self.getproductDetails(strID: strID)
    }
    
    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - pressFav method
    @IBAction func pressFav(_ sender: Any)
    {
        self.getAddtoFav(strID: strID)
    }
    
    // MARK: - pressShare method
    @IBAction func pressShare(_ sender: Any)
    {
    }
    
    // MARK: - pressAddtoCart method
    @IBAction func pressAddtoCart(_ sender: Any)
    {
        let AlreadyLogin = UserDefaults.standard.integer(forKey: "AlreadyLogin")
        
        if (AlreadyLogin == 0)
        {
            let alert = UIAlertController(title: "", message: "Please continue for shopping", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { action in
                
                let storyBoard = UIStoryboard(name: "SectionFive6S", bundle: nil)
                let login = storyBoard.instantiateViewController(withIdentifier: "login") as! login
                self.navigationController?.pushViewController(login, animated: true)
                
                /*let screenSize = UIScreen.main.bounds
                if (screenSize.height == 568.0){
                }
                else if (screenSize.height == 480.0){
                }
                else if(screenSize.height == 667.0){
                    let storyBoard = UIStoryboard(name: "SectionFive6S", bundle: nil)
                    let login = storyBoard.instantiateViewController(withIdentifier: "login") as! login
                    self.navigationController?.pushViewController(login, animated: true)
                }
                else if(screenSize.height == 736.0){
                    let storyBoard = UIStoryboard(name: "SectionFive6SPlus", bundle: nil)
                    let login = storyBoard.instantiateViewController(withIdentifier: "login") as! login
                    self.navigationController?.pushViewController(login, animated: true)
                }
                else if(screenSize.height == 812.0){
                    let storyBoard = UIStoryboard(name: "SectionFiveXS", bundle: nil)
                    let login = storyBoard.instantiateViewController(withIdentifier: "login") as! login
                    self.navigationController?.pushViewController(login, animated: true)
                }
                else{
                    let storyBoard = UIStoryboard(name: "SectionFiveXSMAX", bundle: nil)
                    let login = storyBoard.instantiateViewController(withIdentifier: "login") as! login
                    self.navigationController?.pushViewController(login, animated: true)
                }*/
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            }))
            
            alert.addAction(UIAlertAction(title: "Signup", style: .default, handler: { action in
                
                let storyBoard = UIStoryboard(name: "SectionFive6S", bundle: nil)
                let Registration = storyBoard.instantiateViewController(withIdentifier: "Registration") as! Registration
                self.navigationController?.pushViewController(Registration, animated: true)
                
               /* let screenSize = UIScreen.main.bounds
                if (screenSize.height == 568.0){
                }
                else if (screenSize.height == 480.0){
                }
                else if(screenSize.height == 667.0){
                    let storyBoard = UIStoryboard(name: "SectionFive6S", bundle: nil)
                    let Registration = storyBoard.instantiateViewController(withIdentifier: "Registration") as! Registration
                    self.navigationController?.pushViewController(Registration, animated: true)
                }
                else if(screenSize.height == 736.0){
                    let storyBoard = UIStoryboard(name: "SectionFive6SPlus", bundle: nil)
                    let Registration = storyBoard.instantiateViewController(withIdentifier: "Registration") as! Registration
                    self.navigationController?.pushViewController(Registration, animated: true)
                }
                else if(screenSize.height == 812.0){
                    let storyBoard = UIStoryboard(name: "SectionFiveXS", bundle: nil)
                    let Registration = storyBoard.instantiateViewController(withIdentifier: "Registration") as! Registration
                    self.navigationController?.pushViewController(Registration, animated: true)
                }
                else{
                    let storyBoard = UIStoryboard(name: "SectionFiveXSMAX", bundle: nil)
                    let Registration = storyBoard.instantiateViewController(withIdentifier: "Registration") as! Registration
                    self.navigationController?.pushViewController(Registration, animated: true)
                }*/
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            print("already logged in")
            self.getAddtoCart(strID: strID)
        }
    }
    
    // MARK: - pagecontroller Gallery Method
    func pagecontrollerGallery() -> Void
    {
        self.automaticallyAdjustsScrollViewInsets=false
        scrollGallery.isPagingEnabled=true
        scrollGallery.showsHorizontalScrollIndicator=false
        scrollGallery.delegate=self;
        scrollGallery.backgroundColor=UIColor.white
        
        let widthhh = scrollGallery.bounds.size.width * CGFloat(arrMBanners.count)
        let heighttt = scrollGallery.bounds.size.height
        scrollGallery.contentSize=CGSize(width: widthhh, height: heighttt)
        
        self.pageControl = UIPageControl(frame: CGRect(x: 0, y: viewGallery.frame.size.height-20, width: 200, height: 20))
        self.pageControl.center = CGPoint (x: viewGallery.frame.size.width/2.0, y: viewGallery.frame.size.height/2.0+100)
        self.pageControl.numberOfPages = arrMBanners.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.blue
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.blue
        scrollOverAll.addSubview(pageControl)
        scrollOverAll.bringSubviewToFront(pageControl)
        
        for x in 0 ..< arrMBanners.count
        {
            print("pages",x)
            let widthhh = scrollGallery.bounds.size.width * CGFloat(x)
            
            let viewPage = UIView(frame: CGRect(x: widthhh, y: 0, width: viewGallery.frame.size.width, height: viewGallery.frame.size.height))
            viewPage.tag=x
            scrollGallery.addSubview(viewPage)
            
            let imgviconBG = UIImageView(frame: CGRect(x: 0, y: 0, width: viewPage.frame.size.width, height: viewPage.frame.size.height))
            imgviconBG.backgroundColor = UIColor.clear
            let dictemp: NSDictionary = arrMBanners[x] as! NSDictionary
            let  strimage = String(format: "%@", dictemp.value(forKey: "FullSizeImageUrl") as! CVarArg)
            imgviconBG.imageFromURL(urlString: strimage)
            imgviconBG.image = UIImage(named:strimage)
            viewPage.addSubview(imgviconBG)
        }
    }
    
    // MARK: - ScrollView Delegate Method
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView.tag == 222
        {
            let pageWidth = scrollGallery.bounds.size.width
            let fractionalPage = scrollGallery.contentOffset.x / pageWidth
            let nearestNumber = lround(Double(fractionalPage))
            if (pageControl.currentPage != nearestNumber){
                pageControl.currentPage = nearestNumber ;
                if (scrollGallery.isDragging){
                    pageControl.updateCurrentPageDisplay()
                }
            }
        }
        else if scrollView.tag == 224
        {
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        print("end scroll")
        if scrollView.tag == 222
        {
            pageControl.updateCurrentPageDisplay()
        }
        else if scrollView.tag == 224
        {
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        if scrollView.tag == 222
        {
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
        }
        else if scrollView.tag == 224
        {
        }
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
    
    
    //MARK: - get productDetails method
    func getproductDetails(strID:String)
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"LanguageId":1,"CustomerId":strcustomerid as Any,"CurrencyId":1,"ProductId":strID,] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/ProductDetail")
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
                    
                    let dictemp = json as NSDictionary
                    print("dictemp --->",dictemp)
                    
                    let arrm1 :NSArray =  dictemp.value(forKey: "PictureModels") as! NSArray
                    self.arrMBanners = NSMutableArray(array: arrm1)
                    
                    let str1 = String(format: "%@", dictemp.value(forKey: "Name") as! CVarArg)
                    let str2 = String(format: "%@", dictemp.value(forKey: "Sku") as! CVarArg)
                    let str3 = String(format: "%@", dictemp.value(forKey: "StockAvailability") as! CVarArg)
                    
                    let  strisAddedToWishList = String(format: "%@", dictemp.value(forKey: "IsAddedToWhishList") as! CVarArg)
                    
                    let dictemp1 = dictemp.value(forKey: "ProductPrice") as! NSDictionary
                    let str4 = String(format: "%@", dictemp1.value(forKey: "Price") as! CVarArg)
                    
                    let htmlString = String(format: "%@", dictemp.value(forKey: "FullDescription") as! CVarArg)
                    let htmlData = NSString(string: htmlString).data(using: String.Encoding.unicode.rawValue)
                    let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                    let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                    
                    OperationQueue.main.addOperation{
                        
                        self.pagecontrollerGallery()
                        self.lbl1.text = str1
                        self.lbl2.text = str2
                        self.lbl3.text = str3
                        self.txtVDescription.attributedText = attributedString
                        self.lblPrice.text = str4
                        
                        if str3 == "In stock"{
                            self.lbl3.backgroundColor = UIColor(red: 0/255, green: 183/255, blue: 178/255, alpha: 1.0)
                        }else{
                            self.lbl3.backgroundColor = UIColor(red: 65/255, green: 65/255, blue: 67/255, alpha: 1.0)
                        }
                        
                        if strisAddedToWishList == "0"
                        {
                            self.btnFav.setImage(UIImage(named: "wishlist-wTop"), for: .normal)
                        }
                        else{
                            self.btnFav.setImage(UIImage(named: "favselected"), for: .normal)
                        }
                        
                        self.scrollOverAll.isHidden = false
                        self.viewBottom1.isHidden = false
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
    
    //MARK: - get AddtoCart method
    func getAddtoCart(strID:String)
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"CurrencyId":1,"CustomerId":strcustomerid as Any,"ProductId":strID,"ShoppingCartTypeId":1,"Quantity":1,"AttributedControlIds":"","RentalStartDate":"","RentalEndDate":""] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/DetailAddProductToCart")
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
                    
                    let dictemp = json as NSDictionary
                    //print("dictemp --->",dictemp)
                    
                    let strCustomerId = String(format: "%@", dictemp.value(forKey: "CustomerId") as! CVarArg)
                    if strCustomerId != ""
                    {
                        //Success
                        
                        let uiAlert = UIAlertController(title: "", message: "Product has been added successfully in your cart", preferredStyle: UIAlertController.Style.alert)
                        self.present(uiAlert, animated: true, completion: nil)
                        uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                            print("Click of default button")
                            
                            let storyBoard = UIStoryboard(name: "SectionOne6S", bundle: nil)
                            let CartTab = storyBoard.instantiateViewController(withIdentifier: "CartTab") as! CartTab
                            self.navigationController?.pushViewController(CartTab, animated: true)
                            
                            
                           /* let screenSize = UIScreen.main.bounds
                            if (screenSize.height == 568.0){
                            }
                            else if (screenSize.height == 480.0){
                            }
                            else if(screenSize.height == 667.0){
                                let storyBoard = UIStoryboard(name: "SectionOne6S", bundle: nil)
                                let CartTab = storyBoard.instantiateViewController(withIdentifier: "CartTab") as! CartTab
                                self.navigationController?.pushViewController(CartTab, animated: true)
                            }
                            else if(screenSize.height == 736.0){
                                let storyBoard = UIStoryboard(name: "SectionOne6SPlus", bundle: nil)
                                let CartTab = storyBoard.instantiateViewController(withIdentifier: "CartTab") as! CartTab
                                self.navigationController?.pushViewController(CartTab, animated: true)
                            }
                            else if(screenSize.height == 812.0){
                                let storyBoard = UIStoryboard(name: "SectionOneXS", bundle: nil)
                                let CartTab = storyBoard.instantiateViewController(withIdentifier: "CartTab") as! CartTab
                                self.navigationController?.pushViewController(CartTab, animated: true)
                            }
                            else{
                                let storyBoard = UIStoryboard(name: "SectionOneXSMAX", bundle: nil)
                                let CartTab = storyBoard.instantiateViewController(withIdentifier: "CartTab") as! CartTab
                                self.navigationController?.pushViewController(CartTab, animated: true)
                            }*/
                        }))
                    }
                    else
                    {
                        //Not cmpleted
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
    
    
    //MARK: - get AddtoFav method
    func getAddtoFav(strID:String)
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"CurrencyId":1,"CustomerId":strcustomerid as Any,"ProductId":strID,"ShoppingCartTypeId":2,"Quantity":1,"AttributedControlIds":"","RentalStartDate":"","RentalEndDate":""] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/DetailAddProductToCart")
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
                    
                    let dictemp = json as NSDictionary
                    //print("dictemp --->",dictemp)
                    let strCustomerId = String(format: "%@", dictemp.value(forKey: "CustomerId") as! CVarArg)
                    
                    OperationQueue.main.addOperation{
                        self.btnFav.isSelected = true
                        if strCustomerId != ""
                        {
                            //Success
                            self.btnFav.setImage(UIImage(named: "favselected"), for: .normal)
                            
                            let uiAlert = UIAlertController(title: "", message: "Product successfully added in your wishlist", preferredStyle: UIAlertController.Style.alert)
                            self.present(uiAlert, animated: true, completion: nil)
                            uiAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                                print("Click of default button")
                                
                                let storyBoard = UIStoryboard(name: "SectionFour6S", bundle: nil)
                                let MyWishlist = storyBoard.instantiateViewController(withIdentifier: "MyWishlist") as! MyWishlist
                                self.navigationController?.pushViewController(MyWishlist, animated: true)
                                
                                
                               /* let screenSize = UIScreen.main.bounds
                                if (screenSize.height == 568.0){
                                }
                                else if (screenSize.height == 480.0){
                                }
                                else if(screenSize.height == 667.0){
                                    let storyBoard = UIStoryboard(name: "SectionFour6S", bundle: nil)
                                    let MyWishlist = storyBoard.instantiateViewController(withIdentifier: "MyWishlist") as! MyWishlist
                                    self.navigationController?.pushViewController(MyWishlist, animated: true)
                                }
                                else if(screenSize.height == 736.0){
                                    let storyBoard = UIStoryboard(name: "SectionFour6SPlus", bundle: nil)
                                    let MyWishlist = storyBoard.instantiateViewController(withIdentifier: "MyWishlist") as! MyWishlist
                                    self.navigationController?.pushViewController(MyWishlist, animated: true)
                                }
                                else if(screenSize.height == 812.0){
                                    let storyBoard = UIStoryboard(name: "SectionFourXS", bundle: nil)
                                    let MyWishlist = storyBoard.instantiateViewController(withIdentifier: "MyWishlist") as! MyWishlist
                                    self.navigationController?.pushViewController(MyWishlist, animated: true)
                                }
                                else{
                                    let storyBoard = UIStoryboard(name: "SectionFourXSMAX", bundle: nil)
                                    let MyWishlist = storyBoard.instantiateViewController(withIdentifier: "MyWishlist") as! MyWishlist
                                    self.navigationController?.pushViewController(MyWishlist, animated: true)
                                }*/
                            }
                            
                            
                            ))
                        }
                        else
                        {
                            //Not cmpleted
                        }
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
}
