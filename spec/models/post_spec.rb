# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) {create(:user)}
  let(:tag) {create(:tag, name:'振り返り')}
  let(:post) {create(:post, user_id: user.id, body:'hoge', tag_ids: tag.id)}

describe 'モデルのテスト' do
  it "有効な投稿の場合は登録されるか" do
    @user = build(:user)
    @post = build(:post)
    sign_in @user
    expect(post).to be_valid
  end
end

describe '投稿のテスト' do
  let(:user) {create(:user)}
  describe 'トップ画面(public_root_path)のテスト' do
    before do
      sign_in user
      visit public_root_path
    end
    context '表示の確認' do
      it 'トップ画面(public_root_path)に「こんにちは」が表示されているか' do
        expect(page).to have_content 'こんにちは'
      end
      it 'public_root_pathが"/public"であるか' do
        expect(current_path).to eq('/public')
      end
    end
  end
end

describe '投稿画面のテスト' do
  let!(:user) {create(:user)}
  let!(:post) {create(:post, user_id: user.id, body:'hoge', tag_ids: tag.id)}
    before do
      sign_in user
      visit public_root_path
    end
  context '表示の確認' do
    it '投稿ボタンが表示されているか' do
      expect(page).to have_button '投稿'
    end
  end
  context '投稿処理のテスト' do
    it '投稿後のリダイレクト先は正しいか' do
      fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
      fill_in 'post[tag_ids]', with: tag.id
      click_button '投稿'
      expect(page).to have_current_path public_user_posts_path(user)
    end
  end
end

describe '一覧画面のテスト' do
  let!(:user) {create(:user)}
  let!(:post) {create(:post, user_id: user.id, body:'hoge', tag_ids: tag.id)}
    before do
      sign_in user
      visit public_posts_path
    end
  context '一覧の表示の確認' do
    it '一覧表示画面に投稿されたものが表示されているか' do
      expect(page).to have_content post.user.nickname
      expect(page).to have_content post.body
    end
  end
end

describe '詳細画面のテスト' do
  let!(:user) {create(:user)}
  let!(:post) {create(:post, user_id: user.id, body:'hoge', tag_ids: tag.id)}
    before do
      sign_in user
      visit public_post_path(user)
    end
  context '表示のテスト' do
    it '削除リンクが存在しているか' do
      expect(page).to have_link "削除", href: public_post_path(user)
    end
  end
  context 'post削除のテスト' do
    it 'postの削除' do
      expect{ post.destroy }.to change{ Post.count }.by(-1)
    end
  end
end

end