# Swift Practice Projects
### A collection of projects I have made while learning Swift!

The following section will serve as a quick way to navigate around this repository and information about the projects.

# Table of Contents

| Name | Description |
|---|---|
| [TapCounter01](#1-tap-counter-version-1) | Tap to increment number. |
| [StormViewer](#2-storm-viewer) | Clicking on a table cell to view images. |
| [GuessTheFlag](#3-guess-the-flag) | Game to choose the correct flag out of 3. |
| [ShareMedia](#4-share-media) | Sharing action on navigation bar. |
| [EasyBrowser](#5-easy-browser) | Simple browser with WebKit. |
| [WordScramble](#6-word-scramble) | Game to create anagrams from a given word. |

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
<img width="410" alt="image" src="https://user-images.githubusercontent.com/23216104/206963709-ba6a4ba1-0854-468b-af02-3f6f9a80a280.png">
<img width="430" alt="image" src="https://user-images.githubusercontent.com/23216104/206963618-f818e23c-d959-493f-9992-dc6496494333.png">
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
<img width="482" alt="image" src="https://user-images.githubusercontent.com/23216104/206966115-5d7ba335-3fb6-4a07-b3a0-9c2797a32897.png">
<img width="477" alt="image" src="https://user-images.githubusercontent.com/23216104/206965902-b084e863-ba87-435e-93b3-bef645f0e099.png">
</p>

## 6. Word Scramble
This is a fun word game where you try to find all the anagrams of the selected word!
<p float="left">
<img width="280" alt="image" src="https://user-images.githubusercontent.com/23216104/206967814-56c6e25b-57fb-405e-89a3-6031694792bd.png"><img width="368" alt="image" src="https://user-images.githubusercontent.com/23216104/206966903-0085c594-1e6e-4853-b5fb-981b9cafd810.png">
<img width="341" alt="image" src="https://user-images.githubusercontent.com/23216104/206967022-27091fd9-4941-4001-a6f5-8620f6ef7a50.png">
</p>

