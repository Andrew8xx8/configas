require 'spec_helper'

describe Configas do 
  it "key should be value" do
    value = "test value"

    configas = Configas.build :development do 
      env :development do
        key value
        nil_key nil
      end
    end

    configas.key.should == value
    configas.nil_key.should == nil
  end

  it ":key => {:subkey} should be value" do
    value = "test value"

    configas = Configas.build :development do 
      env :development do
        key do
          subkey value
        end
      end
    end

    configas.key.subkey.should == value
    configas.key.class.should == Configas::Config
  end

  it "key.to_hash should be value" do
    value = "test value"

    configas = Configas.build :development do 
      env :development do
        key do
          subkey value
        end
      end
    end

    configas.key.to_hash.should == { subkey: value }
  end

  it "[key] should be value" do
    value = "test value"

    configas = Configas.build :development do 
      env :development do
        key value
      end
    end

    configas[:key].should == value
  end

  it "development should be child for production" do
    value = "test value"

    configas = Configas.build :development do 
      env :production do
        key do
          subkey value
        end
      end

      env :development, :parent => :production
    end

    configas.key.subkey.should == value
  end

  it "keys should be after merging" do
    parent_value = "parent"
    child_value = "child"
    value = "test value"

    configas = Configas.build :development do 
      env :production do
        parent_key parent_value

        key1 do
          subkey value
        end
      end

      env :development, :parent => :production do
        child_key child_value

        key do
          subkey value
        end
      end
    end

    configas.parent_key.should == parent_value
    configas.child_key.should == child_value
    configas.key.subkey.should == value
    configas.key1.subkey.should == value
  end

  it "keys should be after merging with redefine" do
    parent_value = "parent"
    child_value = "child"

    configas = Configas.build :development do 
      env :production do
        key1 parent_value

        key do
          subkey parent_value
        end
      end

      env :development, :parent => :production do
        key1 child_value

        key do
          subkey child_value
        end
      end
    end

    configas.key.subkey.should == child_value
    configas.key1.should == child_value
  end

  it "keys should be after merging with redefine" do
    parent_value = "parent"
    child_value = "child"

    configas = Configas.build :development do 
      env :production, :parent => :development do
        key1 parent_value

        key do
          subkey parent_value
        end
      end

      env :development, :parent => :production do
        key1 child_value

        key do
          subkey child_value
        end
      end
    end

    configas.key.subkey.should == child_value
    configas.key1.should == child_value
  end
end