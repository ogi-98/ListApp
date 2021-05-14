//
//  TableViewController.swift
//  ListApp
//
//  Created by Oğuz Kaya on 2.05.2021.
//

import UIKit

class TableViewControllerBrands: UITableViewController, UISearchResultsUpdating{

//    var birinci = Magaza(name: "adidas", category: "giyim", floor: "kat 1", imageUrl: "adidasLogo")
//    var ikinci = Magaza(name: "nike", category: "giyim", floor: "kat 2", imageUrl: "nike")
//    var ucuncu = Magaza(name: "Apple", category: "teknoloji", floor: "kat 0", imageUrl: "appleLogo")
//    var dorduncu = Magaza(name: "Zara", category: "giyim", floor: "kat 2", imageUrl: "zara")
//    var besinci = Magaza(name: "H&M", category: "giyim", floor: "kat 1", imageUrl: "hm")
    
    

    var brands: [Magaza] = []
    let cellId = "customCellid"
    var searchResult: [Magaza] = []
    var lastBrandsKey: String?
    
    var searchController : UISearchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var logOutBttn: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        animals.append(birinci)
//        animals.append(ikinci)
//        animals.append(ucuncu)
//        animals.append(dorduncu)
//        animals.append(besinci)

        tableView.delegate = self
        tableView.dataSource = self
        setupSearchBarController()
        observeBrands()
        
    }
    
    func observeBrands(){
        self.showSpinner()
        Api.BrandsDatabese.getBrands { magaza in
            self.brands.append(magaza)
            self.sortBrandsAtoZ()
            
        } onError: { er in
            self.removeSpinner()
        }

    }
    func sortBrandsAtoZ() {
        brands = brands.sorted(by: {$0.name < $1.name})
        lastBrandsKey = brands.first?.id
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.removeSpinner()
        }
        
    }
    func CheckBrandsName(){
        for n in 0..<self.brands.count - 1 {
            
            if self.brands[n].name.prefix(1) == self.brands[n + 1].name.prefix(1) {
                print("harfler ayni")
            }else{
                self.brands.insert(Magaza(name: String(self.brands[n + 1].name.prefix(1)), category: "", floor: "", imageUrl: "", detailImageUrl: "", detailText: "", phoneNumber: "", webSite: "", id: "\(UUID())"), at: n + 1)
            }
        }
        
        
    }
    
    
    
    @IBAction func logOutPress(_ sender: UIBarButtonItem) {
        
        logOutAlertView(title: "Log Out", message: "Are you sure to log out?") {
            self.showSpinner()
            self.logOutFunction()
        }

    }
    func logOutFunction() {
        Api.User.logOut {
            self.removeSpinner()
            (UIApplication.shared.delegate as! AppDelegate).GoToMainScreen()
        } onError: { (err) in
            self.removeSpinner()
            self.simpleAlertView(title: "", message: err, buttontitle: "Cancel")
        }
    }
    

    func setupSearchBarController() {
        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search brands..."
        searchController.obscuresBackgroundDuringPresentation = false
        if #available(iOS 13.0, *) {
            searchController.searchBar.barTintColor = .secondarySystemBackground
        } else {
            // Fallback on earlier versions
            searchController.searchBar.barTintColor = .white
        }
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    

    func updateSearchResults(for searchController: UISearchController) {
        if  searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || searchController.searchBar.text!.isEmpty {
            view.endEditing(true)
            emptyFilterContent()
        }else {
            let textLowercased = (searchController.searchBar.text?.lowercased())!
            filterContent(for: textLowercased)
        }
        tableView.reloadData()
    }
    func filterContent(for searchText : String){
        searchResult = self.brands.filter {
            return $0.name.lowercased().range(of: searchText) != nil
        }
    }
    func emptyFilterContent(){
        searchResult = self.brands
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive{
            return searchResult.count
        }else{
            return self.brands.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCellid",for: indexPath) as! CustomTableViewCell
        
        
//        cell.textLabel?.text = self.animals[indexPath.row]
//        cell.customName.text = animals[indexPath.row].name
//        cell.customCategory.text = animals[indexPath.row].category
//        cell.customFloor.text = animals[indexPath.row].floor
//        cell.imageView?.image = UIImage(named: animals[indexPath.row].imageUrl)
        let magaza = searchController.isActive ? searchResult[indexPath.row] : brands[indexPath.row]
//        let magazaonceki = searchController.isActive ? searchResult[indexPath.row - 1] : brands[indexPath.row - 1]
        cell.controller = self
//        if indexPath.row == 0 || indexPath.row > brands.count {
//            cell.loadData(magaza, magaza)
//        }else{
//            cell.loadData(magaza,magazaonceki)
//
//        }
        cell.loadData(magaza)
        

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detailsVC = storyBoard.instantiateViewController(withIdentifier: "DetailVC") as! DetailsViewController
            detailsVC.detailImage = cell.resim.image
            detailsVC.detailName = cell.customName.text
            detailsVC.detailFloor = cell.customFloor.text
            detailsVC.detailInfo = cell.customCategory.text
            detailsVC.brand = cell.brand
            self.navigationController?.pushViewController(detailsVC, animated: true)
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
