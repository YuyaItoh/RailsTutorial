require 'spec_helper'

describe "Static pages" do
  let(:title) {"Ruby on Rails Tutorial Sample App | #{topic}"}
  subject { page }

  describe "Home page" do
    let(:topic) {"Sample App"}
    before { visit root_path }

    it { should have_content('Sample App') }
    it { should have_title(title)}
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    let(:topic) {"Help"}
    before { visit help_path }

    it { should have_content(topic) }
    it { should have_title(title) }
  end

  describe "About page" do
    let(:topic) {"About Us"}
    before { visit about_path }

    it { should have_content(topic) }
    it { should have_title(title) }
  end

  describe "Contact page" do
    let(:topic) {"Contact"}
    before { visit contact_path }

    it { should have_content(topic) }
    it { should have_title(title) }
  end
end