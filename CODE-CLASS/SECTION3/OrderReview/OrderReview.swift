//
//  OrderReview.swift
//  nopcommerce app
//
//  Created by Sandipan on 28/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class OrderReview: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var loadingCircle = UIView()
    var circle = UIView()
    
    let cellReuseIdentifier = "cell"
    var stridentifer = NSString()
    @IBOutlet var tabvList: UITableView!
    
    @IBOutlet var lblSubTotal: UILabel!
    @IBOutlet var lblShipping: UILabel!
    @IBOutlet var lblTax: UILabel!
    @IBOutlet var lblOrderTotal: UILabel!
    
    
    var arrMMain = NSMutableArray()
    var dicTempBottom = NSMutableDictionary()
    
    @IBOutlet var viewBottomTotal: UIView!
    @IBOutlet var btnPlaceOrder: UIButton!
    
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
        
        tabvList.backgroundView=nil
        tabvList.backgroundColor=UIColor.clear
        tabvList.separatorColor=UIColor.clear
        tabvList.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        viewBottomTotal.layer.borderColor = UIColor.lightGray.cgColor
        viewBottomTotal.layer.borderWidth = 1.0
        viewBottomTotal.layer.cornerRadius = 0.0
        viewBottomTotal.layer.masksToBounds = true
        
        print(dicTempBottom)
        
        lblSubTotal.text = String(format: "%@", dicTempBottom.value(forKey: "SubTotal") as! CVarArg)
        lblShipping.text = String(format: "%@", dicTempBottom.value(forKey: "Shipping") as! CVarArg)
        lblTax.text = String(format: "%@", dicTempBottom.value(forKey: "Tax") as! CVarArg)
        lblOrderTotal.text = String(format: "%@", dicTempBottom.value(forKey: "OrderTotal") as! CVarArg)
    }
    
    // MARK: - press Back method
    @IBAction func pressBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

    // MARK: - tableView delegate & datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMMain.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier:cellReuseIdentifier)
        
        cell.selectionStyle=UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.none
        cell.backgroundColor=UIColor.white
        cell.clearsContextBeforeDrawing = true
        cell.contentView.clearsContextBeforeDrawing = true
        
        let dictemp: NSDictionary = arrMMain[indexPath.row] as! NSDictionary
        
        //let  strId = String(format: "%@", dictemp.value(forKey: "Id") as! CVarArg)
        //let  strProductId = String(format: "%@", dictemp.value(forKey: "ProductId") as! CVarArg)
        let  strProductName = String(format: "%@", dictemp.value(forKey: "ProductName") as! CVarArg)
        let  strSku = String(format: "%@", dictemp.value(forKey: "Sku") as! CVarArg)
        let  strUnitPrice = String(format: "%@", dictemp.value(forKey: "UnitPrice") as! CVarArg)
        let  strQuantity = String(format: "%@", dictemp.value(forKey: "Quantity") as! CVarArg)
        
        let dicDefaultPictureModel: NSDictionary = dictemp.value(forKey: "Picture") as! NSDictionary
        let  strImageUrl = String(format: "%@", dicDefaultPictureModel.value(forKey: "FullSizeImageUrl") as! CVarArg)
        
        let imgvicon1 = UIImageView(frame: CGRect(x: 15, y: 15, width: 100, height: 80))
        imgvicon1.backgroundColor = UIColor.clear
        imgvicon1.imageFromURL(urlString: strImageUrl)
        cell.contentView.addSubview(imgvicon1)
        
        let label = UILabel(frame: CGRect(x: imgvicon1.frame.maxX + 5, y: 10, width: tableView.frame.size.width - 150, height: 25))
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.backgroundColor = UIColor.clear
        label.numberOfLines=1;
        label.text = strProductName
        label.font = UIFont(name: "Dubai-Regular", size: 17.0)!
        cell.contentView.addSubview(label)
        
        let label1 = UILabel(frame: CGRect(x: imgvicon1.frame.maxX + 5, y: label.frame.maxY, width: 120, height:30))
        label1.text = strSku
        label1.textAlignment = .left
        label1.textColor = UIColor.lightGray
        label1.backgroundColor = UIColor.clear
        label1.font = UIFont(name: "Dubai-Regular", size: 15.0)!
        cell.contentView.addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: imgvicon1.frame.maxX + 5, y: label1.frame.maxY, width: 100, height:30))
        label2.text = strUnitPrice
        label2.textAlignment = .left
        label2.textColor = UIColor(red: 0/255, green: 183/255, blue: 178/255, alpha: 1.0)
        label2.backgroundColor = UIColor.clear
        label2.font = UIFont(name: "Dubai-Medium", size: 15.0)!
        cell.contentView.addSubview(label2)
        
        let lblQty = UILabel(frame: CGRect(x: label2.frame.maxX + 80 , y: label1.frame.minY + 20, width: 60, height: 30))
        lblQty.textAlignment = .center
        lblQty.font = UIFont(name: "Dubai-Bold", size: 15.0)!
        lblQty.text = String(format: "Qty:%@", strQuantity)
        lblQty.textColor = UIColor(red: 0/255, green: 183/255, blue: 178/255, alpha: 1.0)
        lblQty.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        lblQty.layer.borderWidth = 1.0
        lblQty.layer.cornerRadius = 4.0
        lblQty.layer.masksToBounds = true
        cell.contentView.addSubview(lblQty)
        
        let labelSeparator = UILabel(frame: CGRect(x: 0, y: 109.5, width: tableView.frame.size.width, height: 0.5))
        labelSeparator.backgroundColor = UIColor(red: 65/255, green: 65/255, blue: 66/255, alpha: 1.0)
        cell.contentView.addSubview(labelSeparator)
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
    
    
    // MARK: - press Place Order Method
    @IBAction func pressPlaceOrder(_ sender: Any)
    {
        self.confirmOrder()
    }
    
    
    //MARK: - confirmOrder method
    func confirmOrder()
    {
        self.showLoadingMode()
        
        let strapikey = UserDefaults.standard.string(forKey: "apiKey")
        let strcustomerid = UserDefaults.standard.string(forKey: "CustomerId")
        print(strcustomerid as Any)
        
        let parameters = ["StoreId": 1,"CurrencyId":1,"CustomerId":strcustomerid as Any] as [String : Any]
        
        let strconnurl = String(format: "%@%@", Constants.conn.ConnUrl, "api/client/ConfirmOrder")
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
                    
                    let dicTemp1 :NSDictionary = json as! NSDictionary
                    print(dicTemp1)
                    
                    let dicTemp :NSDictionary = json.value(forKey: "CheckoutCompleteResponses") as! NSDictionary
                    let strorderid = String(format: "%@", dicTemp.value(forKey: "OrderId") as! CVarArg)
                    
                    print(dicTemp)
                    print(strorderid)
                    
                    OperationQueue.main.addOperation {
                        
                        let storyBoard = UIStoryboard(name: "SectionThree6S", bundle: nil)
                        let ThankYouOrder = storyBoard.instantiateViewController(withIdentifier: "ThankYouOrder") as! ThankYouOrder
                        ThankYouOrder.hidesBottomBarWhenPushed = true
                        ThankYouOrder.strOrderId = strorderid
                        self.navigationController?.pushViewController(ThankYouOrder, animated: true)
                        
                        
                        /*let screenSize = UIScreen.main.bounds
                        if (screenSize.height == 568.0){
                        }
                        else if (screenSize.height == 480.0){
                        }
                        else if(screenSize.height == 667.0){
                            let storyBoard = UIStoryboard(name: "SectionThree6S", bundle: nil)
                            let ThankYouOrder = storyBoard.instantiateViewController(withIdentifier: "ThankYouOrder") as! ThankYouOrder
                            ThankYouOrder.hidesBottomBarWhenPushed = true
                            ThankYouOrder.strOrderId = strorderid
                            self.navigationController?.pushViewController(ThankYouOrder, animated: true)
                        }
                        else if(screenSize.height == 736.0){
                            let storyBoard = UIStoryboard(name: "SectionThree6SPlus", bundle: nil)
                            let ThankYouOrder = storyBoard.instantiateViewController(withIdentifier: "ThankYouOrder") as! ThankYouOrder
                            ThankYouOrder.hidesBottomBarWhenPushed = true
                            ThankYouOrder.strOrderId = strorderid
                            self.navigationController?.pushViewController(ThankYouOrder, animated: true)
                        }
                        else if(screenSize.height == 812.0){
                            let storyBoard = UIStoryboard(name: "SectionThreeXS", bundle: nil)
                            let ThankYouOrder = storyBoard.instantiateViewController(withIdentifier: "ThankYouOrder") as! ThankYouOrder
                            ThankYouOrder.hidesBottomBarWhenPushed = true
                            ThankYouOrder.strOrderId = strorderid
                            self.navigationController?.pushViewController(ThankYouOrder, animated: true)
                        }
                        else{
                            let storyBoard = UIStoryboard(name: "SectionThreeXSMAX", bundle: nil)
                            let ThankYouOrder = storyBoard.instantiateViewController(withIdentifier: "ThankYouOrder") as! ThankYouOrder
                            ThankYouOrder.hidesBottomBarWhenPushed = true
                            ThankYouOrder.strOrderId = strorderid
                            self.navigationController?.pushViewController(ThankYouOrder, animated: true)
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
