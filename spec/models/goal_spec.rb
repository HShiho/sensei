# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Goals", type: :request do
  let(:user) {create(:user)}
  let(:goal) {create(:goal, title:'hoge', user_id: user.id)}

  describe 'モデルのテスト' do
    it "有効なタグ名の場合は登録されるか" do
      @user = build(:user)
      @goal = build(:goal)
      sign_in @user
      expect(goal).to be_valid
    end
  end

end