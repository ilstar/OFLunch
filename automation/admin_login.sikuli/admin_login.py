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
textField = "textField.png"
emailField = None
passwordField = None
rememberMeCheckbox = "rememberMeCheckbox.png"
wrongEmailOrPassword = "wrongEmailOrPassword.png"
# elements in home page
adminFlag = "adminFlag.png"
accountMenu = "accountMenu.png"
logoutItem = "logoutItem.png"
userFlag = "1330483299063.png"


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
  global emailField, passwordField
  if emailField is None:
    emailField = find(emailLabel).below(70).find(textField)
  if passwordField is None:
    passwordField = find(passwordLabel).below(70).find(textField)

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
