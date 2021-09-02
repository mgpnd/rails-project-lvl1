# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
RSpec.describe HexletCode::Tag do
  describe '#build' do
    context 'when no attributes and content provided' do
      it 'generates self-closing tag without attributes and content' do
        expect(described_class.build('br')).to eq('<br />')
      end
    end

    context 'when attributes without content provided' do
      it 'generates self-closing tag with attributes' do
        expect(
          described_class.build('input', type: 'submit', value: 'Save')
        ).to eq(
          '<input type="submit" value="Save" />'
        )
      end
    end

    context 'when content without attributes provided' do
      it 'generates tag with content' do
        expect(
          described_class.build('label') { 'Email' }
        ).to eq(
          '<label>Email</label>'
        )
      end
    end

    context 'when content and attributes provided' do
      it 'generates tag with content and attributes' do
        expect(
          described_class.build('label', for: 'email') { 'Email' }
        ).to eq(
          '<label for="email">Email</label>'
        )
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
