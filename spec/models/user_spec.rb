require 'spec_helper'

describe User do
  it { should respond_to(:security_answer)               }
  it { should respond_to(:security_answer=)              }
  it { should respond_to(:security_answer_confirmation)  }
  it { should respond_to(:security_answer_confirmation=) }
  it { should respond_to(:authenticate_security_answer)  }

  it 'should confirm security answer' do
    subject.security_answer = 'hello there'
    subject.security_answer_confirmation = 'there hello'
    subject.valid?
    subject.errors[:security_answer_confirmation].should include("doesn't match Security answer")
  end

  it 'should not confirm security answer if not given' do
    subject.security_answer = nil
    subject.security_answer_confirmation = 'there hello'
    subject.valid?
    subject.errors[:security_answer_confirmation].should be_blank
  end

  it 'should require security answer on create' do
    subject.should be_new_record
    subject.security_answer = nil
    subject.valid?
    subject.errors[:security_answer].should include("can't be blank")
  end

  it 'should require security answer confirmation if security answer given ' do
    subject.security_answer = 'hello there'
    subject.valid?
    subject.errors[:security_answer_confirmation].should include "can't be blank"
  end

  it 'should not require security answer confirmation if security answer is not given' do
    subject.security_answer = ''
    subject.valid?
    subject.errors[:security_answer_confirmation].should be_blank
  end

  it 'should require security answer digest on create' do
    subject.should be_new_record
    subject.security_answer_digest = ''
    subject.password = '1234'
    subject.password_confirmation = '1234'
    subject.security_answer = '1234'
    subject.security_answer_confirmation = '1234'
    subject.username = 'username'

    # change the security_answer_digest to verify the test
    subject.security_answer_digest = ''
    lambda do
      begin
        subject.save!
      rescue Exception => ex
        ex.message.should include("security_answer_digest missing on new record")
        raise
      end
    end.should raise_error RuntimeError
  end

  it 'should not require security answer digest on update' do
    subject.should be_new_record
    subject.send :security_answer_digest=, ''
    subject.password = '1234'
    subject.password_confirmation = '1234'
    subject.security_answer = '1234'
    subject.security_answer_confirmation = '1234'
    subject.username = 'username'

    subject.save!

    # change the security_answer_digest to verify the test
    subject.send :security_answer_digest=, ''

    subject.save!

    subject.reload
    subject.security_answer_digest.should be_blank
  end

  it 'should not allow to call security answer digest directly if protect setter for digest is true' do
    pending
  end

  it 'should allow to call security answer digest directly if protect setter for digest is false' do
    pending
  end

  it 'should allow to call security answer digest directly if protect setter for digest is not given as option' do
    lambda do
      subject.security_answer_digest = 'hello'
    end.should_not raise_error NoMethodError
  end

  describe "#security_answer=" do
    it 'should set the security answer and save it encrypted' do
      user = FactoryGirl.create :user, security_answer: 'old answer', security_answer_confirmation: 'old answer'
      user.security_answer_digest.should_not be_blank
      old_security_answer_digest = user.security_answer_digest

      user.security_answer = 'new answer'
      user.security_answer_confirmation = 'new answer'
      user.instance_variable_get(:@security_answer).should == 'new answer'
      user.save!
      user.security_answer_digest.should_not be_blank
      user.security_answer_digest.should_not == old_security_answer_digest
    end
  end

  describe '#authenticate_security_answer' do
    it 'should return subject if security answer given matches the one stored' do
      user = FactoryGirl.create :user, security_answer: 'some answer', security_answer_confirmation: 'some answer'
      user.authenticate_security_answer('some answer').should eq user
    end

    it 'should return false if security answer given does not match the one stored' do
      user = FactoryGirl.create :user, security_answer: 'some answer', security_answer_confirmation: 'some answer'
      user.authenticate_security_answer('some other answer').should be_false
    end
  end
end