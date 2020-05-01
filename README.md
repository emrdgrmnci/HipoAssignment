<img src="/ScreenImages/hipologo.png" width="220" style="max-width:100%;" align= "left"/><br><br><br><br><br><br>
# Hipo Assignment [![Swift](https://img.shields.io/badge/Swift-5.1+-orange.svg)]() [![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)]()
  
### ABOUT
Are you Hipo? <b>Hipo Assignment</b> is a sorting, listing and showing hipo members with their github information.

### What I did?
<ul>

- First of all, this project has 1 local json file and 2 github apis which is one for github user infos and the other one is for github reops. I used listing hipo.json datas in table view of **MembersViewController**. I added new members from **AddNewMemberViewController** to **MembersViewController**. When I was adding new members to **MembersViewController** I used **CoreData** in **AddNewMemberViewController** and I did not merge **CoreData** and **hipo.json** datas. So, I saved **hipo.json** datas to **CoreData** manually in **AddNewMemberViewController** textfields. 
</br>
**Therefore, MembersViewController screen has no data at the first launch of app!!!** 

- Secondly, with **Sort Members** button I did not sort members with assignment requirements and I did not change UI with sorted objects. I just counted characters of table view cell data with **a** character and printed in console.

- Thirdly, in **MemberDetailViewController** I used two different github apis. One for showing github follower, following and profile picture of selected user. Second for showing github repo name, updated date, star count and which programming languages used in github project.

- I coded UI elements programmatically.
- I followed UI design theme as possible as I can.
- I did not use any 3rd party library.
- I wirote test case for api url. 

### FEATURES
<ul>
<li>Add New Member</li>
<li>Count table view elements characters with Sort Button</li>
<li>Used <a href = "https://developer.apple.com/documentation/coredata">Core Data</a> for local data saving.
<li>Used <a href = "https://developer.apple.com/documentation/foundation/urlsession">URLSession</a> for network call.
<li>Used <a href = "https://developer.apple.com/documentation/foundation/userdefaults">UserDefaults</a> in add new member text fields .
<li>Used <a href = "https://developer.apple.com/documentation/xctest">UnitTest</a> for api url.
<li>Deployment target: iOS 13.0+</li>
<li>Supported devices: iPhone 5s, SE, 6, 6 Plus, 6s, 6s Plus, 7, 7 Plus, 8, 8 Plus, iPhone X, iPhone XR, iPhone Xs, iPhone Xs Max, iPhone 11, iPhone 11 Pro, iPhone 11 Pro Max </li>
</ul>

### REQUIREMENTS
<ul><li>Xcode 11.0+</li>
<li>iOS 13.0+</li>
</ul> 
</p>

### SCREENS

<img src="/ScreenImages/Screen Shot 2020-03-01 at 12.32.30.png" width="300" height= "450" align= "left"/>&nbsp;
<img src="/ScreenImages/Simulator Screen Shot - iPhone 8 - 2020-03-01 at 12.30.35.png" width="400" height= "750" align= "left"/>&nbsp;<br><br>
<img src="/ScreenImages/Simulator Screen Shot - iPhone 8 - 2020-03-01 at 12.32.36.png" width="400" height= "750" align= "left"/>&nbsp;
<img src="/ScreenImages/Simulator Screen Shot - iPhone 8 - 2020-03-01 at 12.32.54.png" width="400" height= "750" align= "left"/>&nbsp;
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
