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
      it 'ログイン画面へのリンクがあるか' do
        expect(page).to have_link "", href:  new_user_session_path
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
      it 'ログインボタンが表示されているか' do
        expect(page).to have_button 'ログイン'
      end
      it '新規登録画面へのリンクがあるか' do
        expect(page).to have_link "", href:  new_user_registration_path
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
    it '登録されたユーザー名から詳細ページへのリンクがあるか' do
      expect(page).to have_content user.nickname
      expect(page).to have_link user.nickname
    end
  end

  describe 'ユーザー編集のテスト' do
    before do
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
        fill_in 'user[nickname]', with: Faker::Name.name(number:5)
        fill_in 'user[email]', with: Faker::Internet.email(number:12)
        click_button '変更を保存'
        expect(page).to have_current_path public_user_path(user)
      end
    end
  end
  
  describe '退会処理（論理削除）の確認' do
    before do 
      visit edit_public_user_path(user)
    end
    context '表示の確認' do
      it '退会ボタンが表示されているか' do
        expect(page).to have_button '退会する'
        expect(page).to have_link "", href: public_withdrawal_path
      end
      it '退会ボタン押下後の遷移先は正しいか' do
        click_button '退会する'
        expect(page).to have_current_path public_withdrawal_path
      end
      it 'public_withdrawal_pathに「退会お手続き」の記述があるか' do
        expect(page).to have_content '退会お手続き'
      end
      it '退会ボタンが表示されているか' do
        expect(page).to have_button '退会する'
        expect(page).to have_link "", href: public_user_breakaway_path
      end
      it '退会辞退ボタンが表示されているか' do
        expect(page).to have_button '退会しない'
        expect(page).to have_link "", href: public_root_path
      end
    end
    context '退会処理の確認' do
      it  '退会処理後のリダイレクト先は正しいか' do
        click_button '退会する'
        expect(page).to have_current_path new_user_session_path
      end
    end
  end

end