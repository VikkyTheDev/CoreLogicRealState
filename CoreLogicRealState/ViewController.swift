//
//  ViewController.swift
//  CoreLogicRealState
//
//  Created by Mobilecoderz1 on 09/09/20.
//  Copyright © 2020 Mobilecoderz. All rights reserved.
//

import UIKit
import PromiseKit
import CoreLogic
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       authenticate()
       // matchAddress()
    }

    func authenticate(){
        CoreLogicServices.shared.authenticate().done({ (data: CLAuthenticationModel) in
            CoreLogicServices.shared.setAuth(token: data)
            self.matchAddress()
            print("json \(data)")
        }).catch({ (error) in
            print("Error: \(error)")
        }).finally {

        }
    }
    func matchAddress(){
       // let params =   ["q": "5 Tandou Ct Kialla VIC 3631, Australia"]
       // let params =   ["q": "1A/10 Smith St Smithville QLD 4000"]
        let params =   ["q": "3-5 Rawson St, Auburn NSW 2144, Australia"]
        // -33.851620
        // 151.038147
 //"propertyId": 1178371,
        // 16228573 unit
        CoreLogicServices.shared.matchAddress(params: params).done({ (data: CLMatchAddressModel) in
               print("json \(data)")
           }).catch({ (error) in
               print("Error: \(error)")
           }).finally {
               
           }
       }
//    func getProperyDetail(){
//          // let params =   ["q": "5 Tandou Ct Kialla VIC 3631, Australia"]
//          // let params =   ["q": "1A/10 Smith St Smithville QLD 4000"]
//         let params =   ["q": "Smith St Motorway, Southport QLD, Australia"]
//
//
//        coreLogicService.matchAddress(params: params).done({ (data: CLMatchAddressModel) in
//                  print("json \(data)")
//              }).catch({ (error) in
//                  print("Error: \(error)")
//              }).finally {
//
//              }
//          }
}
//"propertySummary": {
//    "address": {
//      "singleLineAddress": "356 Old Windsor Road Seven Hills NSW 2147"
//    },
//    "attributes": {
//      "isCalculatedLandArea": true,
//      "landArea": 30624
//    },
//    "coordinate": {
//      "latitude": -33.77975716,
//      "longitude": 150.96343728
//    },
//    "id": 14208222,
//    "locationIdentifiers": {
//      "councilAreaId": 762,
//      "localityId": 9299,
//      "postCodeId": 101331,
//      "streetId": 277392
//    },
//    "propertyPhoto": {
//      "largePhotoUrl": "https://das-web.corelogic.asia/v1/asset/2NLSZFF6TQI6NLNBSNM6JJA22U/resize;m=exact;w=768;h=512",
//      "mediumPhotoUrl": "https://das-web.corelogic.asia/v1/asset/2NLSZFF6TQI6NLNBSNM6JJA22U/resize;m=exact;w=470;h=313",
//      "scanDate": "2009-07-11",
//      "thumbnailPhotoUrl": "https://das-web.corelogic.asia/v1/asset/2NLSZFF6TQI6NLNBSNM6JJA22U/resize;m=exact;w=120;h=80"
//    },
//    "propertyStatus": {
//      "otmForRent": false,
//      "otmForSale": false,
//      "recentSale": false
//    },
//    "propertySubType": "Commercial",
//    "propertyType": "COMMERCIAL",
//    "radiusSummary": {
//      "distanceFromPoint": "10.55"
//    }
//  }
//}

