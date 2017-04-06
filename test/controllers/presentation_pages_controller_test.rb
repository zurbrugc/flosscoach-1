require 'test_helper'

class PresentationPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @presentation_page = presentation_pages(:one)
  end

  test "should get index" do
    get presentation_pages_url
    assert_response :success
  end

  test "should get new" do
    get new_presentation_page_url
    assert_response :success
  end

  test "should create presentation_page" do
    assert_difference('PresentationPage.count') do
      post presentation_pages_url, params: { presentation_page: {  } }
    end

    assert_redirected_to presentation_page_url(PresentationPage.last)
  end

  test "should show presentation_page" do
    get presentation_page_url(@presentation_page)
    assert_response :success
  end

  test "should get edit" do
    get edit_presentation_page_url(@presentation_page)
    assert_response :success
  end

  test "should update presentation_page" do
    patch presentation_page_url(@presentation_page), params: { presentation_page: {  } }
    assert_redirected_to presentation_page_url(@presentation_page)
  end

  test "should destroy presentation_page" do
    assert_difference('PresentationPage.count', -1) do
      delete presentation_page_url(@presentation_page)
    end

    assert_redirected_to presentation_pages_url
  end
end
