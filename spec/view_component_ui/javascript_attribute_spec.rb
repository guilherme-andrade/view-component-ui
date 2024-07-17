require 'view_component_ui'
require 'view_component_ui/javascript_attribute'
require 'pry'

RSpec.describe ViewComponentUI::JavascriptAttribute do
  subject(:javascript_attribute) { described_class.new(name:, value:) }

  describe "#to_html_attribute" do
    context "for an on_click attribute" do
      let(:name) { :on_click }
      let(:value) { "alert('Hello, World!')" }

      it "returns the attribute as a hash" do
        expect(javascript_attribute.to_html_attribute).to eq("@click" => "alert('Hello, World!')")
      end

      context "for a composite on_click" do
        let(:value) { { prevent: "alert('Hello, World!')" } }

        it "returns the attribute as a hash" do
          expect(javascript_attribute.to_html_attribute).to eq("@click.prevent" => "alert('Hello, World!')")
        end
      end

      context "for a simple stop propagation" do
        let(:value) { { stop: true } }

        it "returns the attribute as a hash" do
          expect(javascript_attribute.to_html_attribute).to eq("@click.stop" => nil)
        end
      end
    end

    context "for an x_data attribute" do
      let(:name) { :x_data }
      let(:value) { "{ activeIndex: 0 }" }

      it "returns the attribute as a hash" do
        expect(javascript_attribute.to_html_attribute).to eq("x-data" => "{ activeIndex: 0 }")
      end
    end

    context "for a hash value" do
      let(:name) { :x_transition }
      let(:value) { { enter: { duration: 300 }, leave: { duration: 300 } } }

      it "returns the attribute as a hash" do
        expect(javascript_attribute.to_html_attribute).to eq("x-transition:enter.duration" => 300, "x-transition:leave.duration" => 300)
      end
    end
  end
end
