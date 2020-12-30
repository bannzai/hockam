class Inquiry < ApplicationRecord
	attr_accessor :sender_name, :sender_name_reading, :sender_mail_address, :message

	validates :sender_name, :presence => {:message => 'お名前を入力してください' }
	validates :sender_name_reading, :presence => {:message => 'お名前を入力してください' }
	validates :sender_mail_address, :presence => {:message => 'メールアドレスを入力してください' }
	validates :message, :presence => {:message => '内容を入力してください' }
end
