require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('wow such header') }
    it { should have_title('Cluttered') }
    it { should have_title('| Home') }
  end
end
