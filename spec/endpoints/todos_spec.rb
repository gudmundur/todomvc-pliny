require "spec_helper"

describe Endpoints::Todos do
  include Rack::Test::Methods

  describe "GET /todos" do
    it "succeeds" do
      get "/todos"
      assert_equal 200, last_response.status
    end
  end
end
