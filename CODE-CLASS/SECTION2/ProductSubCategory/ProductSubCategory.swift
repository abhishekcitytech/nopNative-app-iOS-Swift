//
//  ProductSubCategory.swift
//  nopcommerce app
//
//  Created by Sandipan on 26/02/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class ProductSubCategory: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var strID = String()
    
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var tableLine: UITableView!
    
    var loadingCircle = UIView()
    var circle = UIView()
    
    var arrMProductsSubCategories = NSMutableArray()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
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
        
        self.tableLine.register(UINib(nibName: "SCCell", bundle: nil), forCellReuseIdentifier: "SCCell")
        self.tableLine.backgroundView=nil
        self.tableLine.backgroundColor=UIColor.clear
        self.tableLine.separatorColor=UIColor.clear
    
        print(strID)
        self.getsubcategorylist(strID: strID)
    }
    
    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - tableView delegate and datasoruce Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMProductsSubCategories.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 105
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SCCell", for: indexPath) as! SCCell
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.selectionStyle = .none
        
        let dictemp: NSDictionary = arrMProductsSubCategories[indexPath.row] as! NSDictionary
        
        let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        let  strname = String(format: "%@", dictemp.value(forKey: "Name") as! CVarArg)
        print("%@ -- %@",strid,strname)
        
        let dicImageSrc: NSDictionary = dictemp.value(forKey: "PictureModel") as! NSDictionary
        let  strimage = String(format: "%@", dicImageSrc.value(forKey: "ThumbImageUrl") as! CVarArg)
        
        cell.lblname.text = strname
        
        cell.imgvProduct.imageFromURL(urlString: strimage)
        cell.imgvProduct.layer.cornerRadius = 4.0
        cell.imgvProduct.layer.masksToBounds = true
        
        let labelSeparator = UILabel(frame: CGRect(x: 15, y: 104.5, width: tableView.frame.size.width, height: 0.5))
        labelSeparator.backgroundColor = UIColor.lightGray
        cell.contentView.addSubview(labelSeparator)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let dictemp: NSDictionary = arrMProductsSubCategories[indexPath.row] as! NSDictionary
        
        let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        let  strhasSubCategories = String(format: "%@", dictemp.value(forKey: "hasSubCategories") as! CVarArg)
        
        print(strid)
        print(strhasSubCategories)
        
        if strhasSubCategories == "0" {
            //No Sub Category . Redirect to product page
            
            let storyBoard = UIStoryboard(name: "SectionTwo6S", bundle: nil)
            let ProductGrid = storyBoard.instantiateViewController(withIdentifier: "ProductGrid") as! ProductGrid
            ProductGrid.strID = strid
            self.navigationController?.pushViewController(ProductGrid, animated: true)
            
            
           /* let screenSize = UIScreen.main.bounds
            if (screenSize.height == 568.0){
            }
            else if (screenSize.height == 480.0){
            }
            else if(screenSize.height == 667.0){
                let storyBoard = UIStoryboard(name: "SectionTwo6S", bundle: nil)
                let ProductGrid = storyBoard.instantiateViewController(withIdentifier: "ProductGrid") as! ProductGrid
                ProductGrid.strID = strid
                self.navigationController?.pushViewController(ProductGrid, animated: true)
            }
            else if(screenSize.height == 736.0){
                let storyBoard = UIStoryboard(name: "SectionTwo6SPlus", bundle: nil)
                let ProductGrid = storyBoard.instantiateViewController(withIdentifier: "ProductGrid") as! ProductGrid
                ProductGrid.strID = strid
                self.navigationController?.pushViewController(ProductGrid, animated: true)
            }
            else if(screenSize.height == 812.0){
                let storyBoard = UIStoryboard(name: "SectionTwoXS", bundle: nil)
                let ProductGrid = storyBoard.instantiateViewController(withIdentifier: "ProductGrid") as! ProductGrid
                ProductGrid.strID = strid
                self.navigationController?.pushViewController(ProductGrid, animated: true)
            }
            else{
                let storyBoard = UIStoryboard(name: "SectionTwoXSMAX", bundle: nil)
                let ProductGrid = storyBoard.instantiateViewController(withIdentifier: "ProductGrid") as! ProductGrid
                ProductGrid.strID = strid
                self.navigationController?.pushViewController(ProductGrid, animated: true)
            }*/
        }
        else
        {
            //Have Sub Category
            OperationQueue.main.addOperation {
                self.getsubcategorylist(strID: strid)
            }
            
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
    
    
    //MARK: - get subcategorylist method
    func getsubcategorylist(strID:String)
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
                    
                    let arrm1 :NSArray =  json.value(forKey: "Categories") as! NSArray
                    self.arrMProductsSubCategories = NSMutableArray(array: arrm1)
                    print("self.arrMProductsSubCategories --->",self.arrMProductsSubCategories)
                    
                    OperationQueue.main.addOperation {
                        self.tableLine.reloadData()
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
