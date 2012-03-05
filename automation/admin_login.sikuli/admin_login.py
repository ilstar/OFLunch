browserName = "Google Chrome Canary"
homeurl = "http://tuantuanfan.herokuapp.com/"
adminEmail = "xingkui.wang@gree.co.jp"
adminPassword = "openfeint"
userEmail = "fred.liang@gree.co.jp"
userPassword = "openfeint"
dummyPassword = "iwjknslvdf*&*(&@#)$&^*&^@)#(&$(^(!)&$(*#^(*hjnajlrng<?><(+_)!(_~*)($#''';'_+__~@#4u8o92045890234905435"
shortWaitTime = 5
longWaitTime = 40
browserPattern = "borwserPattern.png"
browserNavigationBar = "browserNavigationBar.png"
loginPageTitle = "loginPageTitle.png"
# elements in login page
singinButton = "signinButton.png"
emailLabel = "Email.png"
passwordLabel = "passwordLabel.png"
textField = "1330680917864.png"
emailField = None
passwordField = None
rememberMeCheckbox = "rememberMeCheckbox.png"
wrongEmailOrPassword = "wrongEmailOrPassword.png"
# elements in home page
adminFlag = "iiEl.png"
todayMenu = "1330682431729.png"
createTodayMenu = "ti4.png"
createMenuFlag = "FJiEE.png"
venderCheckbox = "1330916453814.png"
nanajia = "IIE.png"
macdonald = "a.png"
kfc = "1330683076962.png"
todayVendorNames = [nanajia, macdonald]
nanajiaOrder = "52.png"
macdonaldOrder = "iiixlrO0.png"
kfcOrder = "1330918292673.png"
todayVendorOrders = [nanajiaOrder, macdonaldOrder]
confirmMom = "1330683086355.png"
cancelMom = "1330919594115.png"
atMostTwoVendors = "iREi4WliE.png"
hasMomToday = None
accountMenu = "1330681373261.png"
logoutItem = "EEE.png"
userFlag = "1330681602981.png"
orderLink = "2i.png"
itemOne = "1330919492354.png"
itemTwo = "1iE.png"
pleaseSelectItem = "ilE.png"
defaulAmountInputField = "1330926418053.png"
orderSummary = "QQQQEEZHBHGT.png"
orderTotalPrice = "Mk6100.png"
orderSuccess = "FIE117J.png"


# open browser
def openBrowser():
  browser = App(browserName)
  browser.open()
  wait(browserPattern, longWaitTime)

# close browser
def closeBrowser():
  browser = App(browserName)
  browser.focus()
  browser.close()

# navigate to site
def openHomePage():
  type(browserNavigationBar, homeurl + Key.ENTER)
  wait(loginPageTitle, longWaitTime)

# initial step of login
def loginInit():
  wait(shortWaitTime)
  openBrowser()
  openHomePage() 
  # make email field lose focus to make sure we can find email and password field
  click(loginPageTitle)
  global emailField, passwordField
  if emailField is None:
    emailField = find(emailLabel).below(50).right(300).find(textField)
  if passwordField is None:
    passwordField = find(passwordLabel).below(50).right(300).find(textField)

# login withought email and password
def loginWithoughtEmailAndPassword():
  loginInit()
  click(singinButton)
  wait(wrongEmailOrPassword, longWaitTime)
  closeBrowser()



# login with email and empty password
def loginWithEmailAndEmptyPassword():
  loginInit()
  type(emailField, adminEmail)
  click(singinButton)
  wait(wrongEmailOrPassword, longWaitTime)
  closeBrowser()


# login with wrong email and password
def loginWithWrongEmailAndPassword():
  loginInit()
  type(emailField, adminEmail)
  type(passwordField, dummyPassword)
  click(singinButton)
  wait(wrongEmailOrPassword, longWaitTime)
  closeBrowser()

# Admin login with right email and password and see MOD menu
def adminLoginWithRightEmailAndPassword():
  loginInit()
  type(emailField, adminEmail)
  type(passwordField, adminPassword)
  type(Key.ENTER)
  wait(adminFlag, longWaitTime)

