RSpec.describe Section do
  describe 'associations' do
    it { is_expected.to belong_to(:teacher) }
    it { is_expected.to belong_to(:subject) }
    it { is_expected.to belong_to(:classroom) }
    it { is_expected.to have_many(:enrollments).dependent(:destroy) }
    it { is_expected.to have_many(:students).through(:enrollments) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
    it { is_expected.to validate_presence_of(:days) }
  end
end
