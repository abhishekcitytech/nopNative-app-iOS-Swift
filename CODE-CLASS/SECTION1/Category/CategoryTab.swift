//
//  CategoryTab.swift
//  nopcommerce app
//
//  Created by Sandipan on 25/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class CategoryTab: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet var btnSlide: UIButton!
    @IBOutlet var CollectionTable: UICollectionView!
    var reuseIdentifier = "collectionCELL1"
    
    var arrMProducts = NSMutableArray()
   
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
        
        self.getcategorylist()
    }
    
    // MARK: - viewDidLoad method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Do any additional setup after loading the view.
        //let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let layout = CollectionTable.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 160, height: 160)
        CollectionTable.register(UINib(nibName: "collectionCELL1", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Slide method
    @IBAction func pressSlide(_ sender: Any)
    {
        var obj = Slidemenu()
        let storyBoard = UIStoryboard(name: "SectionFive6S", bundle: nil)
        obj = storyBoard.instantiateViewController(withIdentifier: "Slidemenu") as! Slidemenu
        
       /* let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
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
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrMProducts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! collectionCELL1
        cell.contentView.backgroundColor = UIColor.clear
        
        let dictemp: NSDictionary = arrMProducts[indexPath.row] as! NSDictionary
        
        let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        let  strname = String(format: "%@", dictemp.value(forKey: "Name") as! CVarArg)
        print("%@ -- %@",strid,strname)
        
        let dicImageSrc: NSDictionary = dictemp.value(forKey: "PictureModel") as! NSDictionary
        let  strimage = String(format: "%@", dicImageSrc.value(forKey: "ThumbImageUrl") as! CVarArg)
      
        cell.lbl1.text = strname
        cell.imgvProduct.imageFromURL(urlString: strimage)
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left:0, bottom:0, right:0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let dictemp: NSDictionary = arrMProducts[indexPath.row] as! NSDictionary
        let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        print(strid)

        let storyBoard = UIStoryboard(name: "SectionTwo6S", bundle: nil)
        let ProductSubCategory = storyBoard.instantiateViewController(withIdentifier: "ProductSubCategory") as! ProductSubCategory
        ProductSubCategory.strID = strid
        self.navigationController?.pushViewController(ProductSubCategory, animated: true)
        
        
       /* let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
        }
        else if (screenSize.height == 480.0){
        }
        else if(screenSize.height == 667.0){
            let storyBoard = UIStoryboard(name: "SectionTwo6S", bundle: nil)
            let ProductSubCategory = storyBoard.instantiateViewController(withIdentifier: "ProductSubCategory") as! ProductSubCategory
            ProductSubCategory.strID = strid
            self.navigationController?.pushViewController(ProductSubCategory, animated: true)
        }
        else if(screenSize.height == 736.0){
            let storyBoard = UIStoryboard(name: "SectionTwo6SPlus", bundle: nil)
            let ProductSubCategory = storyBoard.instantiateViewController(withIdentifier: "ProductSubCategory") as! ProductSubCategory
            ProductSubCategory.strID = strid
            self.navigationController?.pushViewController(ProductSubCategory, animated: true)
        }
        else if(screenSize.height == 812.0){
            let storyBoard = UIStoryboard(name: "SectionTwoXS", bundle: nil)
            let ProductSubCategory = storyBoard.instantiateViewController(withIdentifier: "ProductSubCategory") as! ProductSubCategory
            ProductSubCategory.strID = strid
            self.navigationController?.pushViewController(ProductSubCategory, animated: true)
        }
        else{
            let storyBoard = UIStoryboard(name: "SectionTwoXSMAX", bundle: nil)
            let ProductSubCategory = storyBoard.instantiateViewController(withIdentifier: "ProductSubCategory") as! ProductSubCategory
            ProductSubCategory.strID = strid
            self.navigationController?.pushViewController(ProductSubCategory, animated: true)
        }*/
    }
    
    
    
    //MARK: - get categorylist method
    func getcategorylist()
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"LanguageId":1,"CustomerId":strcustomerid as Any] as [String : Any]
    
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/TopMenu")
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

