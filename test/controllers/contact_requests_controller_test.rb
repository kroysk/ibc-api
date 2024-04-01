require "test_helper"

class ContactRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contact_request = contact_requests(:one)
  end

  test "should get index" do
    get contact_requests_url, as: :json
    assert_response :success
  end

  test "should create contact_request" do
    assert_difference("ContactRequest.count") do
      post contact_requests_url, params: { contact_request: { cellphone: @contact_request.cellphone, email: @contact_request.email, message: @contact_request.message, name: @contact_request.name, status: @contact_request.status } }, as: :json
    end

    assert_response :created
  end

  test "should show contact_request" do
    get contact_request_url(@contact_request), as: :json
    assert_response :success
  end

  test "should update contact_request" do
    patch contact_request_url(@contact_request), params: { contact_request: { cellphone: @contact_request.cellphone, email: @contact_request.email, message: @contact_request.message, name: @contact_request.name, status: @contact_request.status } }, as: :json
    assert_response :success
  end

  test "should destroy contact_request" do
    assert_difference("ContactRequest.count", -1) do
      delete contact_request_url(@contact_request), as: :json
    end

    assert_response :no_content
  end
end
