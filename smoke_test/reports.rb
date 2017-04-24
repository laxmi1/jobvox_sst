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
  def test_load_reports
    login
    sleep 10
    @driver.find_element(:xpath, "//div[@class='account-name dropdown']").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-bar-chart-o']").click
    sleep 2
    @driver.find_element(:xpath, ".//*[@id='account-name']/ul/li[10]/ul/li[1]/a").click
    sleep 2
    @driver.find_element(:link_text, "Aging Invoices").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    @driver.find_element(:link_text, "Applied Payments").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    @driver.find_element(:link_text, "AR Schedule").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    @driver.find_element(:link_text, "Completed jobs").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    @driver.find_element(:link_text, "Customers Report - Contacts").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    @driver.find_element(:link_text, "Daily Sales, Payments Report").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    @driver.find_element(:link_text, "100% Invoiced Sales Orders").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Invoice Statements").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Invoices By Closed Date").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Invoices Daily").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    @driver.find_element(:link_text, "Invoices Monthly").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    @driver.find_element(:link_text, "Invoices Yearly").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    begin
    @driver.find_element(:link_text, "Jobs by Shipping Method").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    @driver.find_element(:link_text, "Jobs Custom Report").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    puts "Available"
    rescue => e
    puts "Not Available"  
    sleep 5
    end
    @driver.find_element(:link_text, "Jobs Created from Sales Orders").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    @driver.find_element(:link_text, "Jobs Without Sales Order").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 2
    @driver.find_element(:link_text, "Machines").click
    sleep 2
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Master Production Spreadsheets").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Materials By Location").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Open Invoices").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Open Purchase Orders").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Order without Jobs").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Payment methods").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Payment types").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Payments By Sales Rep").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Purchase Order - Sales Orders/Invoices Report").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Products By Location").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Profit Margin By Transactions").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Purchase Orders Daily").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Purchase Orders Monthly").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Purchase Orders Yearly").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Quotes By Salesrep").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Quotes Daily").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Quotes Monthly").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Quotes Yearly").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Royalty Report").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Sales Commission").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Sales Order with Quotes").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Sales Order without Quotes").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Sales Orders Daily").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Sales Orders Monthly").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Sales Orders Yearly").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Sales Tax").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Steps time").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Unapplied Payments").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Voided Invoices").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Voided jobs").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Voided Mat. Reqs").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Voided Payments").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Voided Projects").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Voided Purchase Orders").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Voided Quotes").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4
    @driver.find_element(:link_text, "Voided Sales Orders").click
    sleep 4
    @driver.find_element(:xpath, "//i[@class='fa fa-eye']").click
    sleep 4            
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
