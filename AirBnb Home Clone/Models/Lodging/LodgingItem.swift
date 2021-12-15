/// Copyright (c) 2021 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Firebase
import FirebaseDatabase

struct MapItem {
  let streetKey: String
  let latitude: Double
  let longitude: Double
  
  init(streetKey: String, latitude: Double, longitude: Double) {
    self.streetKey = streetKey
    self.latitude = latitude
    self.longitude = longitude
  }
  
  init?(snapshot: DataSnapshot) {
    guard
      let value = snapshot.value as? [String: AnyObject],
      let streetKey = value["streetKey"] as? String,
      let latitude = value["latitude"] as? Double,
      let longitude = value["longitude"] as? Double
    else {
      return nil
    }
    
    self.streetKey = streetKey
    self.latitude = latitude
    self.longitude = longitude

  }
  
  func toAnyObject() -> Any {
    return [
      "streetKey": streetKey,
      "latitude": latitude,
      "longitude": longitude,
    ]
  }
}

struct LodgingItem {
  let ref: DatabaseReference?
  let key: String
  let name: String
  let description: String
  let addedByUser: String
  var isVisited: Bool
  var isFavorite: Bool
  let streetKey: String
  let latitude: Double
  let longitude: Double
  
//  let mapItem: MapItem
//  var isFavorite: Bool

  // MARK: Initialize with Raw Data
  init(name: String, description: String, addedByUser: String, isVisited: Bool, isFavorite: Bool = false, key: String = "", streetKey: String, latitude: Double, longitude: Double) {
    self.ref = nil
    self.key = key
    self.name = name
    self.description = description
    self.addedByUser = addedByUser
    self.isVisited = isVisited
    self.isFavorite = isFavorite
//    self.mapItem = mapItem
    self.streetKey = streetKey
    self.latitude = latitude
    self.longitude = longitude
  }

  // MARK: Initialize with Firebase DataSnapshot
  init?(snapshot: DataSnapshot) {
    
    
    
    guard
      let value = snapshot.value as? [String: AnyObject],
      let name = value["name"] as? String,
      let description = value["description"] as? String,
      let addedByUser = value["addedByUser"] as? String,
      let isVisited = value["isVisited"] as? Bool,
      let isFavorite = value["isFavorite"] as? Bool,
      let streetKey = value["streetKey"] as? String,
      let latitude = value["latitude"] as? Double,
      let longitude = value["longitude"] as? Double
//      let mapItemValue = value["mapItem"] as? [String: AnyObject],
//      let streetKey = mapItemValue["streetKey"] as? String,
//      let latitude = mapItemValue["latitude"] as? Double,
//      let longitude = mapItemValue["longitude"] as? Double
    else {
      return nil
    }

    self.ref = snapshot.ref
    self.key = snapshot.key
    self.name = name
    self.description = description
    self.addedByUser = addedByUser
    self.isVisited = isVisited
    self.isFavorite = isFavorite
    self.streetKey = streetKey
    self.latitude = latitude
    self.longitude = longitude
//    self.mapItem = MapItem(streetKey: streetKey, latitude: latitude, longitude: longitude)
  }

  // MARK: Convert LodgingItem to AnyObject
  func toAnyObject() -> Any {
    return [
      "name": name,
      "description": description,
      "addedByUser": addedByUser,
      "isVisited": isVisited,
      "isFavorite": isFavorite,
//      "mapItem": mapItem.toAnyObject()
      "streetKey": streetKey,
      "latitude": latitude,
      "longitude": longitude,
    ]
  }
}
