# require 'rails_helper'
#
# # :id => :integer,
# #                  :email => :string,
# #     :encrypted_password => :string,
# #   :reset_password_token => :string,
# # :reset_password_sent_at => :datetime,
# #    :remember_created_at => :datetime,
# #          :sign_in_count => :integer,
# #     :current_sign_in_at => :datetime,
# #        :last_sign_in_at => :datetime,
# #     :current_sign_in_ip => :inet,
# #        :last_sign_in_ip => :inet,
# #         :social_type_id => :integer,
# #                :city_id => :integer,
# #                    :age => :integer,
# #                   :name => :string,
# #              :social_id => :string,
# #                    :sex => :string,
# #             :created_at => :datetime,
# #             :updated_at => :datetime
#
# # require 'spec_helper'
#
# RSpec.describe User, type: :model do
#   describe 'column specification' do
#     it { should have_db_column(:nickname).of_type(:string).with_options(presence: true) }
#     it { should have_db_column(:email).of_type(:string) }
#     it { should have_db_column(:avatar).of_type(:text) }
#   end
#
#   describe 'validate specification' do
#     it { should validate_presence_of(:nickname) }
#     it { should validate_presence_of(:email) }
#     # it { should validate_uniqueness_of(:avatar) }
#   end
#   #
#   # describe 'associations specification' do
#   #   it { should belong_to(:reseller) }
#   #
#   #   it { should have_many(:domains) }
#   #   it { should have_many(:domains) }
#   # end
#
#   # describe User do
#   # pending "add some examples to (or delete) #{__FILE__}"
#   # end
#
#   describe 'attributes specification' do
#     before { @user = User.new(nickname: 'Example User', email: 'user@example.com', avatar: '') }
#     subject { @user }
#     it { should respond_to(:nickname) }
#     it { should respond_to(:email) }
#     it { should respond_to(:avatar) }
#     it { should be_valid }
#
#     describe 'when name is not present' do
#       before { @user.nickname = ' ' }
#       it { should_not be_valid }
#     end
#
#     describe 'when name is too long' do
#       before { @user.nickname = 'a' * 51 }
#       it { should_not be_valid }
#     end
#
#     describe 'when name is too short' do
#       before { @user.nickname = 'a' }
#       it { should_not be_valid }
#     end
#
#     describe 'when email format is invalid' do
#       it 'should be invalid' do
#         invalid_emails = %w([user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com])
#         invalid_emails.each do |email|
#           @user.email = email
#           expect(@user).not_to be_valid
#         end
#       end
#     end
#
#   end
# end
