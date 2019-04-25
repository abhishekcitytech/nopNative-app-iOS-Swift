//
//  HomeTab.swift
//  nopcommerce app
//
//  Created by Sandipan on 18/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class HomeTab: UIViewController,UIScrollViewDelegate {

    @IBOutlet var btnSlide: UIButton!
    @IBOutlet var btnSearch: UIButton!
    
    @IBOutlet var viewBanner: UIView!
    @IBOutlet var scrollBanner: UIScrollView!
    var pageControl = UIPageControl()
    
    var  arrMBanners = NSMutableArray()
    
    @IBOutlet var viewFreshProducts: UIView!
    @IBOutlet var lblFreshProducts: UILabel!
    @IBOutlet var scrollFreshProducts: UIScrollView!
    var  arrMFreshProducts = NSMutableArray()
    
    @IBOutlet var viewFrozenProducts: UIView!
    @IBOutlet var lblFrozenProducts: UILabel!
    @IBOutlet var scrollFrozenProducts: UIScrollView!
    var  arrMFrozenProducts = NSMutableArray()
    
    var loadingCircle = UIView()
    var circle = UIView()
    
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
        //let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        //self.tabBarController?.navigationController?.navigationBar.isHidden = true
        
        let datanotSave = UserDefaults.standard.integer(forKey: "dataNotSave")
        print("datanotSave",datanotSave)
        if (datanotSave == 0)
        {
            print("call get authorization method")
            self.getAuthenticationToken()
        }
        else
        {
            print("not call get authorization method")
            self.getBannerUrl()
        }
    }
    
     // MARK: - Slide method
    @IBAction func pressSlide(_ sender: Any)
    {
        var obj = Slidemenu()
        
        let storyBoard = UIStoryboard(name: "SectionFive6S", bundle: nil)
        obj = storyBoard.instantiateViewController(withIdentifier: "Slidemenu") as! Slidemenu
        
       // let screenSize = UIScreen.main.bounds
       /* if (screenSize.height == 568.0){
        }
        else if (screenSize.height == 480.0){
        }
        else if(screenSize.height == 667.0){
            let storyBoard = UIStoryboard(name: "SectionFive6S", bundle: nil)
            obj = storyBoard.instantiateViewController(withIdentifier: "Slidemenu") as! Slidemenu
        }
        else if(screenSize.height == 736.0){
            let storyBoard = UIStoryboard(name: "SectionFive6SPlus", bundle: nil)
            obj = storyBoard.instantiateViewController(withIdentifier: "Slidemenu") as! Slidemenu
        }
        else if(screenSize.height == 812.0){
            let storyBoard = UIStoryboard(name: "SectionFiveXS", bundle: nil)
            obj = storyBoard.instantiateViewController(withIdentifier: "Slidemenu") as! Slidemenu
        }
        else{
            let storyBoard = UIStoryboard(name: "SectionFiveXSMAX", bundle: nil)
            obj = storyBoard.instantiateViewController(withIdentifier: "Slidemenu") as! Slidemenu
        }*/
        
        obj.view.frame=CGRect(x: 0, y: 0, width: -UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.addChild(obj)
        self.view.addSubview(obj.view)
        obj.didMove(toParent: self)
        UIView.animate(withDuration: 0.4, animations: {
            obj.view.frame=CGRect(x:0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }, completion: nil)
    }
    // MARK: - Search method
    @IBAction func pressSearch(_ sender: Any)
    {
    }
    
    // MARK: - pagecontrollerTutorials Method
    func pagecontrollerTutorials() -> Void
    {
        self.automaticallyAdjustsScrollViewInsets=false
        scrollBanner.isPagingEnabled=true
        scrollBanner.showsHorizontalScrollIndicator=false
        scrollBanner.delegate=self;
        scrollBanner.backgroundColor=UIColor.white
        
        let widthhh = scrollBanner.bounds.size.width * CGFloat(arrMBanners.count)
        let heighttt = scrollBanner.bounds.size.height
        scrollBanner.contentSize=CGSize(width: widthhh, height: heighttt)
        
        self.pageControl = UIPageControl(frame: CGRect(x: 0, y: viewBanner.frame.size.height-50, width: 200, height: 60))
        self.pageControl.center = CGPoint (x: viewBanner.frame.size.width/2.0, y: viewBanner.frame.size.height/2.0+150)
        self.pageControl.numberOfPages = arrMBanners.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor(red: 0/255, green: 183/255, blue: 178/255, alpha: 1.0)
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 0/255, green: 183/255, blue: 178/255, alpha: 1.0)
        self.view.addSubview(pageControl)
        self.view.bringSubviewToFront(pageControl)
        
        for x in 0 ..< arrMBanners.count
        {
            
            let widthhh = scrollBanner.bounds.size.width * CGFloat(x)
            
            let viewPage = UIView(frame: CGRect(x: widthhh, y: 0, width: viewBanner.frame.size.width, height: viewBanner.frame.size.height))
            viewPage.tag=x
            scrollBanner.addSubview(viewPage)
            
            let imgviconBG = UIImageView(frame: CGRect(x: 0, y: 0, width: viewPage.frame.size.width, height: viewPage.frame.size.height))
            imgviconBG.backgroundColor = UIColor.clear
            let dictemp: NSDictionary = arrMBanners[x] as! NSDictionary
            let  strimage = String(format: "%@", dictemp.value(forKey: "PictureUrl") as! CVarArg)
            imgviconBG.imageFromURL(urlString: strimage)
            
            viewPage.addSubview(imgviconBG)
        }
    }
    
    // MARK: - create Fresh Products Slider Method
    func createFreshProductsSlide() -> Void
    {
        self.automaticallyAdjustsScrollViewInsets=false
        scrollFreshProducts.isPagingEnabled=true
        scrollFreshProducts.showsHorizontalScrollIndicator=false
        scrollFreshProducts.delegate=self;
        scrollFreshProducts.backgroundColor=UIColor.white
        
        let widthhh = scrollFreshProducts.bounds.size.width/2 * CGFloat(arrMFreshProducts.count)
        let heighttt = scrollFreshProducts.bounds.size.height
        scrollFreshProducts.contentSize=CGSize(width: widthhh, height: heighttt)
        
        for x in 0 ..< arrMFreshProducts.count
        {
            let dictemp: NSDictionary = arrMFreshProducts[x] as! NSDictionary
           
            //let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
            let  strName = String(format: "%@", dictemp.value(forKey: "Name") as! CVarArg)
            //let  strShortDescription = String(format: "%@", dictemp.value(forKey: "FullDescription") as! CVarArg)
            
            let dicProductPrice: NSDictionary = dictemp.value(forKey: "ProductPrice") as! NSDictionary
            let  strPrice = String(format: "%@", dicProductPrice.value(forKey: "Price") as! CVarArg)
            //let  strDisableWishlistButton = String(format: "%@", dicProductPrice.value(forKey: "DisableWishlistButton") as! CVarArg)
            
            let dicDefaultPictureModel: NSDictionary = dictemp.value(forKey: "DefaultPictureModel") as! NSDictionary
            let  strImageUrl = String(format: "%@", dicDefaultPictureModel.value(forKey: "ImageUrl") as! CVarArg)
            
            //let dicReviewOverviewModel: NSDictionary = dictemp.value(forKey: "ReviewOverviewModel") as! NSDictionary
            //let  strRatingSum = dicReviewOverviewModel.value(forKey: "RatingSum")
            //let  strTotalReviews = String(format: "%@", dicReviewOverviewModel.value(forKey: "TotalReviews") as! CVarArg)
            //print(strRatingSum as Any)
            
            let viewPage = UIView(frame: CGRect(x: x * NSInteger(scrollFreshProducts.frame.size.width / 2) + 10 , y: 5, width: NSInteger(scrollFreshProducts.frame.size.width / 2)-20, height: NSInteger(scrollFreshProducts.frame.size.height)-10))
            viewPage.tag=x
            viewPage.backgroundColor = UIColor.white
          
            let imgvProducts = UIImageView(frame: CGRect(x: 5, y: 5, width: viewPage.frame.size.width - 10, height: viewPage.frame.size.height - 45 ))
            imgvProducts.backgroundColor = UIColor.clear
            imgvProducts.imageFromURL(urlString: strImageUrl)
            viewPage.addSubview(imgvProducts)
            
            let lblNameType = UILabel(frame: CGRect(x: 0, y: imgvProducts.frame.maxY, width: viewPage.frame.size.width, height:20))
            lblNameType.textAlignment = .center
            lblNameType.textColor = UIColor(red: 65/255, green: 65/255, blue: 67/255, alpha: 1.0)
            lblNameType.backgroundColor = UIColor.clear
            lblNameType.text = strName
            lblNameType.font = UIFont(name: "Dubai-Regular", size: 13.0)!
            viewPage.addSubview(lblNameType)
            
            let lblPriceUnit = UILabel(frame: CGRect(x: 0, y: lblNameType.frame.maxY, width: viewPage.frame.size.width, height:20))
            lblPriceUnit.textAlignment = .center
            lblPriceUnit.textColor = UIColor(red: 0/255, green: 183/255, blue: 178/255, alpha: 1.0)
            lblPriceUnit.backgroundColor = UIColor.clear
            lblPriceUnit.text = strPrice
            lblPriceUnit.font = UIFont(name: "Dubai-Medium", size: 13.0)!
            viewPage.addSubview(lblPriceUnit)
            
            let btnSelectFresh = UIButton(frame: CGRect(x: viewPage.frame.origin.x, y: viewPage.frame.origin.y, width: viewPage.frame.size.width, height: viewPage.frame.size.width))
            btnSelectFresh.backgroundColor=UIColor.clear
            btnSelectFresh.tag=viewPage.tag
            btnSelectFresh.addTarget(self, action: #selector(pressSelectFresh), for: .touchUpInside)
            viewPage.addSubview(btnSelectFresh)
            
            scrollFreshProducts.addSubview(viewPage)
        }
    }
    @objc func pressSelectFresh(sender:UIButton!)
    {
        let dictemp: NSDictionary = arrMFreshProducts[sender.tag] as! NSDictionary
        let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        print(strid)
        
        let storyBoard = UIStoryboard(name: "SectionTwo6S", bundle: nil)
        let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
        ProductDetails.strID = strid
        self.navigationController?.pushViewController(ProductDetails, animated: true)
    }
    
    // MARK: - create Frozen Products Slider Method
    func createFrozenProductsSlide() -> Void
    {
        self.automaticallyAdjustsScrollViewInsets=false
        scrollFrozenProducts.isPagingEnabled=true
        scrollFrozenProducts.showsHorizontalScrollIndicator=false
        scrollFrozenProducts.delegate=self;
        scrollFrozenProducts.backgroundColor=UIColor.white
        
        let widthhh = scrollFrozenProducts.bounds.size.width/2 * CGFloat(arrMFrozenProducts.count)
        let heighttt = scrollFrozenProducts.bounds.size.height
        scrollFrozenProducts.contentSize=CGSize(width: widthhh, height: heighttt)
        
        for x in 0 ..< arrMFrozenProducts.count
        {
            let dictemp: NSDictionary = arrMFrozenProducts[x] as! NSDictionary
            
            //let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
            let  strName = String(format: "%@", dictemp.value(forKey: "Name") as! CVarArg)
            //let  strShortDescription = String(format: "%@", dictemp.value(forKey: "FullDescription") as! CVarArg)
            
            let dicProductPrice: NSDictionary = dictemp.value(forKey: "ProductPrice") as! NSDictionary
            let  strPrice = String(format: "%@", dicProductPrice.value(forKey: "Price") as! CVarArg)
            //let  strDisableWishlistButton = String(format: "%@", dicProductPrice.value(forKey: "DisableWishlistButton") as! CVarArg)
            
            let dicDefaultPictureModel: NSDictionary = dictemp.value(forKey: "DefaultPictureModel") as! NSDictionary
            let  strImageUrl = String(format: "%@", dicDefaultPictureModel.value(forKey: "ImageUrl") as! CVarArg)
            
            //let dicReviewOverviewModel: NSDictionary = dictemp.value(forKey: "ReviewOverviewModel") as! NSDictionary
            //let  strRatingSum = dicReviewOverviewModel.value(forKey: "RatingSum")
            //let  strTotalReviews = String(format: "%@", dicReviewOverviewModel.value(forKey: "TotalReviews") as! CVarArg)
            //print(strRatingSum as Any)
            
            
            let viewPage = UIView(frame: CGRect(x: x * NSInteger(scrollFrozenProducts.frame.size.width / 3) + 5 , y: 2, width: NSInteger(scrollFrozenProducts.frame.size.width / 3)-10, height: NSInteger(scrollFrozenProducts.frame.size.height)-4))
            viewPage.tag=x
            viewPage.backgroundColor = UIColor.white
            
            let imgvProducts = UIImageView(frame: CGRect(x: 5, y: 5, width: viewPage.frame.size.width-10, height: viewPage.frame.size.height/2 + 10))
            imgvProducts.backgroundColor = UIColor.clear
            imgvProducts.imageFromURL(urlString: strImageUrl)
            viewPage.addSubview(imgvProducts)
            
            let lblNameType = UILabel(frame: CGRect(x: 0, y: imgvProducts.frame.maxY, width: viewPage.frame.size.width, height:20))
            lblNameType.textAlignment = .center
            lblNameType.textColor = UIColor(red: 65/255, green: 65/255, blue: 67/255, alpha: 1.0)
            lblNameType.backgroundColor = UIColor.clear
            lblNameType.text = strName
            lblNameType.font = UIFont(name: "Dubai-Regular", size: 13.0)!
            viewPage.addSubview(lblNameType)
            
            let lblPriceUnit = UILabel(frame: CGRect(x: 0, y: lblNameType.frame.maxY, width: viewPage.frame.size.width, height:20))
            lblPriceUnit.textAlignment = .center
            lblPriceUnit.textColor = UIColor(red: 0/255, green: 183/255, blue: 178/255, alpha: 1.0)
            lblPriceUnit.backgroundColor = UIColor.clear
            lblPriceUnit.text = strPrice
            lblPriceUnit.font = UIFont(name: "Dubai-Medium", size: 13.0)!
            viewPage.addSubview(lblPriceUnit)
           
            let btnSelectFrozen = UIButton(frame: CGRect(x: viewPage.frame.origin.x, y: viewPage.frame.origin.y, width: viewPage.frame.size.width, height: viewPage.frame.size.width))
            btnSelectFrozen.backgroundColor=UIColor.clear
            btnSelectFrozen.tag=viewPage.tag
            btnSelectFrozen.addTarget(self, action: #selector(pressSelectFrozen), for: .touchUpInside)
            viewPage.addSubview(btnSelectFrozen)
            
            scrollFrozenProducts.addSubview(viewPage)
        }
    }
    @objc func pressSelectFrozen(sender:UIButton!)
    {
        let dictemp: NSDictionary = arrMFrozenProducts[sender.tag] as! NSDictionary
        let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        print(strid)
        
        let storyBoard = UIStoryboard(name: "SectionTwo6S", bundle: nil)
        let ProductDetails = storyBoard.instantiateViewController(withIdentifier: "ProductDetails") as! ProductDetails
        ProductDetails.strID = strid
        self.navigationController?.pushViewController(ProductDetails, animated: true)
    }
    
    
    // MARK: - ScrollView Delegate Method
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView.tag == 124
        {
            let pageWidth = scrollBanner.bounds.size.width
            let fractionalPage = scrollBanner.contentOffset.x / pageWidth
            let nearestNumber = lround(Double(fractionalPage))
            if (pageControl.currentPage != nearestNumber){
                pageControl.currentPage = nearestNumber ;
                if (scrollBanner.isDragging){
                    pageControl.updateCurrentPageDisplay()
                }
            }
        }
        else if scrollView.tag == 122
        {
        }
        else if scrollView.tag == 123
        {
        }
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        print("end scroll")
        if scrollView.tag == 124
        {
            pageControl.updateCurrentPageDisplay()
        }
        else if scrollView.tag == 122
        {
        }
        else if scrollView.tag == 123
        {
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        if scrollView.tag == 124
        {
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)
        }
        else if scrollView.tag == 122
        {
        }
        else if scrollView.tag == 123
        {
        }
    }
    
    
    //MARK: - get AuthenticationToken method
    func getAuthenticationToken()
    {
        self.showLoadingMode()
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/GetApiKey")
        let request = NSMutableURLRequest(url: NSURL(string: strconnurl)! as URL)
        request.httpMethod = "GET"
        //request.setValue(strauthkey, forHTTPHeaderField: "Authorization")
        //request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
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
                    
                    print("json --->",json)
                    let dictemp = NSMutableDictionary(dictionary: json)
                    
                    let apiKey = String(format: "%@", dictemp.value(forKey: "apiKey") as! CVarArg)
                    print("apiKey",apiKey)
                   
                    UserDefaults.standard.set(apiKey, forKey: "apiKey")
                    UserDefaults.standard.set(0, forKey: "CustomerId")
                    UserDefaults.standard.set(1, forKey: "dataNotSave")
                    UserDefaults.standard.synchronize()
                    
                    OperationQueue.main.addOperation {
                        self.getBannerUrl()
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
    
    
    //MARK: - get BannerUrl method
    func getBannerUrl()
    {
        self.showLoadingMode()
        
        let parameters = ["StoreId": 1]
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
       
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/NivoSlider")
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
                  
                    let arrMGallery = json.value(forKey: "gallery") as! NSArray
                    self.arrMBanners = NSMutableArray(array: arrMGallery)
                    print("arrMBanners --->",self.arrMBanners)
                    
                    OperationQueue.main.addOperation {
                        self.pagecontrollerTutorials()
                        self.getNewArrival()
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
    
    //MARK: - get NewArrival method
    func getNewArrival()
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"LanguageId":1,"CustomerId":strcustomerid as Any,"CurrencyId":1,"CatalogPagingResponse":["PageNumber":1,"PageSize":10,"OrderBy":0,"ViewMode":"grid"]] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/NewArrivalProductList")
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
                    self.arrMFreshProducts = NSMutableArray(array: arrm1)
                    print("self.arrMFreshProducts --->",self.arrMFreshProducts)
                    
                    
                    OperationQueue.main.addOperation {
                        self.createFreshProductsSlide()
                        self.getHomePageProducts()
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
    
    //MARK: - get HomePageProducts method
    func getHomePageProducts()
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"LanguageId":1,"CustomerId":strcustomerid as Any,"CurrencyId":1,"ProductThumbPictureSize":""] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/HomePageProducts")
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
                    self.arrMFrozenProducts = NSMutableArray(array: arrm1)
                    print("self.arrMFrozenProducts --->",self.arrMFrozenProducts)
                    
                    OperationQueue.main.addOperation {
                        self.createFrozenProductsSlide()
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
        OperationQueue.main.addOperation {
            self.loadingCircle.removeFromSuperview()
        }
        
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

extension UIImageView {
    public func imageFromURL(urlString: String) {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.color =  UIColor(red: 78.0/255, green: 129.0/255, blue: 237.0/255, alpha: 1.0)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        //if self.image == nil{
        //self.addSubview(activityIndicator)
        //}
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
            })
            
        }).resume()
    }
}

