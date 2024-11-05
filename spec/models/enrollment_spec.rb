RSpec.describe Enrollment do
  describe 'associations' do
    it { is_expected.to belong_to(:student) }
    it { is_expected.to belong_to(:section) }
  end
end
