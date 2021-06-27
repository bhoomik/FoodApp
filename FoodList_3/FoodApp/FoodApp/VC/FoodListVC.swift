//
//  FoodListVC.swift
//  FoodApp
//
//  Created by Bhoomi Kathiriya on 27/06/21.
//  Copyright © 2021 Bhoomi Kathiriya. All rights reserved.
//

import UIKit
import MBProgressHUD
let APPDELEGATE         = UIApplication.shared.delegate as! AppDelegate //AppDelegate


class FoodListVC: UIViewController, FoodView {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var arrSearchFoods : [FoodInfo]? = []

    func startLoading() {
        if #available(iOS 13, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate)
            {
                MBProgressHUD.showAdded(to: (sd.window?.rootViewController?.view)!, animated: true)
            }
        }
        else
        {
            MBProgressHUD.showAdded(to: (APPDELEGATE.window?.rootViewController?.view)!, animated: true)
        }

    }
    
    func finishLoading() {
        if #available(iOS 13, *) {
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate)
            {
          
                MBProgressHUD.hide(for: (sd.window?.rootViewController?.view)!, animated: false)                       }
        }
        else
        {
            MBProgressHUD.hide(for: (APPDELEGATE.window?.rootViewController?.view)!, animated: false)                   }

    }
    
    func setFoodData(Food: [FoodInfo]) {
        
        self.arrFoodVM = Food
        DispatchQueue.main.async { () -> Void in
      
            self.finishLoading()
             self.tblFoodList?.reloadData()
            
        }
        print("update Food data",self.arrFoodVM)
    }

    
    


    @IBOutlet weak var tblFoodList  : UITableView?
    private var Foodservice :FoodService!
    private var foodListViewModel :FoodListViewModel!
    var selFoodIndex : Int? = 0
    var isSearching = false


    var arrFoodVM : [FoodInfo]  =  [FoodInfo] ()
    let searchController = UISearchController(searchResultsController: nil)

    
    //MARK: View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
        // Do any additional setup after loading the view.
    }
    

    func commonInit() {
        
       // self.activityIndicator.isHidden = true
        self.tblFoodList?.tableFooterView = UIView()
        self.startLoading()
        self.title = "Food List"
        self.setupSearchBar()
        if(Helper.sharedInstance.checkIntenetConnection() == true)
        {
        self.Foodservice = FoodService()
        self.tblFoodList?.tableFooterView = UIView()
       // self.FoodListViewModel = FoodListViewModel(Foodservice: self.Foodservice)
            self.foodListViewModel = FoodListViewModel(Foodservice:self.Foodservice)
            self.foodListViewModel.attachView(view: self)
        }
        else
        {
            self.showAlertWithCompletion(pTitle:kAppName, pStrMessage: "Please, check your internet connection", completionBlock: nil)
        }
        
    }
    
    fileprivate func setupSearchBar(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.isUserInteractionEnabled = true
        searchController.searchBar.delegate = self;
        // searchController.searchBar.showsCancelButton = true
        if #available(iOS 13.0, *) {
            // searchController.automaticallyShowsCancelButton = true
        } else {
            // Fallback on earlier versions
        }
    }

    
    //MARK: IBAction Methods
    
    @IBAction func btnAscendingClicked(_ sender: UIButton)
    {

       // self.FoodListViewModel.sortAscending(dictFoodInfo: self.arrFoodVM)
        //self.arrFoodVM = self.FoodListViewModel.arrFoodsAscending ?? self.arrFoodVM
        //self.tblFoodList?.reloadData()
        
        
    }
    
    @IBAction func btnDesendingClicked(_ sender: UIButton)
    {
        //self.FoodListViewModel.sortDescending(dictFoodInfo: self.arrFoodVM)
        //self.arrFoodVM = self.FoodListViewModel.arrFoodsDesending ?? self.arrFoodVM
        //self.tblFoodList?.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FoodListVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching
        {
            return self.arrSearchFoods?.count ?? 0
        }
        return self.arrFoodVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : FoodInfoCell = tableView.dequeueReusableCell(withIdentifier: "FoodInfoCell") as! FoodInfoCell
        cell.btnFav?.tag = indexPath.row
        cell.btnFav?.addTarget(self, action: #selector(btnFavClicked(_:)),for:.touchUpInside)

        if(isSearching)
        {
            let objFoodInfo : FoodInfo = self.arrSearchFoods![indexPath.row]
            cell.setupData(objFoodnfo: objFoodInfo)
            return cell

        }
        let objFoodInfo : FoodInfo = self.arrFoodVM[indexPath.row]
        cell.setupData(objFoodnfo: objFoodInfo)
        return cell
    }
    
    @IBAction func btnFavClicked(_ sender: UIButton)
    {
        
        if(self.isSearching)
        {
            var objFoodInfo : FoodInfo = self.arrSearchFoods![sender.tag]
            if(sender.isSelected == true)
            {
            objFoodInfo.isFav = false
                sender.isSelected = false
            }
            else
            {
                objFoodInfo.isFav = true
                    sender.isSelected = true

            }

        }
        else
        {
            var objFoodInfo : FoodInfo = self.arrFoodVM[sender.tag]
            if(sender.isSelected == true)
            {
            objFoodInfo.isFav = false
                sender.isSelected = false
            }
            else
            {
                objFoodInfo.isFav = true
                    sender.isSelected = true
            }
        }

    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.selFoodIndex = indexPath.row
        self.performSegue(withIdentifier: "FoodListToDetail", sender: self)
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("prepare for segue")
        
        if (segue.identifier == "FoodListToDetail")
        {
            let objVC : FoodDetailVC = segue.destination as! FoodDetailVC
            if(self.isSearching == true)
            {
                let objItem  = self.arrSearchFoods![self.selFoodIndex!]
                objVC.setFoodDetail(Food:objItem )

            }
            else
            {
            let objItem  = self.arrFoodVM[self.selFoodIndex!]
            objVC.setFoodDetail(Food:objItem )
            }
        }
        
    }
}
extension FoodListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarButtonClicked(_ searchBar: UISearchBar)
    {
        //print("search bar search button clicked")
        
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.count > 0
        {
            //print("search text is",searchText)
            if (searchText.isEmpty) {
                
                //print("empty search text predicate",self.fetchUserListController.fetchRequest.predicate)
                isSearching = false
            } else {
                isSearching = true
                
                //acutal code
                //In this query group search will only be done if group contains some message
                // let searchMessage1 = NSPredicate(format: "(isAppUser==true OR isGroup == true)AND messageId != nil AND (name contains[c] %@ OR phoneNumber contains[c] %@ OR lastMessage contains[c] %@)" ,searchText,searchText,searchText)
                
                //bhoomi
                
                //with contact usr
                 //  let searchMessage1 = NSPredicate(format: "(isAppUser==true OR isGroup == true) AND (name contains[c] %@ OR phoneNumber contains[c] %@ OR lastMessage contains[c] %@)" ,searchText,searchText,searchText)
                
            }
            do {
                if isSearching{
                }
            } catch {}
            
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // searchBar.showsCancelButton = false
        
        
        //print("search bar cancel clicked")
        
        //bhoomi
        
        //contact user
       // self.fetchUserListController.fetchRequest.predicate = NSPredicate(format: "isAppUser==true AND bareJidStr != %@ AND messageId != nil AND messageId.length > 0 OR  isGroup == true",strMyJid)
       
       
        //non contact user
        
        
        //print("empty search text predicate",self.fetchUserListController.fetchRequest.predicate)
        isSearching = false
        self.tblFoodList?.reloadData()
    }
}

