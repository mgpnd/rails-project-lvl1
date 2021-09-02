RSpec.describe HexletCode do
  describe '#form_for' do
    let(:object_struct) { Struct.new(:name) }
    let(:object) { object_struct.new(name: 'Alice') }

    context 'when url not provided' do
      subject do
        described_class.form_for(object) do
        end
      end

      it do
        is_expected.to eq(
          %Q{<form action="#" method="post">\n} \
          "  \n" \
          '</form>'
        )
      end
    end
  end
end
