//
//  CartTab.swift
//  nopcommerce app
//
//  Created by Sandipan on 18/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class CartTab: UIViewController,UITextFieldDelegate , UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var btnSlide: UIButton!
    
    @IBOutlet var viewnonCart: UIView!
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var btnSignin: UIButton!
    @IBOutlet var lblOr: UILabel!
    @IBOutlet var lblSignup: UIButton!
    
    @IBOutlet var viewCart: UIView!
    @IBOutlet var tableLine: UITableView!
    
    @IBOutlet var viewBottomTotal: UIView!
    @IBOutlet var lblPriceDetails: UILabel!
    @IBOutlet var lblSubTotal: UILabel!
    @IBOutlet var lblSubTotalValue: UILabel!
    @IBOutlet var lblAmountPayable: UILabel!
    @IBOutlet var lblAmountPayableValue: UILabel!
    
    @IBOutlet var btnProceedtoCheckout: UIButton!
    
    var loadingCircle = UIView()
    var circle = UIView()
    
    var arrMProducts = NSMutableArray()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        
        let AlreadyLogin = UserDefaults.standard.integer(forKey: "AlreadyLogin")
        print("AlreadyLogin",AlreadyLogin)
        if (AlreadyLogin == 0)
        {
            print("not logged in")
            viewCart.isHidden = true
            viewnonCart.isHidden = false
        }
        else
        {
            print("already logged in")
            viewnonCart.isHidden = true
            self.getcartlist()
        }
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

        viewCart.isHidden = true
        viewnonCart.isHidden = true
        
        self.tableLine.register(UINib(nibName: "LCell", bundle: nil), forCellReuseIdentifier: "LCell")
        self.tableLine.separatorStyle = .none
        
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
    
    // MARK: - pressSignin method
    @IBAction func pressSignin(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "SectionFive6S", bundle: nil)
        let login = storyBoard.instantiateViewController(withIdentifier: "login") as! login
        self.navigationController?.pushViewController(login, animated: true)
        
       /* let screenSize = UIScreen.main.bounds
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
    }
    
    // MARK: - pressSignup method
    @IBAction func pressSignup(_ sender: Any) {
        
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
    }
    
    // MARK: - tableView delegate and datasoruce Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMProducts.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 140.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LCell", for: indexPath) as! LCell
        
        let AlreadyLogin = UserDefaults.standard.integer(forKey: "AlreadyLogin")
        print("AlreadyLogin",AlreadyLogin)
        if (AlreadyLogin == 0)
        {
            
        }
        else
        {
            let dictemp: NSDictionary = arrMProducts[indexPath.row] as! NSDictionary
            
            //let  strCARTid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
            //let  strProductId = String(format: "%@", dictemp.value(forKey: "ProductId") as! CVarArg)
            let  strProductName = String(format: "%@", dictemp.value(forKey: "ProductName") as! CVarArg)
            let  strSku = String(format: "%@", dictemp.value(forKey: "Sku") as! CVarArg)
            let  strUnitPrice = String(format: "%@", dictemp.value(forKey: "UnitPrice") as! CVarArg)
            let  strQuantity = String(format: "%@", dictemp.value(forKey: "Quantity") as! CVarArg)
            
            let dicDefaultPictureModel: NSDictionary = dictemp.value(forKey: "Picture") as! NSDictionary
            let  strImageUrl = String(format: "%@", dicDefaultPictureModel.value(forKey: "FullSizeImageUrl") as! CVarArg)
            cell.imgvProduct.imageFromURL(urlString: strImageUrl)
            
            cell.lblname.text = strProductName
            cell.lblCategory.text = strSku
            cell.lblPrice.text = strUnitPrice
            cell.txtQTTY.text = strQuantity
            
            cell.btnMinus.tag = indexPath.row
            cell.btnPlus.tag = indexPath.row
            
            cell.btnMinus.addTarget(self, action: #selector(pressMinus), for: .touchUpInside)
            cell.btnPlus.addTarget(self, action: #selector(pressPlus), for: .touchUpInside)
             
            cell.viewQTY.layer.borderColor = UIColor.lightGray.cgColor
            cell.viewQTY.layer.borderWidth = 1.0
            cell.viewQTY.layer.cornerRadius = 2.0
            cell.viewQTY.layer.masksToBounds = true
            
            let labelSeparator = UILabel(frame: CGRect(x: 15, y: 139.5, width: tableView.frame.size.width, height: 0.5))
            labelSeparator.backgroundColor = UIColor.lightGray
            cell.contentView.addSubview(labelSeparator)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            let dictemp: NSDictionary = arrMProducts[indexPath.item] as! NSDictionary
            let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
            self.removecartlist(streotemid: strid)
        }
    }
    
    // MARK: - press Minus & Plus Method
    @objc func pressMinus(sender:UIButton!)
    {
        let btnsendtag:UIButton = sender
        print(btnsendtag.tag)
        
        let dictemp: NSDictionary = arrMProducts[btnsendtag.tag] as! NSDictionary
        let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        //let  strProductId = String(format: "%@", dictemp.value(forKey: "ProductId") as! CVarArg)
        let  strQuantity = String(format: "%@", dictemp.value(forKey: "Quantity") as! CVarArg)
        var myInt1 = Int(strQuantity)
        
        if myInt1! <= 1 {
            //Not Clickable
        }
        else
        {
            myInt1 = myInt1! - 1
            print(myInt1 as Any)
            
            self.updateqtycartlist(streotemid: strid, strNewQuantity: myInt1!)
        }
    }
    @objc func pressPlus(sender:UIButton!)
    {
        let btnsendtag:UIButton = sender
        print(btnsendtag.tag)
        
        let dictemp: NSDictionary = arrMProducts[btnsendtag.tag] as! NSDictionary
        let  strid = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        //let  strProductId = String(format: "%@", dictemp.value(forKey: "ProductId") as! CVarArg)
        let  strQuantity = String(format: "%@", dictemp.value(forKey: "Quantity") as! CVarArg)
        var myInt1 = Int(strQuantity)
        
        if myInt1! >= 1 {
            myInt1 = myInt1! + 1
            print(myInt1 as Any)
            
            self.updateqtycartlist(streotemid: strid, strNewQuantity: myInt1!)
        }
        else
        {
        }
    }
    
    // MARK: - press ProceedtoCheckout Method
    @IBAction func pressProceedtoCheckout(_ sender: Any)
    {
        let storyBoard = UIStoryboard(name: "SectionThree6S", bundle: nil)
        let BillingAddress = storyBoard.instantiateViewController(withIdentifier: "BillingAddress") as! BillingAddress
        BillingAddress.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(BillingAddress, animated: true)
        
       /* let screenSize = UIScreen.main.bounds
        if (screenSize.height == 568.0){
        }
        else if (screenSize.height == 480.0){
        }
        else if(screenSize.height == 667.0){
            let storyBoard = UIStoryboard(name: "SectionThree6S", bundle: nil)
            let BillingAddress = storyBoard.instantiateViewController(withIdentifier: "BillingAddress") as! BillingAddress
            BillingAddress.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(BillingAddress, animated: true)
        }
        else if(screenSize.height == 736.0){
            let storyBoard = UIStoryboard(name: "SectionThree6SPlus", bundle: nil)
            let BillingAddress = storyBoard.instantiateViewController(withIdentifier: "BillingAddress") as! BillingAddress
            BillingAddress.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(BillingAddress, animated: true)
        }
        else if(screenSize.height == 812.0){
            let storyBoard = UIStoryboard(name: "SectionThreeXS", bundle: nil)
            let BillingAddress = storyBoard.instantiateViewController(withIdentifier: "BillingAddress") as! BillingAddress
            BillingAddress.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(BillingAddress, animated: true)
        }
        else{
            let storyBoard = UIStoryboard(name: "SectionThreeXSMAX", bundle: nil)
            let BillingAddress = storyBoard.instantiateViewController(withIdentifier: "BillingAddress") as! BillingAddress
            BillingAddress.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(BillingAddress, animated: true)
        }*/
    }
    
    
    //MARK: - get cartlist method
    func getcartlist()
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"LanguageId":1,"CurrencyId":1,"CustomerId":strcustomerid as Any] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/Cart")
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
                    
                    let dicttt: NSDictionary = json
                    print(dicttt)
                    
                    let arrm1 :NSArray =  json.value(forKey: "Items") as! NSArray
                    self.arrMProducts = NSMutableArray(array: arrm1)
                    print("self.arrMProducts --->",self.arrMProducts)
                    
                    OperationQueue.main.addOperation {
                        if self.arrMProducts.count > 0
                        {
                            let strsubTotal = json.value(forKey: "subTotal") as! String
                            
                            self.viewCart.isHidden = false
                            self.tableLine.reloadData()
                            
                            self.viewBottomTotal.isHidden = false
                            self.lblSubTotalValue.text = strsubTotal
                            self.lblAmountPayableValue.text = strsubTotal
                            
                            self.btnProceedtoCheckout.isHidden = false
                        }
                        else{
                            
                            self.viewBottomTotal.isHidden = true
                            self.lblSubTotalValue.text = ""
                            self.lblAmountPayableValue.text = ""
                            
                            self.btnProceedtoCheckout.isHidden = true
                            self.tableLine.reloadData()
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
    
    //MARK: - remove cartlist method
    func removecartlist(streotemid:String)
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"LanguageId":1,"CurrencyId":1,"CustomerId":strcustomerid as Any,"ItemIds":streotemid] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/RemoveFromCart")
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
                    
                    OperationQueue.main.addOperation {
                        
                        self.arrMProducts.removeAllObjects()
                        self.tableLine.reloadData()
                        self.getcartlist()
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
    
    //MARK: - update QTY cartlist method
    func updateqtycartlist(streotemid:String,strNewQuantity:Int)
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"LanguageId":1,"CurrencyId":1,"CustomerId":strcustomerid as Any,"ItemId":streotemid,"NewQuantity":strNewQuantity] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/UpdateCart")
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
                    
                    OperationQueue.main.addOperation {
                        
                        self.arrMProducts.removeAllObjects()
                        self.getcartlist()
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
