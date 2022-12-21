# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Topics", type: :request do
  let(:user) {create(:user)}
  let(:tag) {create(:tag, name:'振り返り')}
  let(:topic) {create(:topic, user_id: user.id, title:'hoge', tag_ids: tag.id)}

  describe 'モデルのテスト' do
    it "有効な投稿の場合は登録されるか" do
      @user = build(:user)
      @topic = build(:topic)
      sign_in @user
      expect(topic).to be_valid
    end
  end

  describe '一覧画面のテスト' do
  let!(:user) {create(:user)}
  let!(:topic) {create(:topic, user_id: user.id, title:'hoge', tag_ids: tag.id)}
    before do
      sign_in user
      visit public_topics_path
    end
  context '一覧の表示の確認' do
    it '一覧表示画面に投稿されたものが表示されているか' do
      expect(page).to have_content topic.user.nickname
      expect(page).to have_content topic.title
    end
  end
end


end