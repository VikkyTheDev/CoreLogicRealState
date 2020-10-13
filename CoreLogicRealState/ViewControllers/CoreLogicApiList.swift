//
//  CoreLogicApiList.swift
//  CoreLogicRealState
//
//  Created by Mobilecoderz1 on 27/09/20.
//  Copyright © 2020 Mobilecoderz. All rights reserved.
//

import UIKit
import CoreLogic
import PromiseKit
class CoreLogicApiList: UITableViewController {
    var list = ["Match Address","CoreProperyDetail", "PropertyLocation", "SchoolData"]
    var matchAddress: CLMatchAddressModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        let value = list[indexPath.row]
        cell.textLabel?.text = value
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            askForAddress()
        }else if indexPath.row == 1 {
            guard let propertyId = matchAddress?.matchDetails?.propertyId else{
                Banner.show("ProperyId is missing.")
                return
            }
            getPropertyDetail(propertyId: propertyId)
        }else if indexPath.row == 2{
            guard let propertyId = matchAddress?.matchDetails?.propertyId else{
                Banner.show("ProperyId is missing.")
                return
            }
            getPropertyLocation(propertyId: propertyId)
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
extension CoreLogicApiList{
    func askForAddress() {
        let ac = UIAlertController(title: "Enter Address", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Fetch", style: .default) { [weak self] _ in
            let textField = ac.textFields![0]
            print("\(textField.text ?? "No address")")
//            self?.match(address: "3-5 Rawson St, Auburn NSW 2144, Australia")
            self?.match(address: "356 Old Windsor Road Seven Hills NSW 2147")

        }
        
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
    func match(address: String){
        // let params =   ["q": "5 Tandou Ct Kialla VIC 3631, Australia"]
        // let params =   ["q": "1A/10 Smith St Smithville QLD 4000"]
        let params =   ["q": address]
        // -33.851620
        // 151.038147
        //"propertyId": 1178371,
        // 16228573 unit
        CoreLogicServices.shared.matchAddress(params: params).done({ (data: CLMatchAddressModel) in
            print("json \(data)")
            guard let _ = data.matchDetails?.propertyId else{
                Banner.show("Property not matched.")
                return
            }
            self.matchAddress = data
        }).catch({ (error) in
            print("Error: \(error)")
            Banner.show(error.localizedDescription)
        }).finally {
            
        }
    }
    func getPropertyDetail(propertyId: Int){
        CoreLogicServices.shared.corePropertyAttributes(propertyId: propertyId).done({ (data: CLCoreProperyDetail) in
            print("json \(data)")
            
        }).catch({ (error) in
            print("Error: \(error)")
            Banner.show(error.localizedDescription)
        }).finally {
            
        }
        
    }
    func getPropertyLocation(propertyId: Int){
        firstly {
            CoreLogicServices.shared.propertyLocation(propertyId: propertyId)
        }.then { (data: CLPropertyLocation) in
            CoreLogicServices.shared.places(localityId: data.locality!.id!)
        }.done { (data: [CLSchoolPlace]) in
             self.getSchoolDetail(schoolPlaces: data)
        }.catch({ (error) in
            print("Error: \(error)")
            Banner.show(error.localizedDescription)
        }).finally {
            
        }
    }
    func getSchoolDetail(schoolPlaces: [CLSchoolPlace]){
        
        let promise = schoolPlaces.map{ (place) -> Promise<CLSchoolDetail> in
            return CoreLogicServices.shared.schoolDetail(placeId: place.placeId!)
        }
        when(fulfilled: promise).done
            { detail in
                print("getSchoolDetail \(detail)")
                
        }.catch{ error in
            print(error.localizedDescription)
        }
        
    }
    
}

//{
//  "errors": [
//    {
//      "msg": "Property cannot be found for id : 1178371"
//    }
//  ]
//}
//{
//  "propertyType": "COMMERCIAL",
//  "propertySubType": "Commercial",
//  "beds": 0,
//  "baths": 0,
//  "carSpaces": 0,
//  "lockUpGarages": 0,
//  "landArea": 30624,
//  "isCalculatedLandArea": true,
//  "landAreaSource": "Calculated"
//}
