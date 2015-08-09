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

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem")
        FactoryGirl.create(:micropost, user: user, content: "Ipsum")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
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