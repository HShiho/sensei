# frozen_string_literal: true

require 'rails_helper'

describe 'モデルのテスト' do
  it "有効な会員情報の場合は登録されるか" do
    expect(FactoryBot.build(:user)).to be_valid
  end
end

describe '会員サイト新規登録のテスト' do
  let!(:user) { create(:user, nickname:'hoge',email:'hoge@hoge.com',password:'hogehoge') }
  describe '新規登録画面(new_user_registration_path)のテスト' do
    before do
      visit new_user_registration_path
    end
    context '表示の確認' do
      it 'new_user_registration_pathに「新規登録」の記述があるか' do
        expect(page).to have_content '新規登録'
      end
      it 'new_user_registration_pathが/users/sign_upであるか' do
        expect(current_path).to eq('/users/sign_up')
      end
      it '登録ボタンが表示されているか' do
        expect(page).to have_button '新規登録'
      end
    end
    context '登録処理のテスト' do
      it '登録後のリダイレクト先は正しいか' do
        fill_in FactoryBot.build(:user)
        click_button '新規登録'
        expect(page).to have_current_path public_root_path
      end
    end
  end
end

describe '会員サイトログインのテスト' do
  describe 'ログイン画面(new_user_session_path)のテスト' do
    before do
      visit new_user_session_path
    end
    context '表示の確認' do
      it 'new_user_session_pathに「ログイン」の記述があるか' do
        expect(page).to have_content 'ログイン'
      end
      it 'new_user_session_pathが/users/sign_inであるか' do
        expect(current_path).to eq('/users/sign_in')
      end
      it '登録ボタンが表示されているか' do
        expect(page).to have_button 'ログイン'
      end
    end
    context 'ログイン処理のテスト' do
      it 'ログイン後のリダイレクト先は正しいか' do
        fill_in FactoryBot.build(:user)
        click_button 'ログイン'
        expect(page).to have_current_path public_root_path
      end
    end
  end
end

describe 'ユーザー一覧のテスト' do
  before do
    visit public_users_path
  end
  context '表示の確認' do
    it 'public_users_pathに「すべてのユーザー」の記述があるか' do
      expect(page).to have_content 'すべてのユーザー'
    end
    it 'public_users_pathが/public/usersであるか' do
      expect(page).to eq('/public/users')
    end
  end
end