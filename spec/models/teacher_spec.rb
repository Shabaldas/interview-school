RSpec.describe Teacher do
  describe 'associations' do
    it { is_expected.to have_many(:teacher_subjects).dependent(:destroy) }
    it { is_expected.to have_many(:subjects).through(:teacher_subjects) }
    it { is_expected.to accept_nested_attributes_for(:teacher_subjects).allow_destroy(true) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe '#full_name' do
    it 'returns the first and last name concatenated' do
      teacher = build(:teacher, first_name: 'John', last_name: 'Doe')
      expect(teacher.full_name).to eq('John Doe')
    end
  end
end
