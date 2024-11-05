RSpec.describe Student do
  describe 'associations' do
    it { is_expected.to have_many(:enrollments).dependent(:destroy) }
    it { is_expected.to have_many(:sections).through(:enrollments) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe '#full_name' do
    it 'returns the first and last name concatenated' do
      student = build(:student, first_name: 'John', last_name: 'Doe')
      expect(student.full_name).to eq('John Doe')
    end
  end
end
