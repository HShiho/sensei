# frozen_string_literal: true

require 'rails_helper'

describe 'モデルのテスト' do
  it "有効な投稿の場合は登録されるか" do
    expect(FactoryBot.build(:post)).to be_valid
  end
end

describe：投稿のテスト
  let!：let!による事前評価
  describe：トップ画面(top_path)のテスト
    before：トップ画面への遷移
    context：表示の確認
      it：トップ画面(top_path)に「こんにちは」が表示されているか
        テストコード
      it：public_root_pathが"/public/"であるか
        テストコード

  describe ：投稿画面のテスト
    context：表示の確認 
      it：投稿ボタンが表示されているか
        テストコード
    context：投稿処理のテスト
      it：投稿後のリダイレクト先は正しいか
        テストコード

  describe：一覧画面のテスト
    before：一覧画面への遷移
    context ：一覧の表示とリンクの確認
      it：一覧表示画面に投稿されたもの表示されているか
        テストコード

  describe：詳細画面のテスト
    before：詳細画面への遷移
    context：表示のテスト
      it：削除リンクが存在しているか
        テストコード
      it：編集リンクが存在しているか
    context：リンクの遷移先の確認
      it：編集の遷移先は編集画面か
        テストコード
    context：post削除のテスト
      it：postの削除
        テストコード 
        
  describe：編集画面のテスト
    before：編集画面への遷移
    context：表示の確認
      it：編集前のタイトルと本文がフォームに表示(セット)されている
        テストコード
      it：保存ボタンが表示される
    context：更新処理に関するテスト
      it：更新後のリダイレクト先は正しいか
        テストコード