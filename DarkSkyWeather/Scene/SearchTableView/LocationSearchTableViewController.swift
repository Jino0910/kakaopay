//
//  LocationSearchTableViewController.swift
//  DarkSkyWeather
//
//  Created by rowkaxl on 2019/08/06.
//  Copyright © 2019 rowkaxl. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTableViewController: UITableViewController {

    weak var mapKitDelegate: MapKitProtocol?
    var matchingItems: [MKMapItem] = []
    var location: CLLocation?
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil &&
            selectedItem.thoroughfare != nil) ? " " : ""
        
        // put a comma between street and city/state "274-5", "영화동", "", "경기도"
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) &&
            (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil &&
            selectedItem.administrativeArea != nil) ? " " : ""
        
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number "274-5"
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name "영화동"
            selectedItem.thoroughfare ?? "",
            comma,
            // city "수원시"
            selectedItem.locality ?? "",
            secondSpace,
            // state "경기도"
            selectedItem.administrativeArea ?? ""
        )
        
        if let location = location {
            let point = CLLocation(latitude: selectedItem.coordinate.latitude, longitude: selectedItem.coordinate.longitude)
            return String(format: "%@ %0.2fkm", addressLine, point.distance(from: location)/1000)
        }
        
        return addressLine
    }
    
}

extension LocationSearchTableViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let location = location, let searchBarText = searchController.searchBar.text, !searchBarText.isEmpty else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        
        /*
         MAX ZOOM:
         MKCoordinateSpan(latitudeDelta: 135.68020269231502, longitudeDelta: 131.8359359933973)
         MIN ZOOM:
         MKCoordinateSpan(latitudeDelta: 0.00033266201122472694, longitudeDelta: 0.00059856596270435602)
         */
        
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10) // One degree is always approximately 111 kilometers (69 miles).
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        request.region = region
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            
            
            guard let response = response else { return }
            
            self.matchingItems = response.mapItems.sorted(by: { (mkMapItem1, mkMapItem2) -> Bool in
                let pointA = CLLocation(latitude: mkMapItem1.placemark.coordinate.latitude, longitude: mkMapItem1.placemark.coordinate.longitude)
                let pointB = CLLocation(latitude: mkMapItem2.placemark.coordinate.latitude, longitude: mkMapItem2.placemark.coordinate.longitude)
                
                return pointA.distance(from: location) < pointB.distance(from: location)
            })

            self.tableView.reloadData()
        }
    }
    
}

extension LocationSearchTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
 
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell
    }
    
}

extension LocationSearchTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mapKitDelegate?.selectedLocation(mkMapItem: matchingItems[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
