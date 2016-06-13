require 'test_helper'

class KeywordCollectionsControllerTest < ActionController::TestCase
  setup do
    @keyword_collection = keyword_collections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:keyword_collections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create keyword_collection" do
    assert_difference('KeywordCollection.count') do
      post :create, keyword_collection: { bing: @keyword_collection.bing, date: @keyword_collection.date, global_monthly_searches: @keyword_collection.global_monthly_searches, google: @keyword_collection.google, google_base_rank: @keyword_collection.google_base_rank, keywords: @keyword_collection.keywords, site_id: @keyword_collection.site_id, yahoo: @keyword_collection.yahoo }
    end

    assert_redirected_to keyword_collection_path(assigns(:keyword_collection))
  end

  test "should show keyword_collection" do
    get :show, id: @keyword_collection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @keyword_collection
    assert_response :success
  end

  test "should update keyword_collection" do
    patch :update, id: @keyword_collection, keyword_collection: { bing: @keyword_collection.bing, date: @keyword_collection.date, global_monthly_searches: @keyword_collection.global_monthly_searches, google: @keyword_collection.google, google_base_rank: @keyword_collection.google_base_rank, keywords: @keyword_collection.keywords, site_id: @keyword_collection.site_id, yahoo: @keyword_collection.yahoo }
    assert_redirected_to keyword_collection_path(assigns(:keyword_collection))
  end

  test "should destroy keyword_collection" do
    assert_difference('KeywordCollection.count', -1) do
      delete :destroy, id: @keyword_collection
    end

    assert_redirected_to keyword_collections_path
  end
end
