RSpec.describe TeacherSubject do
  describe 'associations' do
    it { is_expected.to belong_to(:teacher) }
    it { is_expected.to belong_to(:subject) }
  end
end
