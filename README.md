# Swift Practice Projects
### A collection of projects I have made while learning Swift!

The following section will serve as a quick way to navigate around this repository and information about the projects. Some projects were made using **UIKit** and some were made using **SwiftUI**.

# Table of Contents

| Name | Description | Framework |
|---|---| ---|
| [TapCounter01](#1-tap-counter-version-1) | Tap to increment number. | UIKit |
| [StormViewer](#2-storm-viewer) | Clicking on a table cell to view images. | UIKit |
| [GuessTheFlag](#3-guess-the-flag) | Game to choose the correct flag out of 3. | UIKit |
| [ShareMedia](#4-share-media) | Sharing action on navigation bar. | UIKit |
| [EasyBrowser](#5-easy-browser) | Simple browser with WebKit. | UIKit |
| [WordScramble](#6-word-scramble) | Game to create anagrams from a given word. | UIKit |
| [GroceryList](#7-grocery-list) | App to create a list of groceries. | UIKit |
| [WeSplit](#8-wesplit) | Calculate and split bill amount with tip. | SwiftUI |
| [GuessTheFlag](#9-guess-the-flag) | Game to choose the correct flag out of 3. | SwiftUI |
| [RockPaperScissors](#10-rock-paper-scissors) | Rock, paper, scissors with a twist. | SwiftUI |
| [WordScramble](#11-word-scramble) | Game to create anagrams from a given word. | SwiftUI |
| [BetterRest](#12-betterrest) | Get a recommended bedtime! | SwiftUI |

## 1. Tap Counter (Version 1)
The first project I built while learning the fundamentals of Swift. The counter label will increment as the user clicks the Tap button. The counter will be reset back to 0 if the Reset button is clicked. 

<img width="300" alt="image" src="https://user-images.githubusercontent.com/23216104/206592564-c49af76a-e025-4cb2-abc5-e7f6e53f4646.png">

Things I learned: 
- Building an Interface with Labels and Buttons
- Linking functions to buttons
- Building custom Navigation Bar

## 2. Storm Viewer
This is a simple image viewer app. Users can scroll through a list of images and select one to view.
<p float="left">
<img width="420" alt="image" src="https://user-images.githubusercontent.com/23216104/206963709-ba6a4ba1-0854-468b-af02-3f6f9a80a280.png">
<img width="450" alt="image" src="https://user-images.githubusercontent.com/23216104/206963618-f818e23c-d959-493f-9992-dc6496494333.png">
</p>

Things I learned: 
- Creating Table Views and Image Views
- App Bundles and using FileManager
- View Controllers
- Introduction to AutoLayout
- Usage of Outlet for UIImage

## 3. Guess The Flag
This is a game that shows three random flags to users and asks them to choose which one belongs to a particular country. The game ends after 10 questions and the user will be presented their final score.
<p float="left">
<img width="323" alt="image" src="https://user-images.githubusercontent.com/23216104/206964307-f1ae8269-999b-4a58-bfc1-8713b8b193e4.png">'
<img width="335" alt="image" src="https://user-images.githubusercontent.com/23216104/206964439-d174d41e-5e0d-4ff9-a80a-413252b11b93.png">
<img width="340" alt="image" src="https://user-images.githubusercontent.com/23216104/206964376-6c0fb3c3-28c8-4aa2-8384-e257db6c8b2e.png">
</p>

Things I learned: 
- @2x and @3x images to account for different screen resolutions
- Asset catalogs
- Usage of UIButton and actions
- Introduction to CALayer and UIColor
- Using tags to identify views uniquely 

## 4. Share Media
This project modifies the Storm Viewer project to let users save an image or share it.

<p float="left">
<img width="450" alt="image" src="https://user-images.githubusercontent.com/23216104/206965136-8c5f1be3-768e-46cc-a5ab-09f82546801d.png">
</p>

Things I learned: 
- UIBarButtonItem
- We can share images, text, and more using UIActivityViewController
- The user needs to grant permission in order to save a photo to their photo library. This requires editing Info.plist (a fle containing settngs that won't change). More specifically, add the following row: Privacy - Photo Library Additions Usage Description.

## 5. Easy Browser
This project built on my new knowledge of UIBarButtonItem and UIAlertController by producing a simple web browser app.
<p float="left">
<img width="402" alt="image" src="https://user-images.githubusercontent.com/23216104/206966115-5d7ba335-3fb6-4a07-b3a0-9c2797a32897.png">
<img width="397" alt="image" src="https://user-images.githubusercontent.com/23216104/206965902-b084e863-ba87-435e-93b3-bef645f0e099.png">
</p>

Things I learned: 
- Using URL and URLRequest
- Using UIToolbar and components like UIProgressView
- Key-Value Observing (KVO) allows us to monitor the changing of some value in our code
- Delegates

## 6. Word Scramble
This is a fun word game where you try to find all the anagrams of the selected word! Users can enter an answer by clicking the '+' icon or click 'New word' to start a new round. When a user enters an answer, it will be validated by checking if it is a real word, only uses the letters in the presented word once, and hasn't been submitted already. Valid answers are automatically ordered alphebetically and by length (ascending order) for easier readability. If any one of these validations fail, a specific error message will be presented to the user.
<p float="left">
<img width="280" alt="image" src="https://user-images.githubusercontent.com/23216104/206967814-56c6e25b-57fb-405e-89a3-6031694792bd.png"><img width="368" alt="image" src="https://user-images.githubusercontent.com/23216104/206966903-0085c594-1e6e-4853-b5fb-981b9cafd810.png">
<img width="341" alt="image" src="https://user-images.githubusercontent.com/23216104/206967022-27091fd9-4941-4001-a6f5-8620f6ef7a50.png">
</p>

Things I learned: 
- Reloading data and inserting rows using UITableView
- Using UIAlertController to accept user input
- Capture lists in Swift (weak, strong, unowned references)
- Validating text input with UITextChecker and NSRange

## 7. Grocery List
This app lets people create a grocery list by adding items to a table view!

Once again, this app has a UIAlertController with a text field to let users enter an item they would like to add to their list. The item will be validated to make sure it is not empty and that the user has not already added it. I have added a left bar button item that clears the list completely (and asks the user for confirmation before doing so). I have also implemented swipe to delete if the user only wants to delete one item at a time. I have added two right bar button items: an add button and an info button. By clicking the info button the user is presented with all the functions the app provides. 
<p float="left">
<img width="250" alt="image" src="https://user-images.githubusercontent.com/23216104/208269923-de955140-994d-43c2-ac5c-590e56f00d15.png">
<img width="245" alt="image" src="https://user-images.githubusercontent.com/23216104/208269958-d912bc49-9e04-44fb-b114-94a415053e0f.png">
<img width="250" alt="image" src="https://user-images.githubusercontent.com/23216104/208269941-42ddbe89-02cb-4b51-a564-289c945e9a80.png">
</p>

## 8. WeSplit
Wesplit is a bill sharing app that helps to sum up the total amount (including tip) and split based on the number of people. It is a simple app to learn the basics of SwiftUI. 

Things I learned: 
- Basic structure of SwiftUI apps
- How to build forms and sections
- How to create navigation views
- How to store program state with @State property wrappers
- How to create user interface controls such as TextField and Picker

<p float="left">
<img width="295" alt="WeSplit" src="https://user-images.githubusercontent.com/23216104/208283768-22955043-fdbd-4173-ab73-535fe941bde3.png">
</p>

## 9. Guess The Flag
This is the same game as the first GuessTheFlag project I made but thiis time I created it using SwiftUI! The game shows three random flags to users and asks them to choose which one belongs to a particular country. The game ends after 10 questions and the user will be presented their final score.

<p float="left">
<img width="255" alt="main_screen" src="https://user-images.githubusercontent.com/23216104/208350497-f3c5c8a4-7d24-4ebe-b9ce-5d573857dc31.png">
<img width="255" alt="Screen Shot 2022-12-18 at 1 07 41 PM" src="https://user-images.githubusercontent.com/23216104/208350526-f9edc59f-93ef-48fd-907f-8e8047e8aa49.png">
<img width="251" alt="Screen Shot 2022-12-18 at 1 09 04 PM" src="https://user-images.githubusercontent.com/23216104/208350553-1f5aab76-60ef-4df6-b616-179b6f20a179.png">
</p>

Things I learned: 
- VStack, HStack, ZStack
- How to show an alert

## 10. Rock Paper Scissors
I made this game to test my SwiftUI knowledge thus far. It's the classic rock paper, scissors with a twist. In this game, you will be prompted with the computer's choice beforehand and be told to either win or lose. It is your job to choose the correct option to satisfy that condition :)

<p float="left">
<img width="250" alt="Screen Shot 2022-12-18 at 5 08 58 PM" src="https://user-images.githubusercontent.com/23216104/208351075-60d1bf76-8bce-4374-a2cd-0bf6df6c132c.png">
<img width="248" alt="Screen Shot 2022-12-18 at 5 09 12 PM" src="https://user-images.githubusercontent.com/23216104/208351104-6ac62bb6-28ee-454e-b973-f25a5b399c23.png">
</p>

## 11. Word Scramble
This is the same WordScramble game I created with UIKit except this time I made it using SwiftUI!

<p float="left">
<img width="231" alt="Screen Shot 2022-12-18 at 7 42 17 PM" src="https://user-images.githubusercontent.com/23216104/208351588-c5aa953e-8366-42e9-ab96-11418778a886.png">
<img width="227" alt="Screen Shot 2022-12-18 at 7 42 41 PM" src="https://user-images.githubusercontent.com/23216104/208351611-c6fd3a59-38c0-4d90-a040-7f9d7d0fa413.png">
<img width="224" alt="Screen Shot 2022-12-18 at 7 44 22 PM" src="https://user-images.githubusercontent.com/23216104/208351634-500ba6be-82ec-4d84-8523-94c2147e903d.png">
</p>

Things I learned: 
- How to use a List
- onAppear and onSubmit methods 

## 12. BetterRest 
**Note**: This app is complete but I would like to make some improvements to it! I will do so in the coming days. <br>
This is an app that gives you a recommended bedtime based on your coffee intake and how many hours you would like to sleep. 

<p float="left">
<img width="271" alt="image" src="https://user-images.githubusercontent.com/23216104/209047937-a9fc8a79-415b-48c4-b159-4c14143ff188.png">
</p>
