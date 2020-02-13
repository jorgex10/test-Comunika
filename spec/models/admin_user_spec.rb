require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it { should have_many(:messages) }
end
