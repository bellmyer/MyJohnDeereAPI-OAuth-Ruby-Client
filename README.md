# MyJohnDeereAPI-OAuth-Ruby-Client
MyJohnDeere API implementation for the Ruby OAuth library

## System Requirments
1. Download Java JDK 1.7 or higher, set the JAVA_HOME variable
2. download the latest jruby binary distribution from http://www.jruby.org/download and oauth gem
3. add the bin directory to your path <br>
   ```setx /m path "%path%;C:\jruby\bin"```


## Run the sample app
1. Execute gem install oauth
2. Update API_KEY and API_SECRET with the details from developer.deere.com app
3. excute jruby ruby_client.rb, which will display url with request token <br>
  ``` 
  ****  Fetching request token ****
  Request Token received - 9f14e0ed-247e-432d-bb05-2db139dce50a

  ---> Goto to url mentioned below to authorize and paste the access token verifier
  https://my.deere.com/consentToUseOfData?oauth_token=your request token
  ```
4. Copy the url in browser and hit enter.
5. Login with your johndeere userId and password
6. You will get the verifier in the browser
  ``` 
  Success!

  Now, enter the verifier code hy3OpT into Your app name.

  If anyone asks, your OAuth Request Token is 9f14e0ed-247e-432d-bb05-2db139dce50a
  ```
7. Copy and paste the verfier in the console. This will generate accestoken and calls /organizations
  ```  
  ***** Fetching access token *****
  Access token received - Your access token

  ***** Fetching organizations: GET /organizations *****
  ```
