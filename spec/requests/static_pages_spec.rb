require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'wow such header'" do
      visit '/static_pages/home'
      expect(page).to have_content('wow such header')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      expect(page).to have_title("Vectorails")
    end

    it "should have a custom page title" do
      visit '/static_pages/home'
      expect(page).to have_title('| Home')
    end

  end
end
