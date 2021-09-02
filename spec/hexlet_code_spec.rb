RSpec.describe HexletCode do
  describe '#form_for' do
    let(:object_struct) { Struct.new(:name, :job, :gender, keyword_init: true) }
    let(:object) { object_struct.new(name: 'rob', job: 'hexlet', gender: 'm') }

    it 'generates form with provided inputs' do
      form = HexletCode.form_for object do |f|
        f.input :name
        f.input :job, as: :text
        f.input :gender, as: :select, collection: %w[m f]
        f.submit
      end

      expect(form).to eq(<<~FORM.strip)
        <form action="#" method="post">
          <label for="name">Name</label>
          <input type="text" name="name" value="rob" />
          <label for="job">Job</label>
          <textarea name="job" cols="20" rows="40">hexlet</textarea>
          <label for="gender">Gender</label>
          <select name="gender">
            <option value="m" selected>m</option>
            <option value="f">f</option>
          </select>
          <input type="submit" name="commit" value="Save" />
        </form>
      FORM
    end
  end
end
