import 'dart:async';

import 'package:app/models/geometry.dart';
import 'package:app/services/marker_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/services/geolocator_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app/services/places_service.dart';
import 'package:app/models/place_search.dart';
import 'package:app/models/place.dart';
import 'package:app/models/location.dart';
import 'package:app/services/marker_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ApplicationBloc with ChangeNotifier{
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();
  //Variables
  Position currentLocation;
  List<PlaceSearch> searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();
  StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  Place selectedLocationStatic;
  String placeType;
  List<Marker> markers = List<Marker>();

  ApplicationBloc(){
    setCurrentLocation();
  }

  setCurrentLocation() async{
    currentLocation = await geoLocatorService.getCurrentLocation();
    selectedLocationStatic = Place(name: null, geometry: Geometry(location: Location(lat: currentLocation.latitude, lng: currentLocation.longitude)));
    notifyListeners();
  }

  searchPlaces(String searchTerm) async{
    await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async{
    var sLocation = await placesService.getPlace(placeId);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    notifyListeners();
  }

  togglePlaceType(String value, bool selected) async {
    if(selected) {
      placeType = value;
    }else{
      placeType = null;
    }

    if(placeType != null){
      var places = await placesService.getPlaces(selectedLocationStatic.geometry.location.lat,
          selectedLocationStatic.geometry.location.lng, placeType);
      markers = [];

      if(places.length > 0){
        var newMarker = markerService.creteMarkerFromPlace(places[0]);
        markers.add(newMarker);
      }

      var locationMarker = markerService.creteMarkerFromPlace(selectedLocationStatic);
      markers.add(locationMarker);

      var _bounds = markerService.bounds(Set<Marker>.of(markers));
      bounds.add(_bounds);
    }
    notifyListeners();
  }
  @override
  void dispose(){
    selectedLocation.close();
    super.dispose();
  }
}