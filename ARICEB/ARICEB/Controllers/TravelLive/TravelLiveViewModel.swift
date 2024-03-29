//
//  TravelLiveViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 04/07/21.
//

import MapKit

class TravelLiveViewModel {
    
    private var routes: [MKRoute]?
    private var direction = MKDirections.Request()
    var didShowRoutes: (([MKRoute]?) -> Void)?
    
    func getRoute(originLat: Double?,originLong: Double?,
                  destinyLat:Double?,destinyLong: Double?) {
        
        guard let originLatValue = originLat else {return}
        guard let originLongValue = originLong else {return}
        guard let destinyLatValue = destinyLat else {return}
        guard let destinyLongValue = destinyLong else {return}
        
        let originCoord = CLLocationCoordinate2D(latitude: CLLocationDegrees(originLatValue), longitude: CLLocationDegrees(originLongValue))
        let origin = MKMapItem(placemark: MKPlacemark(coordinate: originCoord))
        direction.source = origin
        
        let destinyCoord = CLLocationCoordinate2D(latitude: CLLocationDegrees(destinyLatValue), longitude: CLLocationDegrees(destinyLongValue))
        let destiny = MKMapItem(placemark: MKPlacemark(coordinate: destinyCoord))
        direction.destination = destiny
        direction.requestsAlternateRoutes = false
        
        let directionRequest = MKDirections(request: direction)
        directionRequest.calculate { [weak self] (response, error) in
            if let errorValue = error {
                //implementar closure para exibir mensagem de erro
                print("deu ruim!!")
            }
            
            guard let responseValue = response else {
                //implementar closure para exibir mensagem de erro
                print("deu ruim!!")
                return
            }
            
            self?.routes = response?.routes
            self?.didShowRoutes?(self?.routes)
        }
    }
}
