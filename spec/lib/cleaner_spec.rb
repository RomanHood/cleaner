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
          :name => "John Lederer",
          :whatever => [
            {
              :something => "US Foods",
              :wholesaler => "Ben E. Keith",
              :name => "John Lederer",
              :another_layer => [
                :something => "something",
                :brand_new => "new",
                :delivered => "delivered",
                :new_layer => [
                  {
                    :contacts => "contacts",
                    :new_content => "new content",
                    :another_layer => "another_layer"
                  }
                ]
              ]
            },
          ]
        },
        {
          :wholesaler => "Sysco",
          :name => "Bill Delaney"
        },
        {
          :whatever => [
            {
              :something => "US Foods",
              :wholesaler => "Ben E. Keith",
              :name => "John Lederer"
            },
          ],
          :test => [
            :whatever => "whatever",
            :delivered => "delivered"
          ]
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

    context "when passed a different data type" do
      it "raises an error" do
        expect{ Cleaner.new(123) }.to raise_error "This isn't valide data!"
      end
    end
  end

  describe "#purge" do
    let(:cleaner) { Cleaner.new(example_data) }
    let(:purged) { cleaner.purge }
    it "removes duplicate keys from nested hash" do
      binding.pry
      expect(purged[:contacts][1].keys).not_to include(:wholesaler)
      expect(purged[:contacts][0].keys).not_to include(:wholesaler)
    end
  end
end
