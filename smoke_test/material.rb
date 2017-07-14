load File.dirname(__FILE__) +  '/../test_helper.rb'
load File.dirname(__FILE__) +  '/../test_helper.rb'

class Product < Test::Unit::TestCase 
  fixtures :users

# To open firefox browser and the application url
  def setup
    @driver = get_driver
    @accept_next_alert = true
    @verification_errors = [] 
  end
# Throws an assertion errors
  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  
# Test to login with valid credentials
  def test_create_material
    login
    sleep 15
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

    sleep 2
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[2]/div/div/section[7]/div/div[1]/vox-text-field/div/div/input").clear
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[2]/div/div/section[7]/div/div[1]/vox-text-field/div/div/input").send_keys "30"

    sleep 2
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[2]/div/div/section[7]/div/div[2]/vox-text-field/div/div/input").clear
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[2]/div/div/section[7]/div/div[2]/vox-text-field/div/div/input").send_keys "40"
    
    @driver.find_element(:xpath, "html/body/div[1]/div/div/form/div[3]/submit-button/button").click 
    sleep 5
    puts "Created "+material_name
     
  end

  
# To find the element and throws an error if element is not found.
   def element_present?(how, what)
    @driver.find_element(how, what)
    true
      rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

# To see the alert is present and throws an error if no alert is present
  def alert_present?()
    @driver.switch_to.alert
    true
  rescue Selenium::WebDriver::Error::NoAlertPresentError
    false
  end
  
# To verify expected and actual values
# If assertion failed it throws an error
  def verify(&blk)
    yield
    rescue Test::Unit::AssertionFailedError => ex
    @verification_errors << ex
  end
  
# To close alerts
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
end
