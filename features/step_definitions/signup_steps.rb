When /^I request a page on the Site$/ do
  browser.goto('http://localhost:3000/sso/logout')
  browser.goto('http://localhost:3000/')
end

And /^I am redirected to the SSO Server$/ do
  true
end

Then /^I should click the signup button$/ do
  browser.link(:url, "#{sso_server}/signup").click
end

When /^the page loads I should see a signup form$/ do
  browser.html.should have_selector("input[type='text'][name='first_name']")
end

Then /^I fill out the required information$/ do
  @email = /\w+@\w+\.\w{2,3}/.gen.downcase
  @first_name, @last_name = /\w+/.gen.capitalize, /\w+/.gen.capitalize
  browser.text_field(:name, :first_name).set(@first_name)
  browser.text_field(:name, :last_name).set(@last_name)
  browser.text_field(:name, :email).set(@email)
end

And /^click submit$/ do
  browser.button(:value, 'Signup').click
end

Then /^I should receive a registration URL$/ do
  @register_url = browser.html.match(%r!#{sso_server}/register/\w{40}!).to_s
  @register_url.should_not eql('')
  @password = /\w+{9,32}/.gen
end

When /^I click on the registration URL$/ do
  browser.goto(@register_url)
end

Then /^I should be prompted to enter my new password$/ do
  true
end

When /^I provide a new password$/ do
  browser.text_field(:name, :password).set(@password)
  browser.text_field(:name, :password_confirmation).set(@password)
end

And /^click Am I Done Yet\?$/ do
  browser.button(:value, 'Am I Done Yet?').click
end

Then /^I should be redirected back to the consumer application$/ do
  sleep 2
  true
end

Then /^I should know a little bit about myself as a user$/ do
  browser.html.should have_selector "h1:contains('Hancock Client: Rails')"
  browser.have_selector "td:contains('#{@email}')"
  browser.have_selector "td:contains('#{@first_name}')"
  browser.have_selector "td:contains('#{@last_name}')"
end
