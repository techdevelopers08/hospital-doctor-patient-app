//
//  MeData.swift
//  medicine-ios
//
//  Created by MAC on 06/07/21.
//


import Foundation
class MeData {
var serverData : [String: Any] = [:]
var body : [Body]?
var message : String?
var sucess : Int?
init(dict: [String: Any]){
 self.serverData = dict
 
if let body = dict["body"] as? [[String : Any]] {
self.body = []
for object in body {
let some =  Body(dict: object)
self.body?.append(some)

}
}
if let message = dict["message"] as? String {
 self.message = message
 }
if let sucess = dict["sucess"] as? Int {
 self.sucess = sucess
 }
}
class Body {
var serverData : [String: Any] = [:]
var password : String?
var latitude : String?
var email_verified_at : Any?
var remember_token : Any?
var profile_image : Any?
var first_name : String?
var longitude : String?
var user_id : Int?
var mobile : Int?
var id : Int?
var created_at : String?
var description : Any?
var role : String?
var email : String?
var deleted_at : Any?
var updated_at : Any?
var status : String?
var last_name : String?
var name : String?
init(dict: [String: Any]){
 self.serverData = dict
 
if let password = dict["password"] as? String {
 self.password = password
 }

if let first_name = dict["first_name"] as? String {
 self.first_name = first_name
 }
if let longitude = dict["longitude"] as? String {
 self.longitude = longitude
 }
if let user_id = dict["user_id"] as? Int {
 self.user_id = user_id
 }
if let mobile = dict["mobile"] as? Int {
 self.mobile = mobile
 }
if let id = dict["id"] as? Int {
 self.id = id
 }
if let created_at = dict["created_at"] as? String {
 self.created_at = created_at
 }
if let role = dict["role"] as? String {
 self.role = role
 }
if let email = dict["email"] as? String {
 self.email = email
 }

if let status = dict["status"] as? String {
 self.status = status
 }
if let last_name = dict["last_name"] as? String {
 self.last_name = last_name
 }
if let name = dict["name"] as? String {
 self.name = name
 }
}
}
}
