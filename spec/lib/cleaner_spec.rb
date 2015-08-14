require 'pry'
require 'spec_helper'
require 'cleaner'

describe Cleaner do
  let(:example_data) {
    {
      :wholesaler => "US Foods",
      :delivered => "2015-06-19T05:15:00-0500",
      :contacts => [
        {
          :wholesaler => "US Foods",
          :name => "John Lederer"
        },
        {
          :wholesaler => "Sysco",
          :name => "Bill Delaney"
        }
      ]
    }
  }

  describe "#initialize" do
    context "when passed a hash" do
      let(:cleaner) { Cleaner.new(example_data)}
      it "saves the hash to an accessible variable" do
        expect(cleaner.hash).to eq(example_data)
      end
    end

    context "when passed a json string" do
      let(:cleaner) { Cleaner.new(example_data.to_json)}
      it "parses the json and saves the hash" do
        expect(cleaner.hash).to eq(JSON.parse(example_data.to_json))
      end
    end
  end
end
