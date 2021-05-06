import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'package:app/blocs/application_bloc.dart';
import 'package:provider/provider.dart';
import 'package:app/models/geometry.dart';
import 'package:app/models/place.dart';
import 'package:app/models/location.dart';

class selectplace extends StatefulWidget {
  @override
  _selectplaceState createState() => _selectplaceState();
}

class _selectplaceState extends State<selectplace> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;
  StreamSubscription boundsSubscription;
  @override
  void initState(){
    final applicationBloc = Provider.of<ApplicationBloc>(context, listen:  false);
    applicationBloc.selectedLocation.stream.listen((place){
      if(place != null){
        _goTopPlace(place);
      }
    });
    boundsSubscription = applicationBloc.bounds.stream.listen((bounds) async{
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
    });
    super.initState();
  }

  @override
  void dispose(){
    final applicationBloc = Provider.of<ApplicationBloc>(context, listen:  false);
    applicationBloc.dispose();
    boundsSubscription.cancel();
    locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return MaterialApp(
      home: Scaffold(
        body: (applicationBloc.currentLocation == null)
          ? Center(
          child: CircularProgressIndicator(),
        )
        : ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child : TextField(
                decoration: InputDecoration(hintText: '장소 검색', suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) => applicationBloc.searchPlaces(value),
              ),
            ),
            Stack(
              children: [
                Container(
                    height: 300.0,
                    child:GoogleMap(
                      mapType: MapType.normal,
                      markers: Set<Marker>.of(applicationBloc.markers),
                      myLocationEnabled: true,
                      initialCameraPosition:
                      CameraPosition(target: LatLng(applicationBloc.currentLocation.latitude, applicationBloc.currentLocation.longitude),
                          zoom: 14),
                      onMapCreated: (GoogleMapController controller){
                        _mapController.complete(controller);
                      },
                    )
                ),
                if(applicationBloc.searchResults != null && applicationBloc.searchResults.length != 0)
                  Container(
                    height:300.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:Colors.black.withOpacity(.6),
                      backgroundBlendMode: BlendMode.darken
                  ),
                ),
                Container(
                  height: 300.0,
                  child: ListView.builder(
                    itemCount: applicationBloc.searchResults.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title:Text(applicationBloc.searchResults[index].description, style: TextStyle(color: Colors.white )
                        ),
                        onTap: (){
                          applicationBloc.setSelectedLocation(
                            applicationBloc.searchResults[index].placeId
                          );
                        }
                       );
                    },)
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('주변 장소 찾기', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                children: [
                  FilterChip(label: Text('카페'),
                    onSelected: (val) => applicationBloc.togglePlaceType('cafe', val),
                    selected: applicationBloc.placeType == 'cafe',
                    selectedColor: Colors.blue),
                  FilterChip(label: Text('도서관'),
                    onSelected: (val) => applicationBloc.togglePlaceType('library', val),
                    selected: applicationBloc.placeType == 'library',
                    selectedColor: Colors.blue,),
                  FilterChip(label: Text('식당'),
                    onSelected: (val) => applicationBloc.togglePlaceType('restaurant', val),
                    selected: applicationBloc.placeType == 'restaurant',
                    selectedColor: Colors.blue,),
                  FilterChip(label: Text('지하철 역'),
                    onSelected: (val) => applicationBloc.togglePlaceType('subway_station', val),
                    selected: applicationBloc.placeType == 'subway_station',
                    selectedColor: Colors.blue,),
                  FilterChip(label: Text('버스 정류장'),
                    onSelected: (val) => applicationBloc.togglePlaceType('bus_station', val),
                    selected: applicationBloc.placeType == 'bus_station',
                    selectedColor: Colors.blue,),
                  FilterChip(label: Text('공원'),
                    onSelected: (val) => applicationBloc.togglePlaceType('park', val),
                    selected: applicationBloc.placeType == 'park',
                    selectedColor: Colors.blue,),
                  FilterChip(label: Text('체육관'),
                    onSelected: (val) => applicationBloc.togglePlaceType('gym', val),
                    selected: applicationBloc.placeType == 'gym',
                    selectedColor: Colors.blue,),
                ],
            )
            )
          ]
        ),
      ),
    );
  }

  Future<void> _goTopPlace(Place place) async {
    final GoogleMapController contorlloer = await _mapController.future;
    contorlloer.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(place.geometry.location.lat, place.geometry.location.lng), zoom: 14.0
        )
      )

    );
  }
}