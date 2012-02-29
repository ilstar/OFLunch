loginPageTitle = "OGREJ.png"


# open browser
def openBrowser():
  browser = App("Google Chrome Canary")
  browser.open()
  browserPattern = "Chrome.png"
  wait(browserPattern, 20)

# close browser
def closeBrowser():
  browser = App("Google Chrome Canary")
  browser.focus()
  browser.close()

# navigate to site
def openHomePage():
  homeurl = "http://tuantuanfan.herokuapp.com/"
  browserNavigationBar = "1330415953990.png"
  type(browserNavigationBar, homeurl + Key.ENTER)
  wait(loginPageTitle, 20)

# initial step of login
def loginInit():
  wait(5)
  openBrowser()
  openHomePage()  

loginInit()
adminEmail = "xingkui.wang@gree.co.jp"
# elements in login page
singinButton = "1330416320591.png"
emailLabel = "IfTIBlI.png"
passwordLabel = "Password.png"
textField = "1330420667189.png"
# you can use highlight to debug the region is what you want
emailField = find(emailLabel).below(60).find(textField) 
passwordField = find(passwordLabel).below(60).find(textField)
rememberMeCheckbox = "1330417595269.png"
wrongEmailOrPassword = "AlertInvalid.png"
# elements in admin home page
adminFlag = "homeMOD.png"
accountMenu = "Account.png"
logoutItem = "Logout.png"


# login withought email and password
def loginWithoughtEmailAndPassword():
  click(singinButton)
  wait(wrongEmailOrPassword, 20)
  closeBrowser()



# login with email and empty password
def loginWithEmailAndEmptyPassword():
  loginInit()
  type(emailField, adminEmail)
  click(singinButton)
  wait(wrongEmailOrPassword, 20)
  closeBrowser()


# login with wrong email and password
def loginWithWrongEmailAndPassword():
  loginInit()
  type(emailField, adminEmail)
  type(passwordField, "123456")
  click(singinButton)
  wait(wrongEmailOrPassword, 20)
  closeBrowser()

# Admin login with right email and password and see MOD menu
def adminLoginWithRightEmailAndPassword():
  loginInit()
  type(emailField, adminEmail)
  type(passwordField, "openfeint")
  type(Key.ENTER)
  wait(adminFlag, 20)

#Admin logout
def adminLogout():
  click(accountMenu)
  wait(logoutItem, 20)
  click(logoutItem)
  wait(loginPageTitle, 20)
  closeBrowser()

# Admin login withought check remember me
def adminLoginWithoughtCheckRememberMe():
  adminLoginWithRightEmailAndPassword()
  closeBrowser()
  loginInit()
  wait(loginPageTitle, 20)
  closeBrowser()

# Admin login and check remember me
def adminLoginAndCheckRememberMe():
  loginInit()
  type(emailField, adminEmail)
  type(passwordField, "openfeint")
  click(rememberMeCheckbox)
  click(singinButton)
  wait(adminFlag, 20)
  closeBrowser()
  loginInit()
  wait(adminFlag, 20)
  adminLogout()

# User login and can't see MOD menu

# User logout



# test steps
loginWithoughtEmailAndPassword()
loginWithEmailAndEmptyPassword()
loginWithWrongEmailAndPassword()
adminLoginWithRightEmailAndPassword()
adminLogout()
adminLoginWithoughtCheckRememberMe()
adminLoginAndCheckRememberMe()
