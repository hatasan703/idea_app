require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "モデル" do
    let(:association) do
       described_class.reflect_on_association(target)
    end
    context "employeesに関するアソシエーション" do
      let(:target){:employees}
      it{expect(association.macro).to eq :has_many}
    end
    context "userに関するアソシエーション" do
      let(:target){:users}
      it{expect(association.macro).to eq :has_many}
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
