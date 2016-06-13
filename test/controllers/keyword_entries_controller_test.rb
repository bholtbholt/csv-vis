require 'test_helper'

class KeywordEntriesControllerTest < ActionController::TestCase
  setup do
    @keyword_entry = keyword_entries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keyword_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create keyword_entry" do
    assert_difference('KeywordEntry.count') do
      post :create, keyword_entry: {  }
    end

    assert_redirected_to keyword_entry_path(assigns(:keyword_entry))
  end

  test "should show keyword_entry" do
    get :show, id: @keyword_entry
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @keyword_entry
    assert_response :success
  end

  test "should update keyword_entry" do
    patch :update, id: @keyword_entry, keyword_entry: {  }
    assert_redirected_to keyword_entry_path(assigns(:keyword_entry))
  end

  test "should destroy keyword_entry" do
    assert_difference('KeywordEntry.count', -1) do
      delete :destroy, id: @keyword_entry
    end

    assert_redirected_to keyword_entries_path
  end
end
