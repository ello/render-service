require 'spec_helper'

describe Ello::RenderService::Filters::RumojiFilter do

  let(:html) { "\xF0\x9F\x98\x81" }
  let(:result) { described_class.to_html(html) }

  it 'converts Unicode emoji to textual representations' do
    expect(result).to eq(':grin:')
  end

  describe 'when the string contains no actual emoji' do
    let(:html) { 'hello!' }
    before { allow(Rumoji).to receive(:encode) }

    it 'does not call into Rumoji' do
      expect(result).to eq('hello!')
      expect(Rumoji).not_to have_received(:encode)
    end
  end

  describe 'when existing textual representations are present' do
    let(:html) { ':grin:' }

    it 'does not munge them' do
      expect(result).to eq(':grin:')
    end
  end

  describe 'when using extended-range emoji' do
    context 'on the low end' do
      let(:html) { "\xE2\x8C\x9A" } # U+231A

      it 'converts Unicode emoji to textual representations' do
        expect(result).to eq(':watch:')
      end
    end

    context 'on the high end' do
      let(:html) { "\xF0\x9F\x99\x8F" } # U+1F64F

      it 'converts Unicode emoji to textual representations' do
        expect(result).to eq(':pray:')
      end
    end
  end
end
