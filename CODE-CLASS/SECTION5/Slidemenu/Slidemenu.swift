//
//  Slidemenu.swift
//  nopcommerce app
//
//  Created by Sandipan on 11/07/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class Slidemenu: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    @IBOutlet var viewOverall: UIView!
    @IBOutlet var viewTable: UIView!
    
    @IBOutlet var viewUser: UIView!
    @IBOutlet var imgvUser: UIImageView!
    @IBOutlet var lblUser: UILabel!
    @IBOutlet var lbladdress: UILabel!
    @IBOutlet var lblmobileno: UILabel!
    
    @IBOutlet var viewGuest: UIView!
    @IBOutlet var imgvGuest: UIImageView!
    @IBOutlet var lblGuest: UILabel!
    @IBOutlet var lblOr: UILabel!
    @IBOutlet var btnSignin: UIButton!
    @IBOutlet var btnSignup: UIButton!
    
    
    let cellReuseIdentifier = "cell"
    @IBOutlet var tabvMenu: UITableView!
    
    var arrMSlidemenu = NSMutableArray()
    var arrMSlidemenuImage = NSMutableArray()
    
    // MARK: - viewWillAppear Method
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
         self.navigationController?.isNavigationBarHidden = true
        
        self.viewOverall.alpha = 0.6
        
        //self.tabBarController?.view.removeFromSuperview()
        lblUser.text = "Brett Lee"
        lbladdress.text = "King Fahd Rd, Jizan 82725, Saudi Arabia"
        lblmobileno.text = "+966 11 4845600"
        
        let AlreadyLogin = UserDefaults.standard.integer(forKey: "AlreadyLogin")
        print("AlreadyLogin",AlreadyLogin)
        if (AlreadyLogin == 0)
        {
            print("not logged in")
            viewUser.isHidden = true
            viewGuest.isHidden = false
        }
        else
        {
            print("already logged in")
            viewUser.isHidden = false
            viewGuest.isHidden = true
            
            let dicUser = UserDefaults.standard.value(forKey: "CustomerDetails") as! NSMutableDictionary
            print(dicUser)
            let  str1 = String(format: "%@", dicUser.value(forKey: "FirstName") as! CVarArg)
            let  str2 = String(format: "%@", dicUser.value(forKey: "LastName") as! CVarArg)
            let  str3 = String(format: "%@", dicUser.value(forKey: "EmailId") as! CVarArg)
            let  str4 = String(format: "%@", dicUser.value(forKey: "Phone") as! CVarArg)
            lblUser.text = String(format: "%@ %@", str1,str2)
            lbladdress.text = str3
            lblmobileno.text = str4
        }
        
        
        //----------- Single Tap and Swipe Gesture ---------------//
        let gestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(hideSlide(recognizer:)))
        viewOverall.addGestureRecognizer(gestureRecognizer)
        viewOverall.isUserInteractionEnabled = true
        gestureRecognizer.cancelsTouchesInView = false
        
        let gestureRecognizer1 = UISwipeGestureRecognizer(target: self, action: #selector(hideSlide(recognizer:)))
        gestureRecognizer1.direction = .left
        viewOverall.addGestureRecognizer(gestureRecognizer1)
        viewOverall.isUserInteractionEnabled = true
        gestureRecognizer1.cancelsTouchesInView = false
        
        arrMSlidemenu = ["Home", "Your Wishlist", "Shopping Cart", "Your Orders","Account"]
        arrMSlidemenuImage = ["home-slide","mywishlist-slide","shoppingcart-slide","myorders-slide","user_slide"]
        
        tabvMenu.backgroundView=nil
        tabvMenu.backgroundColor=UIColor.clear
        tabvMenu.separatorColor=UIColor.clear
        tabvMenu.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - pressSignin method
    @IBAction func pressSignin(_ sender: Any)
    {
        
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
    }
    // MARK: - pressSignup method
    @IBAction func pressSignup(_ sender: Any)
    {
        
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
    
    
    // MARK: - gestureSlide method
    @objc func hideSlide(recognizer: UITapGestureRecognizer)
    {
        viewOverall.backgroundColor=UIColor.clear
        UIView.animate(withDuration: 0.4, delay: 0.0, options: [.curveEaseOut], animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: -UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }, completion: { finished in
            self.view .removeFromSuperview()
            self.didMove(toParent: nil)
        })
    }


    // MARK: - tableView delegate & datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrMSlidemenu.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
        headerView.backgroundColor=UIColor.white
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let footerView = UIView()
        footerView.frame=CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0)
        footerView.backgroundColor=UIColor.white
        return footerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier:cellReuseIdentifier)
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.gray
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor=UIColor.white
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let imgvicon = UIImageView(frame: CGRect(x: 15, y: 18, width: 28, height: 28))
        imgvicon.backgroundColor = UIColor.clear
        let rowimagename = "\(arrMSlidemenuImage[indexPath.row])"
        imgvicon.image = UIImage(named:rowimagename)
        cell.contentView.addSubview(imgvicon)
        
        let label = UILabel(frame: CGRect(x: imgvicon.frame.maxX+15, y: 0, width: tableView.frame.size.width, height: 64))
        label.textAlignment = .left
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.darkGray
        label.text = arrMSlidemenu[indexPath.row] as? String
        label.font = UIFont(name: "Dubai-Medium", size: 17.0)!
        
        cell.contentView.addSubview(label)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.view.frame = CGRect(x: 0, y: 0, width: -UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.view .removeFromSuperview()
        self.didMove(toParent: nil)
       
        if indexPath.row == 0
        {
            let storyBoard = UIStoryboard(name: "SectionOne6S", bundle: nil)
            let HomeTab = storyBoard.instantiateViewController(withIdentifier: "HomeTab") as! HomeTab
            self.navigationController?.pushViewController(HomeTab, animated: true)
            
            //HOME
           /* let screenSize = UIScreen.main.bounds
            if (screenSize.height == 568.0){
            }
            else if (screenSize.height == 480.0){
            }
            else if(screenSize.height == 667.0){
                let storyBoard = UIStoryboard(name: "SectionOne6S", bundle: nil)
                let HomeTab = storyBoard.instantiateViewController(withIdentifier: "HomeTab") as! HomeTab
                self.navigationController?.pushViewController(HomeTab, animated: true)
            }
            else if(screenSize.height == 736.0){
                let storyBoard = UIStoryboard(name: "SectionOne6SPlus", bundle: nil)
                let HomeTab = storyBoard.instantiateViewController(withIdentifier: "HomeTab") as! HomeTab
                self.navigationController?.pushViewController(HomeTab, animated: true)
            }
            else if(screenSize.height == 812.0){
                let storyBoard = UIStoryboard(name: "SectionOneXS", bundle: nil)
                let HomeTab = storyBoard.instantiateViewController(withIdentifier: "HomeTab") as! HomeTab
                self.navigationController?.pushViewController(HomeTab, animated: true)
            }
            else{
                let storyBoard = UIStoryboard(name: "SectionOneXSMAX", bundle: nil)
                let HomeTab = storyBoard.instantiateViewController(withIdentifier: "HomeTab") as! HomeTab
                self.navigationController?.pushViewController(HomeTab, animated: true)
            }*/
        }
        else if indexPath.row == 1
        {
            //MYWISHLIST
            
            let storyBoard = UIStoryboard(name: "SectionFour6S", bundle: nil)
            let MyWishlist = storyBoard.instantiateViewController(withIdentifier: "MyWishlist") as! MyWishlist
            self.navigationController?.pushViewController(MyWishlist, animated: true)
            
          /*  let screenSize = UIScreen.main.bounds
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
        else if indexPath.row == 2
        {
            //SHOPPINGCART
            
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
        }
        else if indexPath.row == 3
        {
            //MYORDERS
            
            let storyBoard = UIStoryboard(name: "SectionFour6S", bundle: nil)
            let OrderHistory = storyBoard.instantiateViewController(withIdentifier: "OrderHistory") as! OrderHistory
            self.navigationController?.pushViewController(OrderHistory, animated: true)
            
          /*  let screenSize = UIScreen.main.bounds
            if (screenSize.height == 568.0){
            }
            else if (screenSize.height == 480.0){
            }
            else if(screenSize.height == 667.0){
                let storyBoard = UIStoryboard(name: "SectionFour6S", bundle: nil)
                let OrderHistory = storyBoard.instantiateViewController(withIdentifier: "OrderHistory") as! OrderHistory
                self.navigationController?.pushViewController(OrderHistory, animated: true)
            }
            else if(screenSize.height == 736.0){
                let storyBoard = UIStoryboard(name: "SectionFour6SPlus", bundle: nil)
                let OrderHistory = storyBoard.instantiateViewController(withIdentifier: "OrderHistory") as! OrderHistory
                self.navigationController?.pushViewController(OrderHistory, animated: true)
            }
            else if(screenSize.height == 812.0){
                let storyBoard = UIStoryboard(name: "SectionFourXS", bundle: nil)
                let OrderHistory = storyBoard.instantiateViewController(withIdentifier: "OrderHistory") as! OrderHistory
                self.navigationController?.pushViewController(OrderHistory, animated: true)
            }
            else{
                let storyBoard = UIStoryboard(name: "SectionFourXSMAX", bundle: nil)
                let OrderHistory = storyBoard.instantiateViewController(withIdentifier: "OrderHistory") as! OrderHistory
                self.navigationController?.pushViewController(OrderHistory, animated: true)
            }*/
        }
        else if indexPath.row == 5
        {
            //ACCOUNT
            let storyBoard = UIStoryboard(name: "SectionFour6S", bundle: nil)
            let MyProfileDetails = storyBoard.instantiateViewController(withIdentifier: "MyProfileDetails") as! MyProfileDetails
            self.navigationController?.pushViewController(MyProfileDetails, animated: true)
            
            
           /* let screenSize = UIScreen.main.bounds
            if (screenSize.height == 568.0){
            }
            else if (screenSize.height == 480.0){
            }
            else if(screenSize.height == 667.0){
                let storyBoard = UIStoryboard(name: "SectionFour6S", bundle: nil)
                let MyProfileDetails = storyBoard.instantiateViewController(withIdentifier: "MyProfileDetails") as! MyProfileDetails
                self.navigationController?.pushViewController(MyProfileDetails, animated: true)
            }
            else if(screenSize.height == 736.0){
                let storyBoard = UIStoryboard(name: "SectionFour6SPlus", bundle: nil)
                let MyProfileDetails = storyBoard.instantiateViewController(withIdentifier: "MyProfileDetails") as! MyProfileDetails
                self.navigationController?.pushViewController(MyProfileDetails, animated: true)
            }
            else if(screenSize.height == 812.0){
                let storyBoard = UIStoryboard(name: "SectionFourXS", bundle: nil)
                let MyProfileDetails = storyBoard.instantiateViewController(withIdentifier: "MyProfileDetails") as! MyProfileDetails
                self.navigationController?.pushViewController(MyProfileDetails, animated: true)
            }
            else{
                let storyBoard = UIStoryboard(name: "SectionFourXSMAX", bundle: nil)
                let MyProfileDetails = storyBoard.instantiateViewController(withIdentifier: "MyProfileDetails") as! MyProfileDetails
                self.navigationController?.pushViewController(MyProfileDetails, animated: true)
            }*/
        }
    }
}
