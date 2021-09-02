RSpec.describe HexletCode do
  describe '#form_for' do
    let(:object_struct) { Struct.new(:name, :job, :gender, keyword_init: true) }
    let(:object) { object_struct.new(name: 'rob', job: 'hexlet', gender: 'm') }

    it 'generates form with provided inputs' do
      form = HexletCode.form_for object do |f|
        f.input :name
        f.input :job, as: :text
        f.input :gender, as: :select, collection: %w[m f]
      end

      expect(form).to eq(<<~FORM.strip)
        <form action="#" method="post">
          <input type="text" name="name" value="rob" />
          <textarea name="job" cols="20" rows="40">hexlet</textarea>
          <select name="gender">
            <option value="m" selected>m</option>
            <option value="f">f</option>
          </select>
        </form>
      FORM
    end
  end
end
