require "../spec_helper"

module EqualizeTest
  class BaseClass
    property id : Int32

    def initialize(@id)
    end

    equalize({:id, :id})
  end

  class StrictBase
    property id : Int32

    def initialize(@id)
    end

    equalize({:id, :id}, strict: true)
  end

  class SimpleClassOne < BaseClass
    equalize({:id, :id})
  end

  class SimpleClassTwo < BaseClass
    equalize({:id, :id})
  end

  class StrictClassOne < StrictBase
    equalize({:id, :id}, strict: true)
  end

  class StrictClassTwo < StrictBase
    equalize({:id, :id}, strict: true)
  end

  class LoneClass
    property id : Int32

    def initialize(@id)
    end

    equalize({:id, :id})
  end
end

class AliasClass

  def concatenate(*args)
    args.join(" ")
  end
  alias_method :concat, :concatenate

end

describe Object do
  describe "macro equalize" do
    context "strict is false" do
      it "makes two classes with the same equalized variable, equal" do
        class_one = EqualizeTest::LoneClass.new(15)
        class_two = EqualizeTest::LoneClass.new(15)
        expect(class_one == class_two).to be_true
      end

      it "makes two classes with a different equalized variable, not equal" do
        class_one = EqualizeTest::LoneClass.new(15)
        class_two = EqualizeTest::LoneClass.new(16)
        expect(class_one == class_two).to be_false
      end

      it "makes two different classes with the same variable, not equal" do
        class_one = EqualizeTest::LoneClass.new(15)
        class_two = EqualizeTest::SimpleClassOne.new(15)
        expect(class_one == class_two).to be_false
      end

      it "makes parent and child classes with the same variable, equal" do
        class_one = EqualizeTest::BaseClass.new(15)
        class_two = EqualizeTest::SimpleClassOne.new(15)
        expect(class_one == class_two).to be_true
      end

      it "makes parent and child classes with a different variable, not equal" do
        class_one = EqualizeTest::BaseClass.new(15)
        class_two = EqualizeTest::SimpleClassOne.new(16)
        expect(class_one == class_two).to be_false
      end

      it "makes sibling classes with a different variable, not equal" do
        class_one = EqualizeTest::SimpleClassOne.new(15)
        class_two = EqualizeTest::SimpleClassTwo.new(16)
        expect(class_one == class_two).to be_false
      end

      it "makes sibling classes with the same variable, equal" do
        class_one = EqualizeTest::SimpleClassOne.new(15)
        class_two = EqualizeTest::SimpleClassTwo.new(15)
        expect(class_one == class_two).to be_true
      end
    end

    context "strict is true" do
      it "makes parent and child classes with the same variable, not equal" do
        class_one = EqualizeTest::StrictBase.new(15)
        class_two = EqualizeTest::StrictClassOne.new(15)
        expect(class_one == class_two).to be_false
      end

      it "makes sibling classes with the same variable, not equal" do
        class_one = EqualizeTest::StrictClassOne.new(15)
        class_two = EqualizeTest::StrictClassTwo.new(15)
        expect(class_one == class_two).to be_false
      end
    end
  end

  describe "macro alias_method" do
    it "creates an alias to a method" do
      a = AliasClass.new
      t1 = a.concatenate("Hello", "world")
      t2 = a.concat("Hello", "world")
      expect(t1).to eq(t2)
    end
  end
end
