# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) {create(:user)}

describe 'モデルのテスト' do
  it "有効な会員情報の場合は登録されるか" do
    user = build(:user)
    expect(user).to be_valid
  end
end

describe '会員サイト新規登録のテスト' do
  let!(:user) { create(:user) }
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
      it 'ログイン画面へのリンクがあるか' do
        expect(page).to have_link "", href:  new_user_session_path
      end
    end
    context '登録処理のテスト' do
      it '登録後のリダイレクト先は正しいか' do
        fill_in 'user[nickname]', with: "test"
        fill_in 'user[email]', with: "test@gmail.com"
        fill_in 'user[password]', with: "111111"
        click_button '新規登録'
        expect(current_path).to eq('/users')
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
      it 'ログインボタンが表示されているか' do
        expect(page).to have_button 'ログイン'
      end
      it '新規登録画面へのリンクがあるか' do
        expect(page).to have_link "", href:  new_user_registration_path
      end
    end
    context 'ログイン処理のテスト' do
      it 'ログイン後のリダイレクト先は正しいか' do
        fill_in 'user[email]', with: "test@gmail.com"
        fill_in 'user[password]', with: "111111"
        click_button 'ログイン'
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
end

describe 'ユーザー一覧のテスト' do
  let!(:user) {create(:user)}
  before do
    sign_in user
    visit public_users_path
  end
  context '表示の確認' do
    it 'public_users_pathに「すべてのユーザー」の記述があるか' do
      expect(page).to have_content 'すべてのユーザー'
    end
    it 'public_users_pathが/public/usersであるか' do
      expect(current_path).to eq('/public/users')
    end
    it '登録されたユーザー名から詳細ページへのリンクがあるか' do
      expect(page).to have_content user.nickname
      expect(page).to have_link user.nickname
    end
  end
end

  describe 'ユーザー編集のテスト' do
    let!(:user) {create(:user)}
    before do
      sign_in user
      visit edit_public_user_path(user)
    end
    context '表示の確認' do
      it 'edit_public_user_pathに「ユーザー情報編集ページ」の記述があるか' do
        expect(page).to have_content 'ユーザー情報編集ページ'
      end
      it '編集前の情報がフォームに表示されているか' do
        expect(page).to have_field 'user[nickname]', with: user.nickname
        expect(page).to have_field 'user[email]', with: user.email
      end
      it '変更を保存するボタンが表示されているか' do
        expect(page).to have_button '変更を保存'
      end
    end
    context '変更処理の確認' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'user[nickname]', with: "test"
        fill_in 'user[email]', with: "test@gmail.com"
        click_button '変更を保存'
        expect(page).to have_current_path public_user_path(user)
      end
    end
  end

  describe '退会処理（論理削除）の確認' do
    let!(:user) {create(:user)}
    before do
      sign_in user
      visit edit_public_user_path(user)
    end
    context '表示の確認' do
      it '退会ボタンが表示されているか' do
        expect(page).to have_link "退会する", href: public_user_withdrawal_path(user)
      end
      it '退会ボタン押下後の遷移先は正しいか' do
        click_link '退会する'
        expect(page).to have_current_path public_user_withdrawal_path(user)
      end
      it 'public_user_withdrawal_pathに「退会お手続き」の記述があるか' do
        visit public_user_withdrawal_path(user)
        expect(page).to have_content "退会お手続き"
      end
      it '退会ボタンが表示されているか' do
        click_link '退会する'
        expect(page).to have_link "", href: public_user_breakaway_path(user)
      end
      it '退会辞退ボタンが表示されているか' do
        click_link '退会する'
        expect(page).to have_link "", href: public_root_path
      end
    end
    context '退会処理の確認' do
      it  '退会処理後のリダイレクト先は正しいか' do
        click_link '退会する'
        click_link '退会する'
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end

end