#Admin logout
def adminLogout():
  click(accountMenu)
  wait(logoutItem, longWaitTime)
  click(logoutItem)
  wait(loginPageTitle, longWaitTime)
  closeBrowser()

# Admin login withought check remember me
def adminLoginWithoughtCheckRememberMe():
  adminLoginWithRightEmailAndPassword()
  closeBrowser()
  loginInit()
  wait(loginPageTitle, longWaitTime)
  closeBrowser()

# Admin login and check remember me
def adminLoginAndCheckRememberMe():
  loginInit()
  type(emailField, adminEmail)
  type(passwordField, adminPassword)
  click(rememberMeCheckbox)
  click(singinButton)
  wait(adminFlag, longWaitTime)
  closeBrowser()
  loginInit()
  wait(adminFlag, longWaitTime)
  adminLogout()

# User login and can't see MOD menu
def userLoginWithRightEmailAndPassword():
  loginInit()
  type(emailField, userEmail)
  type(passwordField, userPassword)
  type(Key.ENTER)
  wait(userFlag, longWaitTime)
    
# User logout
def userLogout():
  click(accountMenu)
  wait(logoutItem, longWaitTime)
  click(logoutItem)
  wait(loginPageTitle, longWaitTime)
  closeBrowser()  

def goToCreateMomPage():
  # admin see create link
  wait(createTodayMenu, longWaitTime)
  click(createTodayMenu)
  # go to create page
  wait(createMenuFlag, longWaitTime)
  
def selectVender(num):
  current = 0
  vCheckboxes = findAll(venderCheckbox)
  for vCheckbox in vCheckboxes:
    if (current < num):
      click(vCheckbox)
      current = current + 1
def selectSpecifiedVender(vender1, vender2):
  vCheckbox1 = find(vender1).left(10)
  click(vCheckbox1)
  vCheckbox2 = find(vender2).left(10)
  click(vCheckbox2)

#def addTodayVendors():
#  if exists(nanajia):
#    print "nanajia exists"
#    todayVendors.append(nanajiaOrder)
#  if exists(macdonald):
#    print "macdonald exists"
#    todayVendors.append(macdonaldOrder)
#  if exists(kfc):
#    print "kfc exists"
#   todayVendors.append(kfcOrder)
def checkTodayVendors():
  sum = 0
  if exists(nanajia):
    print "nanajia exists"
    sum = sum + 1
  if exists(macdonald):
    print "macdonald exists"
    sum = sum + 1
  if exists(kfc):
    print "kfc exists"
    sum = sum +1
  if sum != 2:
    exit()
  

# Admin create new MOM of today
def adminCreateNewMOM():
  # admin login
  adminLoginWithRightEmailAndPassword()
  # admin click MOM
  wait(todayMenu, longWaitTime)
  click(todayMenu)
  # go to Create MOM Page
  goToCreateMomPage()
  # select three vendor
  selectVender(3)
  click(confirmMom)
  # got error
  wait(atMostTwoVendors, longWaitTime)
  # click cancel
  click(cancelMom)
  # still see creat link and go to that page again
  goToCreateMomPage()
  # select two vendor
  selectSpecifiedVender(todayVendorNames[0], todayVendorNames[1])  
  # click ok
  click(confirmMom)
  # can see order info in this page
  wait(shortWaitTime)
  checkTodayVendors()
  #print todayVendors
  # admin logout
  adminLogout()  

# check order link
def checkOrderLink():
  wait(orderLink, longWaitTime)  
# go to order page
def goToOrderPage():
  click(orderLink)  
# check vendors
def checkVendors():
  wait(todayVendorOrders[0], longWaitTime)
  wheel(todayVendorOrders[0], WHEEL_DOWN, 60)
  wait(todayVendorOrders[1], longWaitTime) 
# check menu items:
def checkMenuItems():
  wait(itemOne, longWaitTime)
  wait(itemTwo, longWaitTime)
# check confirm and cancel buttons
def checkConfirmAndCancelButtons():
  wheel(todayVendorOrders[1], WHEEL_DOWN, 60)
  wait(confirmMom, longWaitTime)
  wait(cancelMom, longWaitTime)  
  
