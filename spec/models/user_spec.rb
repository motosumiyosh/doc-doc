# frozen_string_literal: true

require 'rails_helper'

describe User do
  context 'passwordのバリデーションのアウト・セーフ' do
    it 'passwordが小文字のみ' do
      user = User.new(
        name: 'seri',
        email: 'sacwddfc@example.com',
        password: 'safdsssdcscedf'
      )
      expect(user).to be_invalid
    end
    it 'passwordが8文字未満' do
      user = User.new(
        name: 'seri',
        email: 'sacsnfd@example.com',
        password: 'b'
      )
      expect(user).to be_invalid
    end
    it '成功例' do
      user = User.new(
        name: 'masaki',
        email: '18sajcm@example.com',
        password: 'saichi3353'
      )
      expect(user).to be_valid
    end
  end
end
