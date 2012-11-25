require 'spec_helper'

describe DeploymentsController do

  describe "GET 'stack'" do
    it "returns http success" do
      get 'stack'
      response.should be_success
    end
  end

end
