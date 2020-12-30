class Inquiry < ApplicationRecord
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	attr_accessor :sender_name, :sender_name_reading, :sender_mail_address, :message

	validates :sender_name, presence: { message: 'お名前を入力してください' }
  validates :sender_name_reading, presence: { message: 'お名前(ふりがな)を入力してください' }
  validates :sender_mail_address, presence: { message: 'メールアドレスを入力してください' },
    format: { with: EMAIL_REGEX, message: "メールアドレスの形式ではありません"  },
    length: { minimum: 4, maximum: 254, message: "メールアドレスが短すぎる。もしくは長すぎます" }
  validates :message, presence: { message: 'お問い合わせ内容を入力してください' }
end