# Admin browse MOM
def adminBrowseMOM():
  # admin login
  adminLoginWithRightEmailAndPassword()
  # admin can see order link
  checkOrderLink()  
  # admin go to order page
  goToOrderPage()
  # admin can see two vendors
  checkVendors()
  # admin can see menu item name and price
  checkMenuItems()
  # admin can see confirm and cancel buttons
  checkConfirmAndCancelButtons()
  # admin logout
  adminLogout()
  
# set amount of item
def setAmount(itemPattern, amount):
  #find(itemPattern).nearby(10).right(120).highlight(5)
  inputField = find(itemPattern).nearby(10).right(120).find(defaulAmountInputField)
  doubleClick(inputField)
  type(Key.DELETE)
  type(inputField, amount)

# User browse MOM
def userSubmitWrongOrder():
  # user login
  userLoginWithRightEmailAndPassword()
  # user can see order link
  checkOrderLink()  
  # user go to order page
  goToOrderPage()
  # user can see two vendors
  checkVendors()
  # user can see menu item name and price
  checkMenuItems()
  # user see confirm and cancel buttons
  checkConfirmAndCancelButtons()
  # click confirm button
  click(confirmMom)
  # see notification
  wait(pleaseSelectItem, longWaitTime)
  
  # check venders again
  checkVendors()
  # set wrong amount
  setAmount(itemOne, "-100")
  # check buttons
  checkConfirmAndCancelButtons()
  # click confirm
  click(confirmMom)
  # check error message
  wait(pleaseSelectItem, longWaitTime)

  # user can see two vendors
  checkVendors()
  # user can see menu item name and price
  checkMenuItems()
  # check buttons
  checkConfirmAndCancelButtons()  
  # user cancel confirm order
  click(cancelMom)
  
  # user can see order link
  checkOrderLink()
  # user logout
  userLogout()

# User order
def userOrder():
  # user login
  userLoginWithRightEmailAndPassword()
  # user can see order link
  checkOrderLink()  
  # user go to order page
  goToOrderPage()
  # user can see two vendors
  checkVendors()
  # user can see menu item name and price
  checkMenuItems()
  # set amount
  setAmount(itemOne, "1")
  setAmount(itemTwo, "2")  
  # user see confirm and cancel buttons
  checkConfirmAndCancelButtons()
  # click confirm button
  click(confirmMom)
  # see summary
  wait(orderSummary, longWaitTime)
  wait(orderTotalPrice, longWaitTime)
  # click cancel button
  click(cancelMom) 
  # user can see order link
  checkOrderLink()  
  # user go to order page
  goToOrderPage()
  # user can see two vendors
  checkVendors()
  # user can see menu item name and price
  checkMenuItems()
  # set amount
  setAmount(itemOne, "1")
  setAmount(itemTwo, "2")  
  # user see confirm and cancel buttons
  checkConfirmAndCancelButtons()
  # click confirm button
  click(confirmMom)
  # see summary
  wait(orderSummary, longWaitTime)
  wait(orderTotalPrice, longWaitTime)
  # click confirm button
  click(confirmButton)
  # see notification
  wait(orderSuccess)
  # see order summary
  wait(orderSummary, longWaitTime)
  wait(orderTotalPrice, longWaitTime)
  # user can't see order link
  click(userFlag)
  if exists(orderLink):
    exit()
  # user logout
  userLogout()  

# user dashboard page
def userDashboardPage():
  # user login
  userLoginWithRightEmailAndPassword()
  # see order summary
  wait(orderSummary, longWaitTime)
  wait(orderTotalPrice, longWaitTime)
  # user can't see order link
  if exists(orderLink):
    exit()
  # user logout
    userLogout()

# test steps
#loginWithoughtEmailAndPassword()
#loginWithEmailAndEmptyPassword()
#loginWithWrongEmailAndPassword()
#adminLoginWithRightEmailAndPassword()
#adminLogout()
#adminLoginWithoughtCheckRememberMe()
#adminLoginAndCheckRememberMe()
#userLoginWithRightEmailAndPassword()
#userLogout()
#adminCreateNewMOM()
#adminBrowseMOM()
userSubmitWrongOrder()
userOrder()
userDashboardPage()