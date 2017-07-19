require "selenium-webdriver"
# require "json"
gem "test-unit"
require "test/unit"
require 'rubygems'
require 'time'
# require "active_support"
# gem 'minitest'
# require 'minitest'
# require 'turn/autorun'
# Minitest.autorun
require 'yaml'

#Time.zone = "Pacific Time (US & Canada)"
APPLICATION_CONFIG = YAML.load_file("config.yaml")
Keys_CONFIG = YAML.load_file("properties.yaml")

# Fixtures support
class Test::Unit::TestCase 
  @@fixtures = {}
  @@config = {}
  def self.fixtures list
    [list].flatten.each do |fixture|
      self.class_eval do
        # add a method name for this fixture type
        define_method(fixture) do |item|
          # load and cache the YAML
          @@fixtures[fixture] ||= YAML::load_file("fixtures/#{fixture.to_s}.yaml")
          @@fixtures[fixture][item.to_s]
        end
      end
    end
  end
end

def element_present?(how, what)
      @driver.find_element(how, what)
      true
        rescue Selenium::WebDriver::Error::NoSuchElementError
      false
end

def alert_present?()
      @driver.switch_to.alert
      true
        rescue Selenium::WebDriver::Error::NoAlertPresentError
      false
end

def verify(&blk)
      yield
      rescue Test::Unit::AssertionFailedError => ex
      @verification_errors << ex
end

def close_alert_and_get_its_text(how, what)
      alert = @driver.switch_to().alert()
      alert_text = alert.text
      if (@accept_next_alert) then
        alert.accept()
      else
        alert.dismiss()
      end
      alert_text
      ensure
      @accept_next_alert = true
end

# get webdriver object
def get_driver
    # profile = Selenium::WebDriver::Firefox::Profile.new
    # profile['browser.download.dir'] = Dir.pwd+"/downloads"
    # profile['browser.download.folderList'] = 2
    # profile['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream,application/pdf"
    # profile['pdfjs.disabled'] = true
    # profile['pdfjs.firstRun'] = false
    # @driver= Selenium::WebDriver.for :firefox, :profile => profile
    Selenium::WebDriver::Chrome.driver_path = "./chromedriver"
    @driver = Selenium::WebDriver.for :chrome
    @base_url = APPLICATION_CONFIG["base_url"] 
    @admin_url = APPLICATION_CONFIG["admin_url"] 
    @new_account_url = APPLICATION_CONFIG["new_account_url"]
    @driver.manage.timeouts.implicit_wait = 10
    @driver.manage.window.maximize
    @wait = Selenium::WebDriver::Wait.new(:timeout => 60)
    @driver 
end

# method to login
def login
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "email").clear
    @driver.find_element(:id, "email").send_keys users(:laxmi)["email"]
    @driver.find_element(:id, "password").clear
    @driver.find_element(:id, "password").send_keys users(:laxmi)["password"] 
    @driver.find_element(:name, "commit").click
end

def logout
    @driver.find_element(:xpath, "//img[@class='ng-scope']").click
    @driver.find_element(:name, "sign-out").click
end

def create_vendor
    sleep 15
    @driver.find_element(:xpath, "//i[@name ='suitcase']").click
    @driver.find_element(:xpath, "//a[@ui-sref='vendors']").click
    @driver.find_element(:xpath, "//button[@uib-tooltip='Actions']").send_keys :enter
    @driver.find_element(:link_text, "New vendor").click
    time = get_Present
    vendor_Name = "Test vendor "+ time
    @driver.find_element(:xpath, "//input[@placeholder='Name']").send_keys vendor_Name
    @driver.find_element(:xpath, "//input[@placeholder='Legal name']").send_keys "Bharath"

    terms = "//select[@name='termCodeId']"
    terms_index = "2"
    getSelect_by_index(terms,terms_index) 

    tax = "//select[@name='salesTaxId']"
    tax_index = "2"
    getSelect_by_index(tax,tax_index)

    @driver.find_element(:xpath, "//input[@placeholder='jsmith@acme.com']").send_keys "abhinav@ahsgjashdkjf.com"
    # @driver.find_element(:xpath, "//input[@placeholder='(55) 5555-5555']").send_keys "9848032919"

    @driver.find_element(:xpath, "//*[@id='main-section']/div/div[2]/div/div/div[2]/div/form/div[2]/div/submit-button/button").send_keys :enter 
     sleep 5
     puts "created vendor with name: "+vendor_Name
     return vendor_Name
    
