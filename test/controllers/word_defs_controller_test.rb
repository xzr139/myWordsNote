require 'test_helper'

class WordDefsControllerTest < ActionController::TestCase
  setup do
    @word_def = word_defs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:word_defs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create word_def" do
    assert_difference('WordDef.count') do
      post :create, word_def: { eg: @word_def.eg, en: @word_def.en, jp: @word_def.jp, title: @word_def.title }
    end

    assert_redirected_to word_def_path(assigns(:word_def))
  end

  test "should show word_def" do
    get :show, id: @word_def
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @word_def
    assert_response :success
  end

  test "should update word_def" do
    patch :update, id: @word_def, word_def: { eg: @word_def.eg, en: @word_def.en, jp: @word_def.jp, title: @word_def.title }
    assert_redirected_to word_def_path(assigns(:word_def))
  end

  test "should destroy word_def" do
    assert_difference('WordDef.count', -1) do
      delete :destroy, id: @word_def
    end

    assert_redirected_to word_defs_path
  end
end
