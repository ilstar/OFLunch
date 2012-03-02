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
emailLabel = "emailLabel.png"
passwordLabel = "passwordLabel.png"
textField = "1330680917864.png"
emailField = None
passwordField = None
rememberMeCheckbox = "rememberMeCheckbox.png"
wrongEmailOrPassword = "wrongEmailOrPassword.png"
# elements in home page
adminFlag = "iiEl.png"
accountMenu = "1330681373261.png"
logoutItem = "EEE.png"
userFlag = "1330681602981.png"


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

# Admin create new MOM of today
  # admin login
  # admin click MOM
  # admin see create link
  # go to create page
  # select three vendor
  # got error
  # click MOM
  # still see creat link
  # go to create page
  # select two vendor
  # click cancel
  # still see creat link
  # go to create page
  # select two vendor
  # click ok
  # back to MOM page and can't see creat link
  # can see order info in this page
  # admin logout
  # admin login again
  # admin can see order info in MOM page
  # admin logouot

# Admin browse MOM
  # admin login
  # admin can see order link
  # admin go to order page
  # admin can see two vendor
  # admin can see menu item name and price
  # admin logout

# User browse MOM
  # user login
  # user can see order link
  # user go to order page
  # user can see two verndor
  # user can see menu item name and price
  # user logout


  

# test steps
loginWithoughtEmailAndPassword()
loginWithEmailAndEmptyPassword()
loginWithWrongEmailAndPassword()
adminLoginWithRightEmailAndPassword()
adminLogout()
adminLoginWithoughtCheckRememberMe()
adminLoginAndCheckRememberMe()
userLoginWithRightEmailAndPassword()
userLogout()