end

def create_material
    @driver.find_element(:xpath, "//div[@id='account-name']/a").click
    @driver.find_element(:xpath, "//li[@ng-if='currentAccount.featureFlags.orderManagementEnabled && currentAccount.policies.posSettingShow']").click
    @driver.find_element(:xpath, "//i[@class='fa fa-dollar']").click
    @driver.find_element(:xpath, "//a[@ui-sref='materials']").click
    sleep 2
    @driver.find_element(:link_text, "New Material").click
    
    time = get_Present
    material_name = "Material "+time
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[2]/div/div/section[1]/div/div/vox-text-field/div/div/input").send_keys material_name 

    type = "html/body/div[1]/div/div/form/div[2]/div/div/section[2]/div/div[1]/vox-select-field/div/select"
    type_index = "3"
    getSelect_by_index(type,type_index)
    sleep 2

    category = "html/body/div[1]/div/div/form/div[2]/div/div/section[2]/div/div[2]/vox-select-field/div/select"
    category_index = "2"
    getSelect_by_index(category,category_index)

    units = "//select[@name='material[units]']"
    units_index = "2"
    getSelect_by_index(units,units_index)

    buyingunits = "//select[@name='material[buying_units]']"
    buyingunits_index = "2"
    getSelect_by_index(buyingunits,buyingunits_index)
    
    sellingunits = "html/body/div[1]/div/div/form/div[2]/div/div/section[3]/div/div[1]/vox-select-field/div/select"
    sellingunits_index= "2"
    getSelect_by_index(sellingunits,sellingunits_index)

    sleep 2
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[2]/div/div/section[7]/div/div[1]/vox-text-field/div/div/input").clear
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[2]/div/div/section[7]/div/div[1]/vox-text-field/div/div/input").send_keys "30"

    sleep 2
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[2]/div/div/section[7]/div/div[2]/vox-text-field/div/div/input").clear
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[2]/div/div/section[7]/div/div[2]/vox-text-field/div/div/input").send_keys "40"
    
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[3]/submit-button/button").send_keys :enter
    sleep 10
    puts "Created "+material_name
    sleep 2
    return material_name   
  end
  
def create_customer
    sleep 15
    # @driver.find_element(:link_text, "Customers & Vendors").click
    @driver.find_element(:xpath, ".//*[@id='main-nav']/li[4]/a/span").click
    @driver.find_element(:xpath, "//a[@ui-sref='companies']").click
    sleep 5
    @driver.find_element(:xpath, "//button[@uib-tooltip='Actions']").send_keys :enter

    @driver.find_element(:link_text, "New customer").click

    time = get_Present
    customer_Name = "Customer "+time
    @driver.find_element(:xpath, "//input[@placeholder='Name']").send_keys customer_Name
    begin
      @driver.find_element(:xpath, "//input[@placeholder='Legal Name']").send_keys "Legal Name"
      puts "Legal name available"
    rescue => e
      puts "Legal name not available"
    end

    begin
      contact_Name = "Contact "+time
      @driver.find_element(:xpath, "//div[1][@class='col-sm-6']/vox-text-field/div/div/input").send_keys contact_Name
      @driver.find_element(:xpath, "//div[2][@class='col-sm-6']/vox-text-field/div/div/input").send_keys "laxmi@techvoxinc.com"
           puts "Contact available"
           sleep 5
       rescue => e
           puts "Contact is not available"
    end
    
    # @driver.find_element(:xpath, "//div[1][@class='col-sm-9 ng-scope']/phone-field/div/div").send_keys "9848071234"
     industry  = "//*[@id='main-section']/div/div[2]/div/div/div[2]/div/form/div[1]/div/section[8]/div[1]/div[1]/vox-select-field/div/select"
     industry_index = "2"
     getSelect_by_index(industry,industry_index)

    leadSource  = ".//*[@id='main-section']/div/div[2]/div/div/div[2]/div/form/div[1]/div/section[8]/div[1]/div[2]/vox-select-field/div/select"
    leadSource_index = "2"
    getSelect_by_index(leadSource,leadSource_index)

    @driver.find_element(:xpath, "//button[@class='submit-button button']").click
    sleep 10
    puts "created customer with name: "+customer_Name
    return customer_Name