extension FoodListVC: UISearchResultsUpdating {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //searchController.searchBar.showsCancelButton = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    {
        /* if searchBar.text!.count > 0 {
         searchBar.text = ""
         let strMyJid = UserDefaults.standard.getXMPPUsername()! + "@" + hostName
         self.fetchUserListController.fetchRequest.predicate = NSPredicate(format: "bareJidStr != %@",strMyJid)
         isSearching = false
         do {
         try self.fetchUserListController.performFetch()
         self.relaoadTblData()
         } catch {}
         }*/
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.count > 0
        {
            print("search text is end editing",searchText)
            if (searchText.isEmpty) {
                // Do something
                
                //contact user
                   //self.fetchUserListController.fetchRequest.predicate = NSPredicate(format: "isAppUser==true AND bareJidStr != %@",strMyJid)
               
                //non contact user
                
                //print("empty search text predicate",self.fetchUserListController.fetchRequest.predicate)
                isSearching = false
            } else {
                isSearching = true
                
                //actual code
                //let searchMessage1 = NSPredicate(format: "(isAppUser==true OR isGroup == true) AND messageId != nil AND (name contains[c] %@ OR phoneNumber contains[c] %@ OR lastMessage contains[c] %@)" ,searchText,searchText,searchText)
                
                //bhoomi
                //contact user
                  // let searchMessage1 = NSPredicate(format: "(isAppUser==true OR isGroup == true) AND  (name contains[c] %@ OR phoneNumber contains[c] %@ OR lastMessage contains[c] %@)" ,searchText,searchText,searchText)
                
             
                //non contact user
                let searchMessage1 = NSPredicate(format: "(messageId != nil AND messageId.length > 0) AND (name contains[c] %@ OR phoneNumber contains[c] %@ OR jidNoDomain contains[c] %@ OR lastMessage contains[c] %@)" ,searchText,searchText,searchText,searchText)
                
                
                
                //print("search user predicate is",searchMessage1)
                
                //bhoomi
                //let searchMessage = NSPredicate(format: "body contains[c] %@ AND messageStatus != 6",searchText,searchText,searchText)
                
                //print("my jid is",strMyJid)


                //print("search history predicate is1",searchMessage)
                
                
                
                //  self.getChatHistoryData()
            }
            do {
                if isSearching{
                }
               } catch {}
            
        }
        
        
        //print("search bar did end editing")
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController)
    {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.count > 0
        {
            print("search text is update search",searchText)
            if (searchText.isEmpty) {
                // Do something
                
                //bhoomi
                
                //contact user
              //  self.fetchUserListController.fetchRequest.predicate = NSPredicate(format: "isAppUser==true AND bareJidStr != %@",strMyJid)
               
                //non contact user
                
                //print("empty search text predicate",self.fetchUserListController.fetchRequest.predicate)
                isSearching = false
                self.tblFoodList?.reloadData()
            } else {
                isSearching = true
                var strText = String(format: "%@",searchText)
                let filtered2 = self.arrFoodVM.filter { $0.strMeal!.contains(strText) }
                print("arr filtered is",filtered2)

                self.arrSearchFoods = filtered2
                print("arr search is",self.arrSearchFoods)
                self.tblFoodList?.reloadData()



                // let searchMessage1 = NSPredicate(format: "isAppUser==true  AND messageId != nil AND (name contains[c] %@ OR phoneNumber contains[c] %@ OR lastMessage contains[c] %@)" ,searchText,searchText,searchText)
                //actual code
                //In this query group will only be search if gorup contains message
                // let searchMessage1 = NSPredicate(format: "(isAppUser==true  OR isGroup==true)AND messageId != nil AND (name contains[c] %@ OR phoneNumber contains[c] %@ OR lastMessage contains[c] %@)" ,searchText,searchText,searchText)
                
                //bhoomi
                
                //for  contact user
                //let searchMessage1 = NSPredicate(format: "(isAppUser==true  OR isGroup==true)AND  (name contains[c] %@ OR phoneNumber contains[c] %@ OR lastMessage contains[c] %@)" ,searchText,searchText,searchText)
                
                
               // let searchMessage1 = NSPredicate(format: "(name contains[c] %@ OR phoneNumber contains[c] %@ OR lastMessage contains[c] %@)" ,searchText,searchText,searchText)
               
                //for non contact user

                
                //print("search user predicate is",searchMessage1)
                

                //bhoomi
             //   let searchMessage = NSPredicate(format: "body contains[c] %@ AND messageStatus != 6",searchText,searchText,searchText)
                
                //print("my jid is",strMyJid)


                //print("search history predicate is2",searchMessage)
                
            }
            do {
                if isSearching{
                    //print("chat history count after search is",controller?.count)
                    
                }
            } catch {}
            
        }
    }
}
