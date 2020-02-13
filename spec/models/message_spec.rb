require 'rails_helper'

describe Message, type: :model do
  it { should belong_to(:admin_user) }
  it { should belong_to(:receiver) }
end