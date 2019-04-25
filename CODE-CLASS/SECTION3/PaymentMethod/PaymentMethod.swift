//
//  PaymentMethod.swift
//  nopcommerce app
//
//  Created by Sandipan on 04/03/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

import BraintreeDropIn
import Braintree

class PaymentMethod: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var clientToken = String()
    
    @IBOutlet var viewTopBar: UIView!
    @IBOutlet var btnBilling: UIButton!
    @IBOutlet var btnShipping: UIButton!
    @IBOutlet var btnDelivery: UIButton!
    @IBOutlet var btnPayment: UIButton!
    
    var selectedIndexPath: IndexPath?
    
    var loadingCircle = UIView()
    var circle = UIView()
    
    @IBOutlet var colList: UICollectionView!
    var reuseIdentifier = "PMCell"
    
    var arrMPaymentMethod = NSMutableArray()
    
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
        
        let layout = colList.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: 160, height: 160)
        colList.register(UINib(nibName: "PMCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(red: 0/255, green: 183/255, blue: 178/255, alpha: 1.0).cgColor
        border.frame = CGRect(x: 0, y: btnPayment.frame.size.height - width, width: btnPayment.frame.size.width, height: btnPayment.frame.size.height)
        border.borderWidth = width
        btnPayment.layer.addSublayer(border)
        btnPayment.layer.masksToBounds = true
        
        
    }

    // MARK: - pressBack method
    @IBAction func pressBack(_ sender: Any) {
    }
    
    // MARK: - UICollectionView Delegate & DataSource Method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrMPaymentMethod.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PMCell
    
        cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        /*cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.contentView.layer.masksToBounds = true*/
        
        if selectedIndexPath != nil && indexPath == selectedIndexPath {
            cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
            
        }else{
            
            cell.backgroundColor = UIColor.white
        }

        
        let dictemp: NSDictionary = arrMPaymentMethod[indexPath.row] as! NSDictionary
        
        let  str1 = String(format: "%@", dictemp.value(forKey: "Name") as! CVarArg)
        
        let  strimage = String(format: "%@", dictemp.value(forKey: "LogoUrl") as! CVarArg)
        cell.imgvLogo.imageFromURL(urlString: strimage)
        
        cell.lbl1.text = str1
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 5, left:5, bottom:5, right:5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! PMCell
        cell.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        self.selectedIndexPath = indexPath
        
        let dictemp: NSDictionary = arrMPaymentMethod[indexPath.row] as! NSDictionary
        let  str1 = String(format: "%@", dictemp.value(forKey: "PaymentMethodSystemName") as! CVarArg)
        self.setPaymentmethod(strPaymentMethodSystemName: str1)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        let cell: PMCell = collectionView.cellForItem(at: indexPath) as! PMCell
        cell.backgroundColor = UIColor.white
        selectedIndexPath = nil
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
    
    //MARK: - set Paymentmethod method
    func setPaymentmethod(strPaymentMethodSystemName:String)
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"LanguageId":1,"CurrencyId":1,"UseRewardPoints":"true","PaymentMethod":strPaymentMethodSystemName,"CustomerId":strcustomerid as Any] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/SelectPaymentMethod")
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
                    
                    let arrm1 :NSArray =  json.value(forKey: "Items") as! NSArray
                    
                    let dictemp = NSMutableDictionary()
                    let  str1 = String(format: "%@", json.value(forKey: "SubTotal") as! CVarArg)
                    let  str2 = String(format: "%@", json.value(forKey: "Shipping") as! CVarArg)
                    let  str3 = String(format: "%@", json.value(forKey: "Tax") as! CVarArg)
                    let  str4 = String(format: "%@", json.value(forKey: "OrderTotal") as! CVarArg)
                    dictemp.setObject(str1, forKey: "SubTotal" as NSCopying)
                    dictemp.setObject(str2, forKey: "Shipping" as NSCopying)
                    dictemp.setObject(str3, forKey: "Tax" as NSCopying)
                    dictemp.setObject(str4, forKey: "OrderTotal" as NSCopying)
                    print(dictemp)
                    
                    OperationQueue.main.addOperation {
                        
                        let storyBoard = UIStoryboard(name: "SectionThree6S", bundle: nil)
                        let OrderReview = storyBoard.instantiateViewController(withIdentifier: "OrderReview") as! OrderReview
                        OrderReview.arrMMain = NSMutableArray(array: arrm1)
                        OrderReview.dicTempBottom = dictemp
                        OrderReview.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(OrderReview, animated: false)
                        
                        
                      /*  let screenSize = UIScreen.main.bounds
                        if (screenSize.height == 568.0){
                        }
                        else if (screenSize.height == 480.0){
                        }
                        else if(screenSize.height == 667.0){
                            let storyBoard = UIStoryboard(name: "SectionThree6S", bundle: nil)
                            let OrderReview = storyBoard.instantiateViewController(withIdentifier: "OrderReview") as! OrderReview
                            OrderReview.arrMMain = NSMutableArray(array: arrm1)
                            OrderReview.dicTempBottom = dictemp
                            OrderReview.hidesBottomBarWhenPushed = true
                            self.navigationController?.pushViewController(OrderReview, animated: false)
                        }
                        else if(screenSize.height == 736.0){
                            let storyBoard = UIStoryboard(name: "SectionThree6SPlus", bundle: nil)
                            let OrderReview = storyBoard.instantiateViewController(withIdentifier: "OrderReview") as! OrderReview
                            OrderReview.arrMMain = NSMutableArray(array: arrm1)
                            OrderReview.dicTempBottom = dictemp
                            OrderReview.hidesBottomBarWhenPushed = true
                            self.navigationController?.pushViewController(OrderReview, animated: false)
                        }
                        else if(screenSize.height == 812.0){
                            let storyBoard = UIStoryboard(name: "SectionThreeXS", bundle: nil)
                            let OrderReview = storyBoard.instantiateViewController(withIdentifier: "OrderReview") as! OrderReview
                            OrderReview.arrMMain = NSMutableArray(array: arrm1)
                            OrderReview.dicTempBottom = dictemp
                            OrderReview.hidesBottomBarWhenPushed = true
                            self.navigationController?.pushViewController(OrderReview, animated: false)
                        }
                        else{
                            let storyBoard = UIStoryboard(name: "SectionThreeXSMAX", bundle: nil)
                            let OrderReview = storyBoard.instantiateViewController(withIdentifier: "OrderReview") as! OrderReview
                            OrderReview.arrMMain = NSMutableArray(array: arrm1)
                            OrderReview.dicTempBottom = dictemp
                            OrderReview.hidesBottomBarWhenPushed = true
                            self.navigationController?.pushViewController(OrderReview, animated: false)
                        }*/
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
    
    //MARK: - Braintree iOS SDK Methods
    /*func fetchClientToken()
    {
        // TODO: Switch this URL to your own authenticated API
        let clientTokenURL = NSURL(string: "https://braintree-sample-merchant.herokuapp.com/client_token")!
        let clientTokenRequest = NSMutableURLRequest(url: clientTokenURL as URL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: clientTokenRequest as URLRequest) { (data, response, error) -> Void in
            // TODO: Handle errors
            self.clientToken = String(data: data!, encoding: String.Encoding.utf8)!
            
            // As an example, you may wish to present Drop-in at this point.
            // Continue to the next section to learn more...
            }.resume()
    }
    func showDropIn(clientTokenOrTokenizationKey: String)
    {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }*/
}
