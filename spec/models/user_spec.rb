require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "ニックネームとパスワードが正常に入力されれば登録できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "ニックネームがなければ登録できない" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it "ニックネームがすでに存在する場合は登録できない" do
      user = create(:user)
      user_with_same_name = build(:user, name: user.name)
      expect(user_with_same_name).not_to be_valid
    end

    it "パスワードがなければ登録できない" do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it "パスワードが6文字未満は登録できない" do
      user = build(:user, password: "passw")
      expect(user).not_to be_valid
    end

    it "パスワードが21文字以上は登録できない" do
      user = build(:user, password: "passwordpasswordpassw")
      expect(user).not_to be_valid
    end

    it "パスワードに英数字以外が使用されていた場合登録できない" do
      user = build(:user, password: "パスワード")
      expect(user).not_to be_valid
    end
  end
end
