load File.dirname(__FILE__) +  '/../test_helper.rb'
load File.dirname(__FILE__) +  '/../test_helper.rb'

class Login < Test::Unit::TestCase 
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
  def test_create_materialreq
    login
    sleep 10
    sleep 10
    @driver.find_element(:xpath, "//div[@class='account-name dropdown']").click
    @driver.find_element(:xpath, "//li[@ng-if='currentAccount.featureFlags.orderManagementEnabled && currentAccount.policies.posSettingShow']").click
    @driver.find_element(:xpath, "//i[@class='fa fa-dollar']").click
    @driver.find_element(:xpath, "//a[@ui-sref='materials']").click
    sleep 2
    @driver.find_element(:link_text, "New Material").click
    
    time = get_Present
    material_name = "Material "+time
    @driver.find_element(:xpath, "//input[@name='material[name]']").send_keys material_name 

    type = "//select[@name='material[part_type_id]']"
    type_index = "3"
    getSelect_by_index(type,type_index)
    sleep 2

    category = "//select[@name='material[category_id]']"
    category_index = "2"
    getSelect_by_index(category,category_index)

    units = "//select[@name='material[units]']"
    units_index = "2"
    getSelect_by_index(units,units_index)

    buyingunits = "//select[@name='material[buying_units]']"
    buyingunits_index = "2"
    getSelect_by_index(buyingunits,buyingunits_index)

    sleep 2
    @driver.find_element(:xpath, "//input[@name='material[cost_in_dollars]']").clear
    @driver.find_element(:xpath, "//input[@name='material[cost_in_dollars]']").send_keys "30"

    sleep 2
    @driver.find_element(:xpath, "//input[@name='material[price_in_dollars]']").clear
    @driver.find_element(:xpath, "//input[@name='material[price_in_dollars]']").send_keys "40"
    
    @driver.find_element(:xpath, "//input[@class='button']").click 
    sleep 10
     puts "Created "+material_name

    @driver.find_element(:xpath, "//i[@class='fa fa-list']").click
    sleep 5    
    @driver.find_element(:link_text, "New Material Requisition").click
    sleep 4
    @driver.find_element(:xpath, "//span[@class='ui-select-placeholder text-muted ng-binding']").click
    @driver.find_element(:xpath, "//input[@placeholder='Search for Material...']").send_keys material_name
    @driver.find_element(:xpath, "//a[@class='ui-select-choices-row-inner']/div").click
    sleep 2
    uom = "//select[@name='uomName']"
    uom_index = "2"
    getSelect_by_index(uom,uom_index)
    sleep 2
    @driver.find_element(:xpath, "//button[@class='submit-button button']").send_keys :enter 
    sleep 2
    puts "Created"
    sleep 5
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