end

def create_product
    sleep 10
    @driver.find_element(:xpath, "//div[@id='account-name']/a").click
    @driver.find_element(:xpath, "//li[@ng-if='currentAccount.featureFlags.orderManagementEnabled && currentAccount.policies.posSettingShow']").click
    @driver.find_element(:xpath, "//i[@class='fa fa-dollar']").click
    @driver.find_element(:xpath, "//a[@ui-sref='products']").click
    sleep 10
    @driver.find_element(:link_text, "New Product").click
    
    time = get_Present
    product_name = "Product "+time
    @driver.find_element(:xpath, "//input[@name='product[name]']").send_keys product_name 
    begin
    @driver.find_element(:xpath, "//textarea[@name='product[description]']").send_keys "Test description"        
    puts "description available"
    sleep 10
    rescue => e
    puts "description not available"       
    end
    type = "//select[@name='product[product_type_id]']"
    type_index = "3"
    getSelect_by_index(type,type_index)
    sleep 10
    category = "//select[@name='product[category_id]']"
    category_index = "2"
    getSelect_by_index(category,category_index)
    
    @driver.find_element(:xpath, "//input[@name='product[buying_cost_in_dollars]']").clear
    @driver.find_element(:xpath, "//input[@name='product[buying_cost_in_dollars]']").send_keys "20"
    sleep 2
    @driver.find_element(:xpath, "//input[@name='product[cost_in_dollars]']").clear
    @driver.find_element(:xpath, "//input[@name='product[cost_in_dollars]']").send_keys "30"

    sleep 2
    @driver.find_element(:xpath, "//input[@name='product[price_in_dollars]']").clear
    @driver.find_element(:xpath, "//input[@name='product[price_in_dollars]']").send_keys "40"
    
    incomeaccount = "//select[@name='product[income_coa_account_id]']"
    incomeaccount_index = "2"
    getSelect_by_index(incomeaccount,incomeaccount_index)

    cogaccount = "//select[@name='product[cog_coa_account_id]']"
    cogaccount_index = "2"
    getSelect_by_index(cogaccount,cogaccount_index)
    
    @driver.find_element(:xpath, "//input[@class='button']").click
    sleep 5
     puts "Created "+product_name
    return product_name
       
  end

def get_Present
    time = Time.now.strftime("%Y%m%d-%H%M%S")
end

def get_path
    path = Dir.pwd
end

def getElement_xpath(xpath)
      x_path = xpath
      begin
        @driver.find_element(:xpath,x_path)
      rescue
        puts "Element : "+xpath+" not found"
      end
end

def getSelect(xpath,option)
  begin
    Selenium::WebDriver::Support::Select.new(getElement_xpath(xpath)).select_by(:text,option)
  rescue

  end
end

def getSelect_by_index(xpath,index)
  begin
    Selenium::WebDriver::Support::Select.new(getElement_xpath(xpath)).select_by(:index,index)
  rescue

  end
end