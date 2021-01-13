//
//  ViewController.swift
//  mapkitExample
//
//  Created by esTechVMG on 13/1/21.
//

import UIKit
import MapKit
class ViewController: UIViewController {
    //Initial location
    let initialLocation = CLLocation(latitude: 38.094325276664186, longitude: -3.6312967182586977)
    let regionRadius:CLLocationDistance = 1000
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        centerMapOnLocation(location: initialLocation)
        self.showArtwork(coordinate: initialLocation.coordinate)
        
        mapView.delegate = self
        
    }

    func centerMapOnLocation(location:CLLocation) -> Void {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func showArtwork(coordinate:CLLocationCoordinate2D) {
        let artwork = Artwork(title: "EscuelaEstech", locationName: "Escuela de tecnologias aplicadas", discipline: "Centro de Estudios", coordinate: coordinate)
        mapView.addAnnotation(artwork)
    }
}

extension ViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else {return nil}
        let identifier = "marker"
        var view:MKMarkerAnnotationView
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequeueView.annotation = annotation
            view = dequeueView
        }else{
            //Crear un nuevo objeto MKMarkerAnnotationView
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    func mapView (_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control:UIControl){
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
