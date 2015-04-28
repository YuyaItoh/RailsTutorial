require 'spec_helper'

describe "Static pages" do
  let(:base_title) {"Ruby on Rails Tutorial Sample App | #{title}"}
  let(:path) {"/static_pages/#{action}"}

  describe "Home page" do
    let(:title) {"Home"}
    let(:action) {"home"}
    it "should have the title 'Home'" do
      visit path
      expect(page).to have_title(base_title)
    end
  end

  describe "Help page" do
    let(:title) {"Help"}
    let(:action) {"help"}
    it "should have the title 'Help'" do
      visit path
      expect(page).to have_title(base_title)
    end
  end

  describe "About page" do
    let(:title) {"About Us"}
    let(:action) {"about"}
    it "should have the title 'About Us'" do
      visit path
      expect(page).to have_title(base_title)
    end
  end
end