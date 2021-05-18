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
    
    
    @IBOutlet var listTableView: UITableView!
    
    var brands: [Magaza] = []
    let cellId = "customCellid"
    var searchResult: [Magaza] = []
    var lastBrandsKey: String?
    
    var searchController : UISearchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var logOutBttn: UIBarButtonItem!
    @IBOutlet weak var categoryBttn: UIBarButtonItem!
    
    
    @IBOutlet weak var categoryControl: UISegmentedControl!
    
    @IBOutlet weak var segmentControlFloor: UISegmentedControl!
    var minus3: [Magaza] = []
    var minus2: [Magaza] = []
    var minus1: [Magaza] = []
    var minus0: [Magaza] = []
    var positive1: [Magaza] = []
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
    
    
    @IBAction func CategorySelectBttn(_ sender: UIBarButtonItem) {
         
        
    }
    
    @IBAction func FloorSelect(_ sender: UISegmentedControl) {
        
        switch segmentControlFloor.selectedSegmentIndex {
        case 0: sortBrandsAtoZ()
            break
        case 1:
            
            if minus3.count == 0 {
                putBrandsOnFloor()
            }
            sortBrandsAtoZminus3()

            break
        case 2:
            if minus2.count == 0 {
                putBrandsOnFloor()
            }
            sortBrandsAtoZminus2()
            break
        case 3:
            if minus1.count == 0 {
                putBrandsOnFloor()
            }
            sortBrandsAtoZminus1()
            break
        case 4:
            if minus0.count == 0 {
                putBrandsOnFloor()
            }
            sortBrandsAtoZminus0()
            break
        case 5:
            if positive1.count == 0 {
                putBrandsOnFloor()
            }
            sortBrandsAtoZplus1()
            break
        default:
            sortBrandsAtoZ()
            break
        }
        
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
    func nameCheck(brand:Magaza, arr:[Magaza]) -> Bool{
        var same = false
        
        for i in 0..<arr.count {
            if arr[i].name == brand.name {
                print("ayni")
                same = false
            }else{
                print("ayni degil")
                same = true
            }
        }
        return same
        
        
    }
    func putBrandsOnFloor(){
        DispatchQueue.main.async { [self] in
            brands.forEach { maga in
                switch maga.floor.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
                case "metro floor (-2)":
                    if minus2.count == 0{
                        self.minus2.append(maga)
                        minus2 = minus2.sorted(by: {$0.name < $1.name})
                    }else{
                        if nameCheck(brand: maga, arr: minus2) {
                            self.minus2.append(maga)
                            minus2 = minus2.sorted(by: {$0.name < $1.name})
                        }
                    }
                    
                    break
                case "parking floor (-3)":
                    if minus3.count == 0{
                        self.minus3.append(maga)
                        minus3 = minus3.sorted(by: {$0.name < $1.name})
                    }else{
                        if nameCheck(brand: maga, arr: minus3) {
                            self.minus3.append(maga)
                            minus3 = minus3.sorted(by: {$0.name < $1.name})
                        }
                    }
                    break
                case "bosphorus floor (-1)":
                    if minus1.count == 0{
                        self.minus1.append(maga)
                        minus1 = minus1.sorted(by: {$0.name < $1.name})
                    }else{
                        if nameCheck(brand: maga, arr: minus1) {
                            self.minus1.append(maga)
                            minus1 = minus1.sorted(by: {$0.name < $1.name})
                        }
                    }

                    break
                case "square floor (0)":
                    if minus0.count == 0{
                        self.minus0.append(maga)
                        minus0 = minus0.sorted(by: {$0.name < $1.name})
                    }else{
                        if nameCheck(brand: maga, arr: minus0) {
                            self.minus0.append(maga)
                            minus0 = minus0.sorted(by: {$0.name < $1.name})
                        }
                    }

                    break
                case "bridge floor (1)":
                    if positive1.count == 0{
                        self.positive1.append(maga)
                        positive1 = positive1.sorted(by: {$0.name < $1.name})
                    }else{
                        if nameCheck(brand: maga, arr: positive1) {
                            self.positive1.append(maga)
                            positive1 = positive1.sorted(by: {$0.name < $1.name})
                        }
                    }

                    break
                default:
                    if positive1.count == 0{
                        self.positive1.append(maga)
                        positive1 = positive1.sorted(by: {$0.name < $1.name})
                    }else{
                        if nameCheck(brand: maga, arr: positive1) {
                            self.positive1.append(maga)
                            positive1 = positive1.sorted(by: {$0.name < $1.name})
                        }
                    }

                }
            }
        }
    }
    
    func sortBrandsAtoZ() {
        brands = brands.sorted(by: {$0.name < $1.name})
        lastBrandsKey = brands.first?.id
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            self.removeSpinner()
        }
        
    }
    func sortBrandsAtoZminus3() {
        minus3 = minus3.sorted(by: {$0.name < $1.name})
        DispatchQueue.main.async {
            print("reload et")
            self.tableView.reloadData()
        }
        
    }
    func sortBrandsAtoZminus2() {
        minus2 = minus2.sorted(by: {$0.name < $1.name})
        lastBrandsKey = minus2.first?.id
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    func sortBrandsAtoZminus1() {
        minus1 = minus1.sorted(by: {$0.name < $1.name})
        lastBrandsKey = minus1.first?.id
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    func sortBrandsAtoZminus0() {
        minus0 = minus0.sorted(by: {$0.name < $1.name})
        lastBrandsKey = minus0.first?.id
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    func sortBrandsAtoZplus1() {
        positive1 = positive1.sorted(by: {$0.name < $1.name})
        lastBrandsKey = positive1.first?.id
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
            
            switch segmentControlFloor.selectedSegmentIndex {
            case 0: return self.brands.count
                
            case 1:
                return self.minus3.count

            case 2:
                return self.minus2.count
            case 3:
                return self.minus1.count
            case 4:
                return self.minus0.count
            case 5:
                return self.positive1.count
            default:
                return self.brands.count
            }
            
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCellid",for: indexPath) as! CustomTableViewCell
        
        let magaza : Magaza
        switch segmentControlFloor.selectedSegmentIndex {
        case 0: magaza = searchController.isActive ? searchResult[indexPath.row] : brands[indexPath.row]
            break
            
        case 1:
             magaza = searchController.isActive ? searchResult[indexPath.row] : minus3[indexPath.row]
            print(minus3.count)
            break
        case 2:
            magaza = searchController.isActive ? searchResult[indexPath.row] : minus2[indexPath.row]
           break
        case 3:
            magaza = searchController.isActive ? searchResult[indexPath.row] : minus1[indexPath.row]
           break
        case 4:
            magaza = searchController.isActive ? searchResult[indexPath.row] : minus0[indexPath.row]
           break
        case 5:
            magaza = searchController.isActive ? searchResult[indexPath.row] : positive1[indexPath.row]
           break
        default:
            magaza = searchController.isActive ? searchResult[indexPath.row] : brands[indexPath.row]
           break
            
        }
        
//        let magaza = searchController.isActive ? searchResult[indexPath.row] : brands[indexPath.row]
        cell.controller = self
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
