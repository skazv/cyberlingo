//
//  IconLib.swift
//  Cyberlingo
//
//  Created by Suren Kazaryan on 31.01.25.
//


import Foundation
import UIKit

enum IconLib: String, CaseIterable {
    case creditCard = "creditcard"
    case banknote = "banknote"
    case briefcase = "briefcase"
    case bag = "bag"
    case cart = "cart"
    
    //Transport
    case car = "car"
    case boltCar = "bolt.car"
    case bus = "bus"
    case tram = "tram"
    case tramTunel = "tram.tunnel.fill"
    case airplane = "airplane"
    case ferry = "ferry"
    case cablecar = "cablecar"
    case bicycle = "bicycle"
    case scooter = "scooter"
    case fuelpump = "fuelpump"
    
    //Device
    case iphone = "iphone"
    case ipad = "ipad"
    case ipod = "ipod"
    case display = "display"
    case tv = "tv"
    case laptopcomputer = "laptopcomputer"
    case gamecontroller = "gamecontroller"
    case camera = "camera"
    case phone = "phone"
    case video = "video"
    case applewatch = "applewatch"
    
    
    case appletv = "appletv"
    case keyboard = "keyboard"
    case printer = "printer"
    case faxmachine = "faxmachine"
    
    //Shopping
    case tshirt = "tshirt"
    
    //Pet
    case pawprint = "pawprint"
    case hare = "hare"
    case tortoise = "tortoise"
    case ant = "ant"
    case ladybug = "ladybug"
    case leaf = "leaf"
    case bird = "bird"
    
    //Food
    case cupAdnSaucer = "cup.and.saucer"
    case takebag = "takeoutbag.and.cup.and.straw"
    case forkKnife = "fork.knife"

    //Else
    case house = "house"
    case buildingColumns = "building.columns"
    case building = "building"
    case buildingTwo = "building.2"
    case lock = "lock"
    case key = "key"
    case wifi = "wifi"
    case pin = "pin"
    case map = "map"
    
    case book = "book"
    case boolClosed = "book.closed"
    case magazine = "magazine"
    case newspaper = "newspaper"
    case graduationcap = "graduationcap"
    case ticket = "ticket"
    case paperclip = "paperclip"
    case person = "person"
    case person3 = "person.3"
    case personTextRectangle = "person.text.rectangle"
    case globe = "globe"
    case sunMax = "sun.max"
    case moon = "moon"
    case cloud = "cloud"
    case snowflake = "snowflake"
    case umbrella = "umbrella"
    case flame = "flame"
    case musicNote = "music.note"
    case mic = "mic"
    case heard = "heart"
    case star = "star"
    case flag = "flag"
    case location = "location"
    case bell = "bell"
    case bolt = "bolt"
    case tag = "tag"
    case eye = "eye"
    case eyebrow = "eyebrow"
    case mustache = "mustache"
    case mouth = "mouth"
    case eyeglasses = "eyeglasses"
    case brain = "brain"
    case message = "message"
    case envelope = "envelope"
    case gearshape = "gearshape"
    case scissors = "scissors"
    case paintbrush = "paintbrush"
    case paintbrushPointede = "paintbrush.pointed"
    case bandage = "bandage"
    case ruler = "ruler"
    case hammer = "hammer"
    case wrench = "wrench"
    case crewdriver = "crewdriver"
    case scroll = "scroll"
    case theatermasks = "theatermasks"
    case film = "film"
    case crown = "crown"
    case comb = "comb"
    case photo = "photo"
    case gift = "gift"
    case pills = "pills"
    case cross = "cross"
    case code = "chevron.left.forwardslash.chevron.right"
    case terminal = "terminal"
    case character = "character"
    
    case trash = "trash"
    
    //USE FOR SYSTEM
    case calendar = "calendar"
    case reportFirstDay = "1.circle"
    case cellColor = "square.grid.3x3.topleft.filled"
    case backgroundColor = "square.inset.filled"
    case chartPie = "chart.pie"
    case chartPieFill = "chart.pie.fill"
    case chartXyaxis = "chart.xyaxis.line"
    case chartBarXaxis = "chart.bar.xaxis"
    case chartBarDoc = "chart.bar.doc.horizontal"
    case chartBarDocFill = "chart.bar.doc.horizontal.fill"
    case squarGrid4x3 = "square.grid.4x3.fill"
    case note = "note"
    case rectangleOnRectangle = "rectangle.on.rectangle"

    
    //System icons
    case rub = "rublesign.square.fill"
    case lockFill = "lock.fill"
    case info = "info"
    case infoCircle = "info.circle"
    case questionmark = "questionmark"
    case arrows = "arrow.up.right.and.arrow.down.left.rectangle.fill"
    case texts = "text.word.spacing"
    case copy = "doc.on.doc"
    case copyFill = "doc.on.doc.fill"
    case plusApp = "plus.app"
    case dots = "ellipsis"
    
    //Category
    case water = "water.waves"
    case mount = "mountain.2"
    
    //to do
    case swim = "figure.pool.swim"
    case walk = "figure.walk"
    case hike = "figure.hiking"
    case plus = "plus"
    case pencilCircle = "pencil.circle"
    case pencil = "pencil"
    case speaker = "speaker"
    case reset = "arrow.triangle.capsulepath"
    case hammerFill = "hammer.fill"
    case timer = "timer"
    case graduationcapFill = "graduationcap.fill"
    case timerCircleFill = "timer.circle.fill"

    
    case rectangleCardsFill = "rectangle.portrait.on.rectangle.portrait.fill"
    case rectangleCards = "rectangle.portrait.on.rectangle.portrait"
    case circleFill = "circle.fill"
    case shuffle = "shuffle"
    case arrowup = "arrowshape.up"
    
    
    
    var image: UIImage {
        return UIImage(systemName: self.rawValue) ?? UIImage()
    }
    
}
