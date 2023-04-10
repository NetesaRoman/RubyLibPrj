require "test_helper"

class ReaderCardsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get reader_cards_new_url
    assert_response :success
  end

  test "should get edit" do
    get reader_cards_edit_url
    assert_response :success
  end

  test "should get show" do
    get reader_cards_show_url
    assert_response :success
  end

  test "should get update" do
    get reader_cards_update_url
    assert_response :success
  end

  test "should get create" do
    get reader_cards_create_url
    assert_response :success
  end

  test "should get destroy" do
    get reader_cards_destroy_url
    assert_response :success
  end
end
