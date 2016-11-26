require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'column specification' do
    it { should have_db_column(:parent_id).of_type(:integer) }
    it { should have_db_column(:name).of_type(:string) }
  end

  describe 'associations specification' do
    # it { should belong_to(:reseller) }
    it { should have_many(:events) }
    it { should have_many(:user_feeds) }
    it { should have_many(:users).through(:user_feeds) }
  end

  describe 'validate specification' do
    it { should validate_presence_of(:name) }
  end

  describe 'attributes specification' do
    before { @category = Category.create(parent_id: 1, name: 'cat1') }
    subject { @category }
    it { should respond_to(:name) }
    it { should respond_to(:parent_id) }
    it { should be_valid }

    describe 'when category name is not present' do
      before { @category.name = ' ' }
      it { should_not be_valid }
    end
  end
end
