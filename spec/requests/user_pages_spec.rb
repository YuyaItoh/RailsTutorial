require 'spec_helper'

describe "UserPages" do
  let(:title) {"Ruby on Rails Tutorial Sample App | #{topic}"}
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    let(:topic) { 'Sign up' }

    it { should have_content(topic) }
    it { should have_title(title) }
  end
end
