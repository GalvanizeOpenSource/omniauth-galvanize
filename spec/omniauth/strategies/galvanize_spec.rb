require 'spec_helper'

describe OmniAuth::Strategies::Galvanize do
  subject { described_class.new({}) }

  it "defines the expected options" do
    expect(described_class.default_options).to include({
      "name" => "galvanize",
      "client_options" => {
        "site" => "https://members.galvanize.com",
        "authorize_url" => "/accounts/authorize",
        "token_url" => "/accounts/token",
      },
    })
  end

  describe "setup" do

    it "sets the authorize_url to `accounts/signup` if the strategy is `sign_up`" do
      options = {sign_up: true, client_options: {}}
      OmniAuth.config.before_request_phase.call('omniauth.strategy' => double(:strategy, options: options))

      expect(options[:client_options][:authorize_url]).to eq('accounts/signup')
    end

  end

  describe "content mapping" do
    let(:raw_info) {
      {
        'results' => [{
          'id' => 42,
          'onboard_uuid' => 'uuid42',
          'email' => 'email@example.com',
          'name' => 'Sterling Archer',
          'first_name' => 'Sterling',
          'last_name' => 'Archer',
          'about' => 'Sterling Malory Archer, known simply as Archer, is the title character and the main protagonist.',
          'photo' => 'https://imgur.com/arch3r',
          'home_location' => '_home_location_',
          'roles' => [{name: 'Role1'}, {name: 'Role2'}],
          'cohorts' => [{label: 'XX-XX-XX-01'}, {label: 'XX-XX-XX-02'}],
          'companies' => [{name: 'Company1'}, {name: 'Company2'}],
        }]
      }
    }

    before do
      allow(subject).to receive(:raw_info).and_return(raw_info)
    end

    describe "uid" do

      it "returns the id" do
        expect(subject.uid).to eq(42)
      end

    end

    describe "info" do

      it "returns a mapped hash with the expected results" do
        expect(subject.info).to eq({
          onboard_uuid: 'uuid42',
          galvanize_id: 42,
          email: 'email@example.com',
          name: 'Sterling Archer',
          first_name: 'Sterling',
          last_name: 'Archer',
          about: 'Sterling Malory Archer, known simply as Archer, is the title character and the main protagonist.',
          photo: 'https://imgur.com/arch3r',
          home_location: '_home_location_',
          roles: [{name: 'Role1'}, {name: 'Role2'}],
          cohort: [{label: 'XX-XX-XX-01'}, {label: 'XX-XX-XX-02'}],
          cohorts: [{label: 'XX-XX-XX-01'}, {label: 'XX-XX-XX-02'}],
          companies: [{name: 'Company1'}, {name: 'Company2'}],
        })
      end

    end

    describe "extra" do

      it "returns the raw_info directly" do
        expect(subject.extra).to eq('raw_info' => raw_info)
      end

    end
  end
end
