# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Tags", type: :request do
  let(:user) {create(:user)}
  let(:tag) {create(:tag, name:'振り返り')}

  describe 'モデルのテスト' do
    it "有効なタグ名の場合は登録されるか" do
      @user = build(:user)
      tag = build(:tag)
      sign_in @user
      expect(tag).to be_valid
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
        it 'トップ画面(public_root_path)に「タグ新規作成」が表示されているか' do
          expect(page).to have_content 'タグ新規作成'
        end
        it 'public_root_pathが"/public"であるか' do
          expect(current_path).to eq('/public')
        end
        it '投稿ボタンが表示されているか' do
          expect(page).to have_button 'タグを追加'
        end
      end
    end
  end


end