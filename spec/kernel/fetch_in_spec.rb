require 'kernel/fetch_in'

RSpec.describe Kernel do
  let(:collection) { double }
  let(:key) { double }
  let(:value) { double }

  describe '#fetch_in' do
    context 'passed no key arguments' do
      it 'raises an ArgumentError' do
        expect { fetch_in(collection) }.to raise_error ArgumentError
      end
    end

    context 'passed a single key argument' do
      it 'returns what #fetch on the collection argument returns' do
        allow(collection).to receive(:fetch).with(key) { value }
        expect(fetch_in(collection, key)).to be value
      end

      [IndexError, KeyError].each do |err|
        context "when #fetch raises a #{err}" do
          before { allow(collection).to receive(:fetch).with(key) { raise err } }

          it 'raises that Error' do
            expect { fetch_in(collection, key) }.to raise_error err
          end

          context 'and a block argument is provided' do
            it 'returns the return value of that block argument' do
              expect(fetch_in(collection, key) { value }).to be value
            end

            it 'yields the the key to that block' do
              expect { |b| fetch_in(collection, key, &b) }.to yield_with_args(key)
            end
          end
        end
      end
    end

    context 'passed multiple key arguments' do
      it 'chains #fetch calls on the collection' do
        allow(collection).to receive(:fetch).with(key) { value }
        outer_collection = double
        key2 = double
        allow(outer_collection).to receive(:fetch).with(key2) { collection }

        expect(fetch_in(outer_collection, key2, key)).to be value
      end
    end
  end
end
