require "spec_helper"
require "json"
require "omniauth-agsquared-oauth2"

describe OmniAuth::Strategies::AgsquaredOauth2 do
  let(:request) { double("Request", params: {}, cookies: {}, env: {}) }
  let(:app) do
    lambda do
      [200, {}, ["Sup."]]
    end
  end

  subject do
    OmniAuth::Strategies::AgsquaredOauth2.new(app, "appid", "secret", @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) do
        request
      end
    end
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe "#client_options" do
    it "has correct site" do
      expect(subject.client.site).to eq("https://www.agsquared.com")
    end

    it "has correct authorize_url" do
      expect(subject.client.options[:authorize_url]).to eq("https://www.agsquared.com/en/authorize")
    end

    it "has correct token_url" do
      expect(subject.client.options[:token_url]).to eq("https://api.agsquared.com/v1/oauth2/token")
    end

    describe "overrides" do
      context "as strings" do
        it "should allow overriding the site" do
          @options = { client_options: { "site" => "https://example.com" } }
          expect(subject.client.site).to eq("https://example.com")
        end

        it "should allow overriding the authorize_url" do
          @options = { client_options: { "authorize_url" => "https://example.com" } }
          expect(subject.client.options[:authorize_url]).to eq("https://example.com")
        end

        it "should allow overriding the token_url" do
          @options = { client_options: { "token_url" => "https://example.com" } }
          expect(subject.client.options[:token_url]).to eq("https://example.com")
        end
      end

      context "as symbols" do
        it "should allow overriding the site" do
          @options = { client_options: { site: "https://example.com" } }
          expect(subject.client.site).to eq("https://example.com")
        end

        it "should allow overriding the authorize_url" do
          @options = { client_options: { authorize_url: "https://example.com" } }
          expect(subject.client.options[:authorize_url]).to eq("https://example.com")
        end

        it "should allow overriding the token_url" do
          @options = { client_options: { token_url: "https://example.com" } }
          expect(subject.client.options[:token_url]).to eq("https://example.com")
        end
      end
    end
  end
end
