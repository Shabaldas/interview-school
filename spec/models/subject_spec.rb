RSpec.describe Subject do
  describe 'associations' do
    it { is_expected.to have_many(:teacher_subjects).dependent(:destroy) }
    it { is_expected.to have_many(:teachers).through(:teacher_subjects) }
    it { is_expected.to accept_nested_attributes_for(:teacher_subjects).allow_destroy(true) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
